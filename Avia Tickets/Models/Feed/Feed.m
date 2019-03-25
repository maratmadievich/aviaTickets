//
//  New.m
//  Avia Tickets
//
//  Created by Марат Нургалиев on 24/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import "Feed.h"

@implementation Feed
    
    - (instancetype)initWithDictionary:(NSDictionary *)dictionary {
        
        self = [super init];
        
        if (self) {
            
            NSDictionary *source = [dictionary valueForKey:@"source"];
            
            if (source && ![source isEqual:[NSNull null]]) {
                
                _id = [source valueForKey:@"id"];
//                NSLog(@"id %@", _id);
                
                _name = [source valueForKey:@"name"];
//                NSLog(@"name %@", _name);
                
            }
            
            _title = [dictionary valueForKey:@"title"];
            
            _descript = [dictionary valueForKey:@"description"];
            
            _url = [dictionary valueForKey:@"url"];
            
            _urlToImage = [dictionary valueForKey:@"urlToImage"];
            
            _publishedAt = [dictionary valueForKey:@"publishedAt"];
            
            _content = [dictionary valueForKey:@"content"];
            
            NSLog(@"_content %@", _content);
            
            _author = [dictionary valueForKey:@"author"];
        }
        
        return self;
    }

@end
