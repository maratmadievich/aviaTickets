//
//  CloudManager.m
//  Avia Tickets
//
//  Created by Марат Нургалиев on 14/04/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import "CloudManager.h"

@interface CloudManager ()

@end

@implementation CloudManager

+ (instancetype)sharedInstance {
    
    static CloudManager *instance;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        instance = [[CloudManager alloc] init];
    });
    
    return instance;
}


#pragma mark - Work with Tickets

- (void)addToFavorite:(Ticket *)ticket {
    
    NSDate *currentDate = [NSDate date];
   
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    
    CKRecordID *publicationRecordID = [[CKRecordID alloc] initWithRecordName:[formatter stringFromDate:currentDate]];
    
    CKRecord *publicationRecord = [[CKRecord alloc] initWithRecordType:@"Tickets" recordID:publicationRecordID];
    
    publicationRecord[@"airline"] = ticket.airline;
    
    publicationRecord[@"created"] = currentDate;
    
    publicationRecord[@"departure"] = ticket.departure;
    
    publicationRecord[@"expires"] = ticket.expires;
    
    publicationRecord[@"flightNumber"] = ticket.flightNumber;
    
    publicationRecord[@"from"] = ticket.from;
    
    publicationRecord[@"price"] = ticket.price;
    
    publicationRecord[@"returnDate"] = ticket.returnDate;
    
    publicationRecord[@"to"] = ticket.to;
    
    
    CKContainer *container = [CKContainer defaultContainer];
    
    CKDatabase *publicDatabase = [container publicCloudDatabase];

    [publicDatabase saveRecord:publicationRecord completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
        
        if (error) {
           
            NSLog(@"Сохранение в iCloud: Что-то пошло не так. %@", error);
            
            return;
        }
        
        NSLog(@"Сохранение в iCloud: Сохранение прошло успешно");
    }];

}


- (void)isFavorite:(Ticket *)ticket withCompletion:(void (^)(BOOL isFavorite))completion {

    [self returnFavorite:ticket withCompletion:^(CKRecord *favoriteTicket) {
        
        completion(favoriteTicket != NULL ? true : false);
    }];
    
}


- (void)removeFromFavorite:(Ticket *)ticket {

    [self returnFavorite:ticket withCompletion:^(CKRecord *favoriteTicket) {
        
        CKContainer *container = [CKContainer defaultContainer];
        
        CKDatabase *publicDatabase = [container publicCloudDatabase];
        
        [publicDatabase deleteRecordWithID:favoriteTicket.recordID completionHandler:^(CKRecordID * _Nullable recordID, NSError * _Nullable error) {
            
            if (error) {
                
                // Ошибка
                NSLog(@"Удаление данных из iCloud: Что-то пошло не так. %@", error);
            }
            else {
                
                NSLog(@"Удаление данных из iCloud: Удаление прошло успешно");
            }
            
        }];
    }];

}

- (void)returnFavorite:(Ticket *)ticket withCompletion:(void (^)(CKRecord * _Nullable favoriteTicket))completion {
    
    CKContainer *container = [CKContainer defaultContainer];
    
    CKDatabase *publicDatabase = [container publicCloudDatabase];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"price == %ld AND airline == %@ AND from == %@ AND to == %@ AND flightNumber == %ld", (long)ticket.price.integerValue, ticket.airline, ticket.from, ticket.to, (long)ticket.flightNumber.integerValue];
    
    CKQuery *query = [[CKQuery alloc] initWithRecordType:@"Tickets" predicate:predicate];
    
    [publicDatabase performQuery:query inZoneWithID:nil completionHandler:^(NSArray<CKRecord *> * _Nullable results, NSError * _Nullable error) {
        
        if (error) {
            
            // Ошибка
            NSLog(@"Получение данных из iCloud: Что-то пошло не так. %@", error);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                completion(nil);
            });
        }
        else {
            
            NSLog(@"Получение данных из iCloud: Выгрузка прошла успешно");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                completion(results.count > 0 ? results[0] : nil);
            });
        }
        
    }];

}


- (void)favorites:(void (^)(NSArray *favorites))completion {
    
    CKContainer *container = [CKContainer defaultContainer];

    CKDatabase *publicDatabase = [container publicCloudDatabase];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"price > 0"];

    CKQuery *query = [[CKQuery alloc] initWithRecordType:@"Tickets" predicate:predicate];

    [publicDatabase performQuery:query inZoneWithID:nil completionHandler:^(NSArray<CKRecord *> * _Nullable results, NSError * _Nullable error) {

        if (error) {
            // Ошибка
            NSLog(@"Получение данных из iCloud: Что-то пошло не так. %@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                completion(nil);
            });
        }
        else {
            
             NSLog(@"Получение данных из iCloud: Выгрузка прошла успешно");

            dispatch_async(dispatch_get_main_queue(), ^{
                
                completion(results);
            });
        }

    }];

}

@end

