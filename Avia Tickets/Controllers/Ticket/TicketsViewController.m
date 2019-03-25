//
//  TicketsViewController.m
//  Avia Tickets
//
//  Created by Марат Нургалиев on 24/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import "TicketsViewController.h"

#define TicketCellReuseIdentifier @"TicketCellIdentifier"

@interface TicketsViewController ()

@end

@implementation TicketsViewController

    - (instancetype)initWithTickets:(NSArray *)tickets {
        
        self = [super init];
        
        if (self) {
            
            _tickets = tickets;
            
            self.title = @"Билеты";
            
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            [self.tableView registerClass:[TicketCell class] forCellReuseIdentifier:TicketCellReuseIdentifier];
        }
        
        return self;
    }
    
    
#pragma mark - UITableViewDataSource & UITableViewDelegate
    
    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
       
        return _tickets.count;
    }
    
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
       
        TicketCell *cell = [tableView dequeueReusableCellWithIdentifier:TicketCellReuseIdentifier forIndexPath:indexPath];
        
        cell.ticket = [_tickets objectAtIndex:indexPath.row];
        
        return cell;
    }
    
    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
       
        return 140.0;
    }

@end
