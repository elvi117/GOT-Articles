//
//  Article.h
//  GOT Articles
//
//  Created by Lukasz Matuszczak on 08/08/16.
//  Copyright © 2016 Lukasz Matuszczak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject
-(instancetype) init:(NSString*) title ForThumbnail: (NSString*) thumbnail ForAbstract: (NSString*) abstract;
@end
