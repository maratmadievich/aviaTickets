//
//  TicketsViewController.m
//  Avia Tickets
//
//  Created by Марат Нургалиев on 24/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import "TicketsViewController.h"

#define TicketCellReuseIdentifier @"TicketCellIdentifier"

@interface TicketsViewController () <TicketsDelegate>

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
            
            self.title = [@"tickets_title" localize];
            
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            [self.tableView registerClass:[TicketCell class] forCellReuseIdentifier:TicketCellReuseIdentifier];
            
            
            _datePicker = [[UIDatePicker alloc] init];
            
            _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
            
            _datePicker.minimumDate = [NSDate date];
            
            
            _dateTextField = [[UITextField alloc] initWithFrame:self.view.bounds];
            
            _dateTextField.hidden = YES;
            
            _dateTextField.inputView = _datePicker;
            
            
            UIToolbar *keyboardToolbar = [[UIToolbar alloc] init];
            
            [keyboardToolbar sizeToFit];
            
            UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            
            UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonDidTap:)];
            
            keyboardToolbar.items = @[flexBarButton, doneBarButton];
            
            _dateTextField.inputAccessoryView = keyboardToolbar;
           
            [self.view addSubview:_dateTextField];
        }
        
        return self;
    }


    - (void)viewDidAppear:(BOOL)animated {
       
        [super viewDidAppear:animated];
        
        if (_isFavorites) {
            
            [[CloudManager sharedInstance] favorites: ^(NSArray *tickets) {
                
                self.tickets = tickets;
                
                if (self.isTickets) {
                    
                    [self.tableView reloadData];
                }
            }];
            
            self.prices = [[CoreDataHelper sharedInstance] favoriteMapPrices];
            
            [self.tableView reloadData];
        }
        
    }

    - (void)viewDidLoad {
        
        [super viewDidLoad];
        
        if (_isFavorites) {
            
            self.navigationController.navigationBar.prefersLargeTitles = YES;
            
            self.navigationController.navigationBar.translucent = NO;
            
            self.title = [@"favorites_tab" localize];
            
            
            _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[[@"tickets_title" localize], [@"tickets_from_map" localize]]];
            
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


    - (void)didLoadTickets:(NSArray *)tickets {
    
        self.tickets = tickets;
        
        if (_isFavorites && _isTickets) {
            
            [self.tableView reloadData];
        }
    
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
        
        [cell animate];
        
        return cell;
    }


    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
       
        return 140.0;
    }


    - (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
        
        cell.alpha = 0;
        
        cell.transform = CGAffineTransformMakeTranslation(-cell.frame.size.width, 0);
        
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             
                             cell.transform = CGAffineTransformMakeTranslation(0, 0);
        
                             cell.alpha = 0.8;
                         }
                         completion:^(BOOL finished) {
                             
                             [UIView animateWithDuration:0.2
                                                   delay:0.1
                                                 options:UIViewAnimationOptionCurveEaseOut
                                              animations:^{
                                                  
                                                  cell.contentView.alpha = 1;
                                              }
                                              completion:nil];
                         }];
        
    }


    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        
        [self.view endEditing:YES];
        
        if (_isFavorites) return;
        
        [self showAlert:[_tickets objectAtIndex:indexPath.row] indexPath:indexPath];
    }


- (void)showAlert:(Ticket *)ticket indexPath:(NSIndexPath *) indexPath {
    
    [[CloudManager sharedInstance] isFavorite:ticket withCompletion:^(BOOL isFavorite) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[@"actions_with_tickets" localize] message:[@"actions_with_tickets_describe" localize] preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *favoriteAction;
        
        if (isFavorite) {
            
            favoriteAction = [UIAlertAction actionWithTitle:[@"remove_from_favorite" localize] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                [[CloudManager sharedInstance] removeFromFavorite:ticket];
            }];
            
        }
        else {
            
            favoriteAction = [UIAlertAction actionWithTitle:[@"add_to_favorite" localize] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [[CloudManager sharedInstance] addToFavorite:ticket];
            }];
            
        }
        
        UIAlertAction *notificationAction = [UIAlertAction actionWithTitle:[@"remind_me" localize] style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            self->_notificationCell = [self.tableView cellForRowAtIndexPath:indexPath];
            
            [self->_dateTextField becomeFirstResponder];
        }];
        
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:[@"close" localize] style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:favoriteAction];
        
        [alertController addAction:notificationAction];
        
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }];
}


- (void)doneButtonDidTap:(UIBarButtonItem *)sender {
    
    if (_datePicker.date && _notificationCell) {
        
        NSString *message = [NSString stringWithFormat:@"%@ - %@ за %@ руб.", _notificationCell.ticket.from, _notificationCell.ticket.to, _notificationCell.ticket.price];
        
        NSURL *imageURL;
        
        if (_notificationCell.airlineLogoView.image) {
          
            NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:[NSString stringWithFormat:@"/%@.png", _notificationCell.ticket.airline]];
            
            if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
               
                UIImage *logo = _notificationCell.airlineLogoView.image;
               
                NSData *pngData = UIImagePNGRepresentation(logo);
               
                [pngData writeToFile:path atomically:YES];
            }
            
            imageURL = [NSURL fileURLWithPath:path];
        }
        
        Notification notification = NotificationMake([@"ticket_reminder" localize], message, _datePicker.date, imageURL);
        
        [[NotificationCenter sharedInstance] sendNotification:notification];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
//        [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
        
        NSLocale *ruLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
        
        [formatter setLocale:ruLocale];
        
        [formatter setDateFormat:@"dd MMMM yyyy в HH:mm"];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[@"success" localize] message:[NSString stringWithFormat:@"Уведомление будет отправлено - %@", [formatter stringFromDate:_datePicker.date]] preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:[@"close" localize] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            [self.view endEditing:YES];
        }];
        
        [alertController addAction:cancelAction];
       
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    _datePicker.date = [NSDate date];
    
    _notificationCell = nil;
    
    [self.view endEditing:YES];
}



@end
