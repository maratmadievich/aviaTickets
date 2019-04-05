//
//  CoreDataHelper.h
//  Avia Tickets
//
//  Created by Admin on 4/4/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "Ticket.h"
#import "DataManager.h"
#import "FavoriteTicket+CoreDataClass.h"

@interface CoreDataHelper : NSObject

    + (instancetype)sharedInstance;


    @property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

    @property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

    @property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;


    - (BOOL)isFavorite:(Ticket *)ticket;

    - (NSArray *)favorites;

    - (void)addToFavorite:(Ticket *)ticket;

    - (void)removeFromFavorite:(Ticket *)ticket;

@end


