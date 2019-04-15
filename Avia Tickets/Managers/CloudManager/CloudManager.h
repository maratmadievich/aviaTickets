//
//  CloudManager.h
//  Avia Tickets
//
//  Created by Марат Нургалиев on 14/04/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CloudKit/CloudKit.h>
#import "Ticket.h"
#import "MapPrice.h"
#import "TicketsViewController.h"

@interface CloudManager : NSObject

+ (instancetype)sharedInstance;
//
//
//@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//
//@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
//
//@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
//
//
//- (NSArray *)favorites;
//
//- (BOOL)isFavorite:(Ticket *)ticket;
//
- (void)addToFavorite:(Ticket *)ticket;

- (void)favorites:(void (^)(NSArray *favorites))completion;

- (void)returnFavorite:(Ticket *)ticket withCompletion:(void (^)(CKRecord *favoriteTicket))completion;
//
//- (void)removeFromFavorite:(Ticket *)ticket;


//- (NSArray *)favoriteMapPrices;
//
//- (BOOL)isFavoriteMapPrice:(MapPrice *)mapPrice;
//
//- (void)addToFavoriteMapPrice:(MapPrice *)mapPrice;
//
//- (void)removeFromFavoriteMapPrice:(MapPrice *)mapPrice;

@end
