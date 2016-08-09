//
//  DetailViewController.m
//  GOT Articles
//
//  Created by Lukasz Matuszczak on 09/08/16.
//  Copyright © 2016 Lukasz Matuszczak. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *thumbnailLabel;
@property (weak, nonatomic) IBOutlet UILabel *abstractLabel;
@property (weak, nonatomic) IBOutlet UIButton *favouriteButtonOutlet;
@end

@implementation DetailViewController
-(void) viewDidLoad{
    [super viewDidLoad];
    self.titleLabel.text = [self.articleObject title];
    self.thumbnailLabel.text = [self.articleObject thumbnail];
    self.abstractLabel.text = [self.articleObject abstract];
}
- (IBAction)favouriteButtonClick:(id)sender {
    self.isFavourite = !self.isFavourite;
    [self.delegateMethod forwardIndex:self.index isFavourite:self.isFavourite];

}
- (IBAction)openURLInSafariClick:(id)sender {
    NSLog(@"%ld", (long)self.index);
    
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://gameofthrones.wikia.com/wiki/%@",[self.titleLabel.text stringByReplacingOccurrencesOfString:@" " withString:@"_"]]]];
}

@end
