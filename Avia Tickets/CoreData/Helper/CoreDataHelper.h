//
//  CoreDataHelper.h
//  Avia Tickets
//
//  Created by Admin on 4/4/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "Ticket.h"
#import "MapPrice.h"
#import "DataManager.h"
#import "FavoriteTicket+CoreDataClass.h"
#import "FavoriteMapPrice+CoreDataClass.h"

@interface CoreDataHelper : NSObject

    + (instancetype)sharedInstance;


    @property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

    @property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

    @property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;


    - (NSArray *)favorites;

    - (BOOL)isFavorite:(Ticket *)ticket;

    - (void)addToFavorite:(Ticket *)ticket;

    - (void)removeFromFavorite:(Ticket *)ticket;


    - (NSArray *)favoriteMapPrices;

    - (BOOL)isFavoriteMapPrice:(MapPrice *)mapPrice;

    - (void)addToFavoriteMapPrice:(MapPrice *)mapPrice;

    - (void)removeFromFavoriteMapPrice:(MapPrice *)mapPrice;

@end


