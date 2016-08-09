//
//  DetailViewController.h
//  GOT Articles
//
//  Created by Lukasz Matuszczak on 09/08/16.
//  Copyright © 2016 Lukasz Matuszczak. All rights reserved.
//

#import "ViewController.h"

@interface DetailViewController : ViewController

@property (weak) id <FavouriteProtocol> delegateMethod;
@property (nonatomic) Boolean isFavourite;
@end
