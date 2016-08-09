//
//  ArticleTableViewCell.h
//  GOT Articles
//
//  Created by Lukasz Matuszczak on 08/08/16.
//  Copyright © 2016 Lukasz Matuszczak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"
#import "FavouriteProtocol.h"

@interface ArticleTableViewCell : UITableViewCell

@property (weak) id <FavouriteProtocol> delegateMethod;


-(void) setArticleObject: (Article*) articleObject index: (NSInteger) index isFavourite: (Boolean) is;

@end
