//
//  ApiManager.h
//  Avia Tickets
//
//  Created by Марат Нургалиев on 24/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Feed.h"
#import "Enums.h"
#import "Ticket.h"
#import "DataManager.h"


@interface ApiManager : NSObject
    
    + (instancetype)sharedInstance;

    - (void)cityForCurrentIP:(void (^)(City *city))completion;
    
    - (void)ticketsWithRequest:(SearchRequest)request withCompletion:(void (^)(NSArray *tickets))completion;
    
    - (void)feedsWithRequest:(NSString*)searchString withCompletion:(void (^)(NSArray *feeds))completion;

@end

