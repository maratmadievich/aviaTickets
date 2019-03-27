//
//  ApiManager.m
//  Avia Tickets
//
//  Created by Марат Нургалиев on 24/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import "ApiManager.h"

#define API_TOKEN @"78ff992a36b410676c29a8205333905d"
#define API_URL_IP_ADDRESS @"https://api.ipify.org/?format=json"
#define API_URL_CHEAP @"https://api.travelpayouts.com/v1/prices/cheap"
#define API_URL_CITY_FROM_IP @"https://www.travelpayouts.com/whereami?ip="

#define NEWS_TOKEN @"ad0beea164474522848f27c456cca0c5"
#define NEWS_API_URL @"https://newsapi.org/v2/top-headlines"


#define API_URL_MAP_PRICE @"https://map.aviasales.ru/prices.json?"

//#define API_URL_MAP_PRICE @"https://map.aviasales.ru/supported_directions.json?one_way=false&locale=ru&origin_iata="


@implementation ApiManager

    + (instancetype)sharedInstance {
        
        static ApiManager *instance;
        
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
           
            instance = [[ApiManager alloc] init];
        });
        
        return instance;
    }
    
    
    - (void)cityForCurrentIP:(void (^)(City *city))completion {
        
        [self IPAddressWithCompletion:^(NSString *ipAddress) {
           
            [self load:[NSString stringWithFormat:@"%@%@", API_URL_CITY_FROM_IP, ipAddress] withCompletion:^(id  _Nullable result) {
                
                NSDictionary *json = result;
                
                NSString *iata = [json valueForKey:@"iata"];
                
                if (iata) {
                  
                    City *city = [[DataManager sharedInstance] cityForIATA:iata];
                   
                    if (city) {
                       
                        dispatch_async(dispatch_get_main_queue(), ^{
                          
                            completion(city);
                        });
                        
                    }
                    
                }
                
            }];
            
        }];
        
    }
    
    
    - (void)IPAddressWithCompletion:(void (^)(NSString *ipAddress))completion {
    
        [self load:API_URL_IP_ADDRESS withCompletion:^(id  _Nullable result) {
       
            NSDictionary *json = result;
       
            completion([json valueForKey:@"ip"]);
        }];
    }
    
    
    - (void)load:(NSString *)urlString withCompletion:(void (^)(id _Nullable result))completion {
    
        dispatch_async(dispatch_get_main_queue(), ^{
        
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        });
        
        [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
           
            dispatch_async(dispatch_get_main_queue(), ^{
            
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            });
            
            completion([NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil]);
        }] resume];
        
    }
    
    
    - (void)ticketsWithRequest:(SearchRequest)request withCompletion:(void (^)(NSArray *tickets))completion {
    
            NSString *urlString = [NSString stringWithFormat:@"%@?%@&token=%@", API_URL_CHEAP, SearchRequestQuery(request), API_TOKEN];
    
            [self load:urlString withCompletion:^(id  _Nullable result) {
        
            NSDictionary *response = result;
        
            if (response) {
            
                NSDictionary *json = [[response valueForKey:@"data"] valueForKey:request.destionation];
            
                NSMutableArray *array = [NSMutableArray new];
            
                for (NSString *key in json) {
                
                    NSDictionary *value = [json valueForKey: key];
                
                    Ticket *ticket = [[Ticket alloc] initWithDictionary:value];
                
                    ticket.from = request.origin;
                
                    ticket.to = request.destionation;
                
                    [array addObject:ticket];
                }
            
                dispatch_async(dispatch_get_main_queue(), ^{
                  
                    completion(array);
                });
                
            }
            
        }];
        
    }
    
    
    NSString * SearchRequestQuery(SearchRequest request) {
       
        NSString *result = [NSString stringWithFormat:@"origin=%@&destination=%@", request.origin, request.destionation];
       
        if (request.departDate && request.returnDate) {
           
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
          
            dateFormatter.dateFormat = @"yyyy-MM";
           
            result = [NSString stringWithFormat:@"%@&depart_date=%@&return_date=%@", result, [dateFormatter stringFromDate:request.departDate], [dateFormatter stringFromDate:request.returnDate]];
        }
        
        return result;
    }
    
    
    - (void)feedsWithRequest:(NSString*)searchString withCompletion:(void (^)(NSArray *feeds))completion {
        
//        NSString *urlString = [NSString stringWithFormat:@"%@?sources=%@&apiKey=%@", NEWS_API_URL, searchString, NEWS_TOKEN];
        NSString *urlString = [NSString stringWithFormat:@"%@?country=%@&apiKey=%@", NEWS_API_URL, searchString, NEWS_TOKEN];
        
        [self load:urlString withCompletion:^(id  _Nullable result) {
            
            NSDictionary *response = result;
            
            if (response) {
                
                NSDictionary *json = [response valueForKey:@"articles"];
                
                NSMutableArray *array = [NSMutableArray new];
                
                for (NSDictionary *key in json) {

                    Feed *feed = [[Feed alloc] initWithDictionary:key];
                    
                    [array addObject:feed];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    completion(array);
                });
                
            }
            
        }];
        
    }
    

    - (void)mapPricesFor:(City *)origin withCompletion:(void (^)(NSArray *prices))completion {
        
        static BOOL isLoading;
        
        if (isLoading) { return; }
        
        isLoading = YES;
        
        [self load:[NSString stringWithFormat:@"%@%@", API_URL_MAP_PRICE, [self mapPricesKeys: origin.code]] withCompletion:^(id  _Nullable result) {
            
            NSLog(@"%@", result);
            
            NSArray *array = result;
            
            NSMutableArray *prices = [NSMutableArray new];
            
            if (array) {
            
                for (NSDictionary *mapPriceDictionary in array) {
                
                    MapPrice *mapPrice = [[MapPrice alloc] initWithDictionary:mapPriceDictionary withOrigin:origin];
                    
                    [prices addObject:mapPrice];
                }
                
                isLoading = NO;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                
                    completion(prices);
                });
                
            }
            
        }];
        
    }


    - (NSString *)mapPricesKeys:(NSString *)code {
        /*
        origin_iata — iata код пункта отправления. IATA код указывается буквами верхнего регистра, например MOW
        period — период дат для поиска:
        month — отображать только перелёты в указанном месяце (необходимо указывать дату начала месяца, например, 2017-01-01);
        season — отображать перелеты, входящие в сезон, указанного месяца (зима, весна, лето, осень);
        year — весь год (дату можно не указывать).
        direct — указывает на наличие перелетов без пересадок.
        one_way — «true» для перелетов в одну сторону, «false» для туда-обратно.
        no_visa — оплата не картой виза.
        schengen — возможность поменять билет.
        need_visa — требуется ли Visa.
        locale — язык поиска.
        min_trip_duration_in_days — минимальная продолжительность поездки (дней).
        max_trip_duration_in_days — максимальная продолжительность поездки (дней).
        */
        return [NSString stringWithFormat:@"direct=true&one_way=false&no_visa=true&schengen=true&need_visa=true&locale=ru&min_trip_duration_in_days=7&max_trip_duration_in_days=10&period=%@:season&origin_iata=%@", [self getFirstDateOfMonth], code];
        
    }

    - (NSString *)getFirstDateOfMonth {
    
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        dateFormatter.dateFormat = @"yyyy-MM";
        
        NSString* firstDayOfMonth = [dateFormatter stringFromDate: [NSDate date]];
        
        return [NSString stringWithFormat:@"%@-01", firstDayOfMonth];
    }








    


@end
