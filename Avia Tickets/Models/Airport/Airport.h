//
//  Airport.h
//  Avia Tickets
//
//  Created by Марат Нургалиев on 23/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <Foundation/Foundation.h>

@interface Airport : NSObject
    
    @property (nonatomic, strong) NSString *name;
    
    @property (nonatomic, strong) NSString *timezone;
    
    @property (nonatomic, strong) NSDictionary *translations;
    
    @property (nonatomic, strong) NSString *countryCode;
    
    @property (nonatomic, strong) NSString *cityCode;
    
    @property (nonatomic, strong) NSString *code;
    
    @property (nonatomic, getter=isFlightable) BOOL flightable;
    
    @property (nonatomic) CLLocationCoordinate2D coordinate;
    
    
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (void)localizeName;

@end

