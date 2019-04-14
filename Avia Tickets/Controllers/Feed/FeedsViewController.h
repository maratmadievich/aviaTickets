//
//  FeedsViewController.h
//  Avia Tickets
//
//  Created by Марат Нургалиев on 24/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedCell.h"
#import "ApiManager.h"
#import "FeedInfoViewController.h"
#import "NSString+Localize.h"


@interface FeedsViewController : UITableViewController
    
    @property (nonatomic, strong) NSArray *feeds;
    

@end

