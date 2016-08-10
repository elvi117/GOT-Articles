//
//  FetchDataFromRemote.h
//  GOT Articles
//
//  Created by Lukasz Matuszczak on 10/08/16.
//  Copyright © 2016 Lukasz Matuszczak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Article.h"

typedef void(^completionBlock)(Boolean);

@interface FetchDataFromRemote : NSObject

+(void) fetchDataFromRemote:(NSMutableArray*)arrayToFill :(completionBlock) completionBlock;

@end
