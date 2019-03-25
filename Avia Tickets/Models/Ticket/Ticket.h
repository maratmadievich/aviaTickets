//
//  Ticket.h
//  Avia Tickets
//
//  Created by Марат Нургалиев on 24/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ticket : NSObject

    @property (nonatomic, strong) NSNumber *price;
    
    @property (nonatomic, strong) NSString *airline;
    
    @property (nonatomic, strong) NSDate *departure;
    
    @property (nonatomic, strong) NSDate *expires;
    
    @property (nonatomic, strong) NSNumber *flightNumber;
    
    @property (nonatomic, strong) NSDate *returnDate;
    
    @property (nonatomic, strong) NSString *from;
    
    @property (nonatomic, strong) NSString *to;
    

    - (instancetype)initWithDictionary:(NSDictionary *)dictionary;
    
@end

