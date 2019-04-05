//
//  TicketsViewController.h
//  Avia Tickets
//
//  Created by Марат Нургалиев on 24/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketCell.h"
#import "CoreDataHelper.h"

@interface TicketsViewController : UITableViewController

    @property (nonatomic) bool isFavorites;
    
    @property (nonatomic, strong) NSArray *tickets;
    
    
    - (instancetype)initWithTickets:(NSArray *)tickets;

    - (instancetype)initFavoriteTicketsController;
    
@end
