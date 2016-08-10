//
//  FetchDataFromRemote.m
//  GOT Articles
//
//  Created by Lukasz Matuszczak on 10/08/16.
//  Copyright © 2016 Lukasz Matuszczak. All rights reserved.
//

#import "FetchDataFromRemote.h"

@implementation FetchDataFromRemote

+(void) fetchDataFromRemote:(NSMutableArray*)arrayToFill :(completionBlock) completionBlock{
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:@"http://gameofthrones.wikia.com/api/v1/Articles/Top?expand=1&category=Characters&limit=75"]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if (data.length > 0 && error == nil)
                {
                    NSDictionary *dictionaryWithremoteJSONData = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                    NSMutableArray * parseOnlyItems=  [[dictionaryWithremoteJSONData objectForKey:@"items"]  mutableCopy];
                    
                    for (NSString * i in parseOnlyItems){
                        Article* tmp = [[Article alloc] init:[i valueForKey:@"title"]  ForThumbnail:[i valueForKey:@"thumbnail"] ForAbstract:[i valueForKey:@"abstract"]];
                        [arrayToFill addObject:tmp];
                    }
                    completionBlock(true);
                }
                else{
                    completionBlock(false);
                }
            }]resume];
}


@end
