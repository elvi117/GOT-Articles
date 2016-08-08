//
//  ArticleTableViewCell.h
//  GOT Articles
//
//  Created by Lukasz Matuszczak on 08/08/16.
//  Copyright © 2016 Lukasz Matuszczak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleTableViewCell : UITableViewCell
-(void) setValues_ForTitle:(NSString*) title ForThumbnail: (NSString*) thumbnail ForAbstract: (NSString*) abstract;
@end
