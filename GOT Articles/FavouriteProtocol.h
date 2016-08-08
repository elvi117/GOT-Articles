//
//  FavouriteProtocol.h
//  GOT Articles
//
//  Created by Lukasz Matuszczak on 08/08/16.
//  Copyright © 2016 Lukasz Matuszczak. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FavouriteProtocol <NSObject>
@required
-(void) forwardIndex: (NSInteger) index;
@end
