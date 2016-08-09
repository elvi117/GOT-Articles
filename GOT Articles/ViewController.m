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
    
    [self fetchDataFromRemote];
    UILongPressGestureRecognizer* longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPress:)];
    [self.myTableView addGestureRecognizer:longPressRecognizer];
   
}

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


-(void) fetchDataFromRemote{

    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:@"http://gameofthrones.wikia.com/api/v1/Articles/Top?expand=1&category=Characters&limit=75"]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if (data.length > 0 && error == nil)
                {
                    NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:0
                                                                               error:NULL];
                    NSMutableArray * a=  [[greeting objectForKey:@"items"]  mutableCopy];
              
                    for (NSString * i  in a) {
                        
                        Article* tmp = [[Article alloc] init:[i valueForKey:@"title"]  ForThumbnail:[i valueForKey:@"thumbnail"] ForAbstract:[i valueForKey:@"abstract"]];
                        [self.arrayOfArticles addObject:tmp];
                        
                        
                    }
                   
                }
                [self.myTableView reloadData];
            }] resume];

}

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *destinationViewController = segue.destinationViewController;
   
destinationViewController.articleObject = [self.arrayOfArticles objectAtIndex:[sender integerValue]];
    destinationViewController.index = [sender integerValue];
    if(!self.showFavourites)
    destinationViewController.isFavourite = [self.arrayOfFavourites containsObject:[self.arrayOfArticles objectAtIndex:[sender integerValue]]];
   else
       destinationViewController.isFavourite = true;
    
    destinationViewController.delegateMethod =self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    int rowHeight;
    if ([self.arrayWithIndexOfCellWithMoreHeight containsObject: [NSNumber numberWithLong: indexPath.row]]) {
        ArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Article"];
       
        
        rowHeight = cell.frame.size.height;
        ;
    } else rowHeight = 125.0f;
    return rowHeight;
}


-(void) forwardIndex: (NSInteger) index isFavourite: (Boolean) is{
    if(!self.showFavourites){
    if (is)
        [self.arrayOfFavourites addObject:[self.arrayOfArticles objectAtIndex:index]];
    else
        [self.arrayOfFavourites removeObject:[self.arrayOfArticles objectAtIndex:index]];}
    else
        [self.arrayOfFavourites removeObjectAtIndex:index];
    
    [self.myTableView reloadData];
    NSLog(@"%@", self.arrayOfFavourites);
}

- (IBAction)filterDataButtonClick:(id)sender {
    self.showFavourites = !self.showFavourites;
    [self.arrayWithIndexOfCellWithMoreHeight removeAllObjects];
    [self.myTableView reloadData];
    
}

@end
