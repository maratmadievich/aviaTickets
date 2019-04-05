//
//  TicketCell.h
//  Avia Tickets
//
//  Created by Марат Нургалиев on 24/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYWebImage/YYWebImage.h>
#import "APIManager.h"
#import "DataManager.h"
#import "FavoriteTicket+CoreDataClass.h"

#define AirlineLogo(iata) [NSURL URLWithString:[NSString stringWithFormat:@"https://pics.avs.io/200/200/%@.png", iata]];

@interface TicketCell : UITableViewCell
    
    @property (nonatomic, strong) Ticket *ticket;

    @property (nonatomic, strong) FavoriteTicket *favoriteTicket;
    
    
    @property (nonatomic, strong) UIImageView *airlineLogoView;
    
    @property (nonatomic, strong) UILabel *priceLabel;
    
    @property (nonatomic, strong) UILabel *placesLabel;
    
    @property (nonatomic, strong) UILabel *dateLabel;


    - (void)setFavoriteTicket:(FavoriteTicket *)favoriteTicket;

@end
