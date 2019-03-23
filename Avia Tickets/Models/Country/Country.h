//
//  Country.h
//  Avia Tickets
//
//  Created by Марат Нургалиев on 23/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Country : NSObject

    @property (nonatomic, strong) NSString *name;
    
    @property (nonatomic, strong) NSString *currency;
    
    @property (nonatomic, strong) NSDictionary *translations;
    
    @property (nonatomic, strong) NSString *code;
    

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
