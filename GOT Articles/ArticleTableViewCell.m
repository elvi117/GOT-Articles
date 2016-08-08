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

@end

@implementation ArticleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)favouriteButtonClick:(id)sender {
}

-(void) setValues_ForTitle:(NSString*) title ForThumbnail: (NSString*) thumbnail ForAbstract: (NSString*) abstract{
    self.titleLabel.text = title;
    self.thumbnailLabel.text = thumbnail;
    self.abstractLabel.text = abstract;

}
@end
