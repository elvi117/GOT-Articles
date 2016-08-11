//
//  ViewController.m
//  GOT Articles
//
//  Created by Lukasz Matuszczak on 08/08/16.
//  Copyright © 2016 Lukasz Matuszczak. All rights reserved.
//

#import "ViewController.h"
#import "ArticleTableViewCell.h"
#import "Article.h"
#import "DetailViewController.h"
#import "FetchDataFromRemote.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *filterDataButtonOutlet;

@property (strong, nonatomic) NSMutableArray* arrayOfArticles;
@property (strong, nonatomic) NSMutableArray* arrayOfFavourites;
@property (strong, nonatomic) NSMutableArray* arrayWithIndexOfCellWithMoreHeight;
@property ( nonatomic) Boolean showFavourites;
@property (strong, nonatomic) UILongPressGestureRecognizer* cellPress;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showFavourites = false;
    self.arrayOfArticles = [[NSMutableArray alloc] init];
    self.arrayOfFavourites = [[NSMutableArray alloc] init];
    self.arrayWithIndexOfCellWithMoreHeight = [[NSMutableArray alloc] init];
    
    [self callForDataFromWevService];
    
    UILongPressGestureRecognizer* longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPress:)];
    [self.myTableView addGestureRecognizer:longPressRecognizer];
   
}

//MARK: Connect To Webservice
-(void) callForDataFromWevService{
    [FetchDataFromRemote fetchDataFromRemote:self.arrayOfArticles :^(Boolean answer) {
        if(answer)
        {dispatch_async(dispatch_get_main_queue(), ^{
            [self.myTableView reloadData];
        }); }

        else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self showAlert];
            });}
    }] ;

}

//MARK:UIAlerViewDelegate
-(void) showAlert{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network error"
                                                    message:@"Check your network connection"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self callForDataFromWevService];
}

//MARK: GestuRecognition
- (void)onLongPress:(UILongPressGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        CGPoint point = [sender locationInView:self.myTableView];
        NSIndexPath* indexPath = [self.myTableView indexPathForRowAtPoint:point];
        if (indexPath != nil) {
            if (![self.arrayWithIndexOfCellWithMoreHeight containsObject: [NSNumber numberWithLong: indexPath.row]])
                [self.arrayWithIndexOfCellWithMoreHeight addObject: [NSNumber numberWithLong: indexPath.row]];
            else
                [self.arrayWithIndexOfCellWithMoreHeight removeObject: [NSNumber numberWithLong: indexPath.row]];
            [self.myTableView beginUpdates];
            [self.myTableView endUpdates];
        }
    }
}

//MARK: TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.showFavourites)
          return [self.arrayOfFavourites count];
    else
          return [self.arrayOfArticles count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Article"];
    Boolean arrayExistFavouriteObject = [self.arrayOfFavourites containsObject:[self.arrayOfArticles objectAtIndex:indexPath.row ]];
    if (!self.showFavourites)
         [cell setArticleObject:[self.arrayOfArticles objectAtIndex:indexPath.row ] index: indexPath.row isFavourite: arrayExistFavouriteObject];
     else
         [cell setArticleObject:[self.arrayOfFavourites objectAtIndex:indexPath.row ] index: indexPath.row isFavourite: true] ;
    
    cell.delegateMethod = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"segueID" sender: [NSNumber numberWithInteger:indexPath.row] ];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    int rowHeight;
    if ([self.arrayWithIndexOfCellWithMoreHeight containsObject: [NSNumber numberWithLong: indexPath.row]]) {
        ArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Article"];
       CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
        CGRect textRect = [cell.abstractLabel.text boundingRectWithSize:maximumLabelSize
                                                 options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading
                                              attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]}
                                                 context:nil];
        rowHeight = textRect.size.height + cell.frame.size.height+30;
        ;
    } else rowHeight = 125.0f;
    return rowHeight;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *destinationViewController = segue.destinationViewController;
    
    if (!self.showFavourites) {
        destinationViewController.articleObject = [self.arrayOfArticles objectAtIndex:[sender integerValue]];
        destinationViewController.isFavourite = [self.arrayOfFavourites containsObject:[self.arrayOfArticles objectAtIndex:[sender integerValue]]];
    }
    else{
        destinationViewController.articleObject = [self.arrayOfFavourites objectAtIndex:[sender integerValue]];
        destinationViewController.isFavourite = true;
        
    }
    
    destinationViewController.index = [sender integerValue];
    destinationViewController.delegateMethod =self;
}

//MARK: FavouriteDelegate
-(void) forwardIndex: (NSInteger) index isFavourite: (Boolean) is{
    if(!self.showFavourites){
    if (is)
        [self.arrayOfFavourites addObject:[self.arrayOfArticles objectAtIndex:index]];
    else
        [self.arrayOfFavourites removeObject:[self.arrayOfArticles objectAtIndex:index]];}
    else
        [self.arrayOfFavourites removeObjectAtIndex:index];
    
    [self.myTableView reloadData];
}

//MARK: Buttons actions
- (IBAction)filterDataButtonClick:(id)sender {
    self.showFavourites = !self.showFavourites;
    switch (self.showFavourites) {
        case true:
            [self.filterDataButtonOutlet setTitle:@"Show All" forState:UIControlStateNormal];
            break;
            
        case false:
            [self.filterDataButtonOutlet setTitle:@"Show Favourites" forState:UIControlStateNormal];
            break;
    }
    
    [self.arrayWithIndexOfCellWithMoreHeight removeAllObjects];
    [self.myTableView reloadData];
    
}

@end
