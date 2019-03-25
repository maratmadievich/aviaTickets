//
//  NewCell.h
//  Avia Tickets
//
//  Created by Марат Нургалиев on 24/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYWebImage/YYWebImage.h>
#import "Feed.h"

#define GetNewsImage(url) [NSURL URLWithString:[NSString stringWithFormat:@"%@", url]];

@interface FeedCell : UITableViewCell
    
    @property (nonatomic, strong) Feed *feed;
    
    
    @property (nonatomic, strong) UILabel *labelTitle;
    
    @property (nonatomic, strong) UILabel *labelPublished;
    
    @property (nonatomic, strong) UILabel *labelContent;
    
//    @property (nonatomic, strong) UIImageView *imageView;
    
    
    
@end
