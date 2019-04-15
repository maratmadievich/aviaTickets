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
//
//
//- (void)setup {
//    
//    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TicketsDataModel" withExtension:@"momd"];
//    
//    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
//    
//    NSURL *docsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
//    
//    NSURL *storeURL = [docsURL URLByAppendingPathComponent:@"TicketsDataModel.sqlite"];
//    
//    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
//    
//    NSPersistentStore* store = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:nil];
//    
//    if (!store) {
//        
//        abort();
//    }
//    
//    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
//    
//    _managedObjectContext.persistentStoreCoordinator = _persistentStoreCoordinator;
//}
//
//
//- (void)save {
//    
//    NSError *error;
//    
//    [_managedObjectContext save: &error];
//    
//    if (error) {
//        
//        NSLog(@"%@", [error localizedDescription]);
//    }
//    
//}
//
//
//#pragma mark - Work with Tickets
//

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


//typedef void(^isFavorite)(BOOL):(Ticket *)ticket;


- (BOOL)isFavorite:(Ticket *)ticket {

    [self returnFavorite:ticket withCompletion:^(CKRecord *favoriteTicket) {
        
        return favoriteTicket == NULL ? true : false;
    }];
}


//bool (^findFavorite)(Ticket *) = ^(Ticket *ticket) {
//
//    CKContainer *container = [CKContainer defaultContainer];
//
//        CKDatabase *privateDatabase = [container privateCloudDatabase];
//
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"price == %ld AND airline == %@ AND from == %@ AND to == %@ AND departure == %@ AND expires == %@ AND flightNumber == %ld", (long)ticket.price.integerValue, ticket.airline, ticket.from, ticket.to, ticket.departure, ticket.expires, (long)ticket.flightNumber.integerValue];
//
//        CKQuery *query = [[CKQuery alloc] initWithRecordType:@"Tickets" predicate:predicate];
//
//

//        [privateDatabase performQuery:query inZoneWithID:nil completionHandler:^(NSArray<CKRecord *> * _Nullable results, NSError * _Nullable error) {
//
//            if (error) {
//
//                return false;
//            }
//            else {
//
//                return results.count > 0 ? true : false;
//            }
//        }];
//};


//
//
//- (void)removeFromFavorite:(Ticket *)ticket {
//
//    FavoriteTicket *favorite = [self favoriteFromTicket:ticket];
//
//    if (favorite) {
//
//        [_managedObjectContext deleteObject:favorite];
//
//        [self save];
//    }
//
//}

- (void)returnFavorite:(Ticket *)ticket withCompletion:(void (^)(CKRecord * _Nullable favoriteTicket))completion {
    
    CKContainer *container = [CKContainer defaultContainer];
    
    CKDatabase *publicDatabase = [container publicCloudDatabase];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"price == %ld AND airline == %@ AND from == %@ AND to == %@ AND departure == %@ AND expires == %@ AND flightNumber == %ld", (long)ticket.price.integerValue, ticket.airline, ticket.from, ticket.to, ticket.departure, ticket.expires, (long)ticket.flightNumber.integerValue];
    
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
                
                completion(results[0]);
            });
        }
        
    }];

}


- (void)favorites:(void (^)(NSArray *favorites))completion {
    
    CKContainer *container = [CKContainer defaultContainer];

    CKDatabase *publicDatabase = [container publicCloudDatabase];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"price > 0"];//, @"Today publication"//@"from = %@", @"TSE"

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

