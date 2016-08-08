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

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (strong, nonatomic) NSMutableArray* arrayOfArticles;
@property (strong, nonatomic) NSMutableArray* arrayOfFavourites;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayOfArticles = [[NSMutableArray alloc] init];
    [self fetchDataFromRemote];
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
    return [self.arrayOfArticles count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Article"];
    [cell setArticleObject:[self.arrayOfArticles objectAtIndex:indexPath.row ] index: indexPath.row];
    cell.delegateMethod = self;
    return cell;
}

-(void) forwardIndex:(NSInteger)index{
    NSLog(@"%ld", (long)index);
}

@end
