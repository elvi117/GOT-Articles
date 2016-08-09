//
//  DetailViewController.m
//  GOT Articles
//
//  Created by Lukasz Matuszczak on 09/08/16.
//  Copyright © 2016 Lukasz Matuszczak. All rights reserved.
//

#import "DetailViewController.h"
#import "FavouriteProtocol.h"

@interface DetailViewController()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *thumbnailLabel;
@property (weak, nonatomic) IBOutlet UILabel *abstractLabel;

@property (nonatomic) NSInteger index;
@end

@implementation DetailViewController
- (IBAction)showFullArticleInSafariClick:(id)sender {
}
- (IBAction)likeOrUnlikeButtonClick:(id)sender {
    self.isFavourite = !self.isFavourite;
    [self.delegateMethod forwardIndex:self.index isFavourite:self.isFavourite];
}

@end
