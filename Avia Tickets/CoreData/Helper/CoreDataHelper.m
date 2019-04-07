//
//  CoreDataHelper.m
//  Avia Tickets
//
//  Created by Admin on 4/4/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import "CoreDataHelper.h"

@interface CoreDataHelper ()

@end

@implementation CoreDataHelper

    + (instancetype)sharedInstance {
    
        static CoreDataHelper *instance;
        
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            
            instance = [[CoreDataHelper alloc] init];
            
            [instance setup];
        });
        
        return instance;
    }


    - (void)setup {
        
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TicketsDataModel" withExtension:@"momd"];
        
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        
        NSURL *docsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        
        NSURL *storeURL = [docsURL URLByAppendingPathComponent:@"TicketsDataModel.sqlite"];
        
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
        
        NSPersistentStore* store = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:nil];
        
        if (!store) {
            
            abort();
        }
        
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        _managedObjectContext.persistentStoreCoordinator = _persistentStoreCoordinator;
    }


    - (void)save {
       
        NSError *error;
        
        [_managedObjectContext save: &error];
        
        if (error) {
           
            NSLog(@"%@", [error localizedDescription]);
        }
        
    }


#pragma mark - Work with Tickets

- (BOOL)isFavorite:(Ticket *)ticket {
    
    return [self favoriteFromTicket: ticket] != nil;
}


- (FavoriteTicket *)favoriteFromTicket:(Ticket *)ticket {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteTicket"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"price == %ld AND airline == %@ AND from == %@ AND to == %@ AND departure == %@ AND expires == %@ AND flightNumber == %ld", (long)ticket.price.integerValue, ticket.airline, ticket.from, ticket.to, ticket.departure, ticket.expires, (long)ticket.flightNumber.integerValue];
    
    return [[_managedObjectContext executeFetchRequest:request error:nil] firstObject];
}


- (void)addToFavorite:(Ticket *)ticket {
    
    FavoriteTicket *favorite = [NSEntityDescription insertNewObjectForEntityForName:@"FavoriteTicket" inManagedObjectContext:_managedObjectContext];
    
    favorite.price = ticket.price.intValue;
    
    favorite.airline = ticket.airline;
    
    favorite.departure = ticket.departure;
    
    favorite.expires = ticket.expires;
    
    favorite.flightNumber = ticket.flightNumber.intValue;
    
    favorite.returnDate = ticket.returnDate;
    
    favorite.from = ticket.from;
    
    favorite.to = ticket.to;
    
    favorite.created = [NSDate date];
    
    [self save];
}


- (void)removeFromFavorite:(Ticket *)ticket {
    
    FavoriteTicket *favorite = [self favoriteFromTicket:ticket];
    
    if (favorite) {
        
        [_managedObjectContext deleteObject:favorite];
        
        [self save];
    }
    
}


- (NSArray *)favorites {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteTicket"];
    
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"created" ascending:NO]];
    
    return [_managedObjectContext executeFetchRequest:request error:nil];
}


#pragma mark - Work with MapPrices

    - (BOOL)isFavoriteMapPrice:(MapPrice *)mapPrice {
        
        return [self favoriteFromMapPrice: mapPrice] != nil;
    }


    - (FavoriteTicket *)favoriteFromMapPrice:(MapPrice *)mapPrice {
    
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteMapPrice"];
        
        request.predicate = [NSPredicate predicateWithFormat:@"destinationName == %@ AND destinationCode == %@ AND originName == %@ AND originCode == %@ AND departure == %@ AND returnDate == %@ AND numberOfChanges == %ld AND value == %ld AND distance == %ld", mapPrice.destination.name, mapPrice.destination.code, mapPrice.origin.name, mapPrice.origin.code, mapPrice.departure, mapPrice.returnDate, (long)mapPrice.numberOfChanges, (long)mapPrice.value, (long)mapPrice.distance];
        
        return [[_managedObjectContext executeFetchRequest:request error:nil] firstObject];
    }


    - (void)addToFavoriteMapPrice:(MapPrice *)mapPrice {
    
        FavoriteMapPrice *favorite = [NSEntityDescription insertNewObjectForEntityForName:@"FavoriteMapPrice" inManagedObjectContext:_managedObjectContext];
        
        favorite.destinationName = mapPrice.destination.name;
        
        favorite.destinationCode = mapPrice.destination.code;
        
        favorite.originName = mapPrice.origin.name;
        
        favorite.originCode = mapPrice.origin.code;
        
        favorite.departure = mapPrice.departure;
        
        favorite.returnDate = mapPrice.returnDate;
        
        favorite.numberOfChanges = mapPrice.numberOfChanges;
        
        favorite.value = mapPrice.value;
        
        favorite.distance = mapPrice.distance;
        
        favorite.actual = mapPrice.actual;
        
        [self save];
    }


    - (void)removeFromFavoriteMapPrice:(MapPrice *)mapPrice {
    
        FavoriteMapPrice *favorite = [self favoriteFromMapPrice:mapPrice];
        
        if (favorite) {
            
            [_managedObjectContext deleteObject:favorite];
            
            [self save];
        }
        
    }


    - (NSArray *)favoriteMapPrices {
    
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteMapPrice"];
        
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"departure" ascending:NO]];
        
        return [_managedObjectContext executeFetchRequest:request error:nil];
    }

@end

