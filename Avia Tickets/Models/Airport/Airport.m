//
//  Airport.m
//  Avia Tickets
//
//  Created by Марат Нургалиев on 23/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import "Airport.h"

@implementation Airport
    
    - (instancetype)initWithDictionary:(NSDictionary *)dictionary {
        
        self = [super init];
        
        if (self) {
        
            _timezone = [dictionary valueForKey:@"time_zone"];
            
            _translations = [dictionary valueForKey:@"name_translations"];
            
            _name = [dictionary valueForKey:@"name"];
            
            _countryCode = [dictionary valueForKey:@"country_code"];
            
            _cityCode = [dictionary valueForKey:@"city_code"];
            
            _code = [dictionary valueForKey:@"code"];
            
            _flightable = [dictionary valueForKey:@"flightable"];
            
            NSDictionary *coords = [dictionary valueForKey:@"coordinates"];
            
            if (coords && ![coords isEqual:[NSNull null]]) {
            
                NSNumber *lon = [coords valueForKey:@"lon"];
                
                NSNumber *lat = [coords valueForKey:@"lat"];
                
                if (![lon isEqual:[NSNull null]] && ![lat isEqual:[NSNull null]]) {
                
                    _coordinate = CLLocationCoordinate2DMake([lat doubleValue], [lon doubleValue]);
                }
                
            }
            
        }
        
        return self;
    }


- (void)localizeName {
    
    if (!_translations) return;
    
    NSLocale *locale = [NSLocale currentLocale];
    
    NSString *localeId = [locale.localeIdentifier substringToIndex:2];
    
    if (localeId) {
    
        if ([_translations valueForKey: localeId]) {
        
            self.name = [_translations valueForKey: localeId];
        }
        
    }
    
}



@end
