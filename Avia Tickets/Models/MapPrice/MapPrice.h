//
//  MapPrice.h
//  Avia Tickets
//
//  Created by Марат Нургалиев on 27/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "City.h"
#import "DataManager.h"

@interface MapPrice : NSObject

    @property (strong, nonatomic) City *destination;

    @property (strong, nonatomic) City *origin;

    @property (strong, nonatomic) NSDate *departure;

    @property (strong, nonatomic) NSDate *returnDate;

    @property (nonatomic) NSInteger numberOfChanges;

    @property (nonatomic) NSInteger value;

    @property (nonatomic) NSInteger distance;

    @property (nonatomic) BOOL actual;


    - (instancetype)initWithDictionary:(NSDictionary *)dictionary withOrigin: (City *)origin;

@end
