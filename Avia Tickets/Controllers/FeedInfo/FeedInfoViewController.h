//
//  FeedInfoViewController.h
//  Avia Tickets
//
//  Created by Марат Нургалиев on 25/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYWebImage/YYWebImage.h>
#import "Feed.h"

#define GenerateNSUrl(url) [NSURL URLWithString:[NSString stringWithFormat:@"%@", url]];

@interface FeedInfoViewController : UIViewController
    
    @property (nonatomic, strong) UIScrollView *scrollView;
    
    @property (nonatomic, strong) UILabel *labelTitle;
    
    @property (nonatomic, strong) UILabel *labelPublishedAt;
    
    @property (nonatomic, strong) UIImageView *imageView;
    
    @property (nonatomic, strong) UILabel *labelContent;
    
    @property (nonatomic, strong) UILabel *labelAuthor;
    
    
    @property (nonatomic, strong) Feed *feed;
    
    
    - (instancetype)initWithFeed:(Feed *)feed;

@end

