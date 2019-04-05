//
//  FavoriteTicket+CoreDataProperties.m
//  Avia Tickets
//
//  Created by Admin on 4/4/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//
//

#import "FavoriteTicket+CoreDataProperties.h"

@implementation FavoriteTicket (CoreDataProperties)

+ (NSFetchRequest<FavoriteTicket *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"FavoriteTicket"];
}

@dynamic price;
@dynamic airline;
@dynamic departure;
@dynamic expires;
@dynamic flightNumber;
@dynamic returnDate;
@dynamic from;
@dynamic to;
@dynamic created;

@end
