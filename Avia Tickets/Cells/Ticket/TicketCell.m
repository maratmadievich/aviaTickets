//
//  TicketCell.m
//  Avia Tickets
//
//  Created by Марат Нургалиев on 24/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import "TicketCell.h"

@implementation TicketCell

    - (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
        
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        
        if (self) {
            
            self.contentView.layer.shadowColor = [[[UIColor blackColor] colorWithAlphaComponent:0.2] CGColor];
        
            self.contentView.layer.shadowOffset = CGSizeMake(1.0, 1.0);
            
            self.contentView.layer.shadowRadius = 10.0;
            
            self.contentView.layer.shadowOpacity = 1.0;
            
            self.contentView.layer.cornerRadius = 6.0;
            
            self.contentView.backgroundColor = [UIColor whiteColor];
            
            
            _priceLabel = [[UILabel alloc] initWithFrame:self.bounds];
            
            _priceLabel.font = [UIFont systemFontOfSize:24.0 weight:UIFontWeightBold];
            
            [self.contentView addSubview:_priceLabel];
            
            
            _airlineLogoView = [[UIImageView alloc] initWithFrame:self.bounds];
            
            _airlineLogoView.contentMode = UIViewContentModeScaleAspectFit;
            
            [self.contentView addSubview:_airlineLogoView];
            
            
            _placesLabel = [[UILabel alloc] initWithFrame:self.bounds];
            
            _placesLabel.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightLight];
            
            _placesLabel.textColor = [UIColor darkGrayColor];
            
            [self.contentView addSubview:_placesLabel];
            
            
            _dateLabel = [[UILabel alloc] initWithFrame:self.bounds];
            
            _dateLabel.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightRegular];
            
            [self.contentView addSubview:_dateLabel];
        }
        
        return self;
    }
    
    
    - (void)layoutSubviews {
        
        [super layoutSubviews];
        
        self.contentView.frame = CGRectMake(10.0, 10.0, [UIScreen mainScreen].bounds.size.width - 20.0, self.frame.size.height - 20.0);
        
        _priceLabel.frame = CGRectMake(10.0, 10.0, self.contentView.frame.size.width - 110.0, 40.0);
        
        _airlineLogoView.frame = CGRectMake(CGRectGetMaxX(_priceLabel.frame) + 10.0, 10.0, 80.0, 80.0);
        
        _placesLabel.frame = CGRectMake(10.0, CGRectGetMaxY(_priceLabel.frame) + 16.0, 100.0, 20.0);
        
        _dateLabel.frame = CGRectMake(10.0, CGRectGetMaxY(_placesLabel.frame) + 8.0, self.contentView.frame.size.width - 20.0, 20.0);
    }
    
    
    - (void)setTicket:(Ticket *)ticket {
        
        _ticket = ticket;
        
        _priceLabel.text = [NSString stringWithFormat:@"%@ руб.", ticket.price];
        
        _placesLabel.text = [NSString stringWithFormat:@"%@ - %@", ticket.from, ticket.to];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        dateFormatter.dateFormat = @"dd MMMM yyyy hh:mm";
        
        _dateLabel.text = [dateFormatter stringFromDate:ticket.departure];
        
        NSURL *urlLogo = AirlineLogo(ticket.airline);
        
        [_airlineLogoView yy_setImageWithURL:urlLogo options:YYWebImageOptionSetImageWithFadeAnimation];
    }


    - (void)setFavoriteTicket:(FavoriteTicket *)favoriteTicket {
    
        _favoriteTicket = favoriteTicket;
        
        _priceLabel.text = [NSString stringWithFormat:@"%lld руб.", favoriteTicket.price];
        
        _placesLabel.text = [NSString stringWithFormat:@"%@ - %@", favoriteTicket.from, favoriteTicket.to];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        dateFormatter.dateFormat = @"dd MMMM yyyy hh:mm";
        
        _dateLabel.text = [dateFormatter stringFromDate:favoriteTicket.departure];
        
        NSURL *urlLogo = AirlineLogo(favoriteTicket.airline);
        
        [_airlineLogoView yy_setImageWithURL:urlLogo options:YYWebImageOptionSetImageWithFadeAnimation];
    }


    - (void)setFavoriteMapPrice:(FavoriteMapPrice *)favoriteMapPrice {
    
        _favoriteMapPrice = favoriteMapPrice;
        
        _priceLabel.text = [NSString stringWithFormat:@"%lld руб.", (long)favoriteMapPrice.value];
        
        _placesLabel.text = [NSString stringWithFormat:@"%@ - %@", favoriteMapPrice.originCode, favoriteMapPrice.destinationCode];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        dateFormatter.dateFormat = @"dd MMMM yyyy hh:mm";
        
        _dateLabel.text = [dateFormatter stringFromDate:favoriteMapPrice.departure];
        
        _airlineLogoView.image = nil;
        
//        NSURL *urlLogo = AirlineLogo(favoriteTicket.airline);
//
//        [_airlineLogoView yy_setImageWithURL:urlLogo options:YYWebImageOptionSetImageWithFadeAnimation];
    }

    
    
@end
