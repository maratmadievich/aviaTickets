//
//  New.h
//  Avia Tickets
//
//  Created by Марат Нургалиев on 24/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Feed : NSObject
    
    @property (nonatomic, strong) NSString *id;
    
    @property (nonatomic, strong) NSString *name;
    
    @property (nonatomic, strong) NSString *title;
    
    @property (nonatomic, strong) NSString *descript;
    
    @property (nonatomic, strong) NSString *url;
    
    @property (nonatomic, strong) NSString *urlToImage;
    
    @property (nonatomic, strong) NSString *publishedAt;
    
    @property (nonatomic, strong) NSString *content;
    
    @property (nonatomic, strong) NSString *author;
    
    
    - (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
