//
//  Article.m
//  GOT Articles
//
//  Created by Lukasz Matuszczak on 08/08/16.
//  Copyright © 2016 Lukasz Matuszczak. All rights reserved.
//

#import "Article.h"

@implementation Article

-(instancetype) init:(NSString*) title ForThumbnail: (NSString*) thumbnail ForAbstract: (NSString*) abstract{
    self = [super init];
    if (self!=nil) {
        self.title = title;
        self.thumbnail = thumbnail;
        self.abstract = abstract;
    }
    
    return self;
}


@end
