//
//  DetailViewController.h
//  GOT Articles
//
//  Created by Lukasz Matuszczak on 09/08/16.
//  Copyright © 2016 Lukasz Matuszczak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"
#import "FavouriteProtocol.h"

@interface DetailViewController : UIViewController

@property (weak) id <FavouriteProtocol> delegateMethod;

@property (nonatomic) Boolean isFavourite;
@property (readwrite, assign) NSInteger index;
@property (strong, nonatomic) Article* articleObject;
@end
