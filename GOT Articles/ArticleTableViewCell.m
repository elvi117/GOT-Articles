//
//  ArticleTableViewCell.m
//  GOT Articles
//
//  Created by Lukasz Matuszczak on 08/08/16.
//  Copyright © 2016 Lukasz Matuszczak. All rights reserved.
//

#import "ArticleTableViewCell.h"


@interface ArticleTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *thumbnailLabel;
@property (weak, nonatomic) IBOutlet UILabel *abstractLabel;
@property (weak, nonatomic) IBOutlet UIButton *favouriteButtonOutlet;
@property ( nonatomic) NSInteger index;
@property (nonatomic) Boolean isFavourite;

@end

@implementation ArticleTableViewCell

- (IBAction)favouriteButtonClick:(id)sender {
    self.isFavourite = !self.isFavourite;
    if (self.isFavourite) {
        [self.favouriteButtonOutlet setTitle:@"jest" forState:UIControlStateNormal];
    }
    else
        [self.favouriteButtonOutlet setTitle:@"nie" forState:UIControlStateNormal];
    
    [self.delegateMethod forwardIndex:self.index isFavourite:self.isFavourite ];

}

-(void) setArticleObject: (Article*) articleObject index: (NSInteger) index isFavourite: (Boolean) is{
    self.isFavourite = is;
    self.titleLabel.text = [articleObject title];
    self.thumbnailLabel.text = [articleObject thumbnail];
    self.abstractLabel.text = [articleObject abstract];
    self.index = index;
    
    if (self.isFavourite) {
        [self.favouriteButtonOutlet setTitle:@"jest" forState:UIControlStateNormal];
    }
    else
        [self.favouriteButtonOutlet setTitle:@"nie" forState:UIControlStateNormal];

    
    
}


@end
