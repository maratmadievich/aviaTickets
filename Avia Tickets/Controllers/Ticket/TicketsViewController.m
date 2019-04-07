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

    - (instancetype)initFavoriteTicketsController {
        
        self = [super init];
        
        if (self) {
        
            _isFavorites = YES;
            
            _isTickets = YES;
            
            self.tickets = [NSArray new];
            
            self.prices = [NSArray new];
            
            
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            [self.tableView registerClass:[TicketCell class] forCellReuseIdentifier:TicketCellReuseIdentifier];
            
        }
        
        return self;
    }


    - (instancetype)initWithTickets:(NSArray *)tickets {
        
        self = [super init];
        
        if (self) {
            
            _isFavorites = NO;
            
            _isTickets = YES;
            
            _tickets = tickets;
            
            self.title = @"Билеты";
            
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            [self.tableView registerClass:[TicketCell class] forCellReuseIdentifier:TicketCellReuseIdentifier];
        }
        
        return self;
    }


    - (void)viewDidAppear:(BOOL)animated {
       
        [super viewDidAppear:animated];
        
        if (_isFavorites) {
            
            self.tickets = [[CoreDataHelper sharedInstance] favorites];
            
            self.prices = [[CoreDataHelper sharedInstance] favoriteMapPrices];
        }
        
        [self.tableView reloadData];
        
    }

    - (void)viewDidLoad {
        
        [super viewDidLoad];
        
        if (_isFavorites) {
            
            self.navigationController.navigationBar.prefersLargeTitles = YES;
            
            self.navigationController.navigationBar.translucent = NO;
            
            self.title = @"Избранное";
            
            
            _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Билеты", @"Из карты"]];
            
            [_segmentedControl addTarget:self action:@selector(changeSource) forControlEvents:UIControlEventValueChanged];
            
            _segmentedControl.tintColor = [UIColor blackColor];
            
            self.navigationItem.titleView = _segmentedControl;
            
            _segmentedControl.selectedSegmentIndex = 0;
        }
    
    }


    - (void)changeSource {
        
        _isTickets = _segmentedControl.selectedSegmentIndex == 0;
        
        [self.tableView reloadData];
    }

    
    
#pragma mark - UITableViewDataSource & UITableViewDelegate
    
    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
       
        return _isTickets ? _tickets.count : _prices.count;
    }
    
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
       
        TicketCell *cell = [tableView dequeueReusableCellWithIdentifier:TicketCellReuseIdentifier forIndexPath:indexPath];
        
        if (_isFavorites) {
            
            if (_isTickets) {
                
                cell.favoriteTicket = [_tickets objectAtIndex:indexPath.row];
            }
            else {
                
                cell.favoriteMapPrice = [_prices objectAtIndex:indexPath.row];
            }
        
        }
        else {
           
            cell.ticket = [_tickets objectAtIndex:indexPath.row];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
       
        return 140.0;
    }

    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        
        if (_isFavorites) return;
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Действия с билетом" message:@"Что необходимо сделать с выбранным билетом?" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *favoriteAction;
        
        if ([[CoreDataHelper sharedInstance] isFavorite: [_tickets objectAtIndex:indexPath.row]]) {
        
            favoriteAction = [UIAlertAction actionWithTitle:@"Удалить из избранного" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
                [[CoreDataHelper sharedInstance] removeFromFavorite:[self->_tickets objectAtIndex:indexPath.row]];
            }];
            
        }
        else {
        
            favoriteAction = [UIAlertAction actionWithTitle:@"Добавить в избранное" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
                [[CoreDataHelper sharedInstance] addToFavorite:[self->_tickets objectAtIndex:indexPath.row]];
            }];
            
        }
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel handler:nil];
       
        [alertController addAction:favoriteAction];
        
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }


@end
