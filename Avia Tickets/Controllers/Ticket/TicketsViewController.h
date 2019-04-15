//
//  TicketsViewController.h
//  Avia Tickets
//
//  Created by Марат Нургалиев on 24/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import "TicketCell.h"
#import "CoreDataHelper.h"
#import "NotificationCenter.h"
#import "NSString+Localize.h"
#import "CloudManager.h"

@protocol TicketsDelegate

@required //@optional

- (void)didLoadTickets:(NSArray *)tickets;

@end


@interface TicketsViewController : UITableViewController

    @property (nonatomic) bool isTickets;

    @property (nonatomic) bool isFavorites;


    @property (nonatomic, strong) NSArray *prices;

    @property (nonatomic, strong) NSArray *tickets;

    @property (nonatomic, strong) UIDatePicker *datePicker;

    @property (nonatomic, strong) UITextField *dateTextField;

    @property (nonatomic, strong) UISegmentedControl *segmentedControl;

    @property (nonatomic, strong) TicketCell *notificationCell;
    
    
    - (instancetype)initWithTickets:(NSArray *)tickets;

    - (instancetype)initFavoriteTicketsController;

- (void)showAlert:(Ticket *)ticket;
    
@end
