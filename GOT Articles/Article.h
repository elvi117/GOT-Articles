//
//  Article.h
//  GOT Articles
//
//  Created by Lukasz Matuszczak on 08/08/16.
//  Copyright © 2016 Lukasz Matuszczak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* thumbnail;
@property (strong, nonatomic) NSString* abstract;

-(instancetype) init:(NSString*) title ForThumbnail: (NSString*) thumbnail ForAbstract: (NSString*) abstract;

@end
