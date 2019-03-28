//
//  FeedsViewController.m
//  Avia Tickets
//
//  Created by Марат Нургалиев on 24/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import "FeedsViewController.h"

#define FeedCellReuseIdentifier @"FeedCellIdentifier"

@interface FeedsViewController ()

@end

@implementation FeedsViewController

//    - (instancetype)initWithFeeds:(NSArray *)feeds {
//    
//        self = [super init];
//        
//        if (self) {
//            
//            _feeds = feeds;
//            
//            self.title = @" Новости";
//            
//            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//            
//            [self.tableView registerClass:[FeedCell class] forCellReuseIdentifier:FeedCellReuseIdentifier];
//        }
//        
//        return self;
//    }


    - (void)viewDidLoad {
    
        [super viewDidLoad];
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.tableView registerClass:[FeedCell class] forCellReuseIdentifier:FeedCellReuseIdentifier];
    
        [[ApiManager sharedInstance] feedsWithRequest: @"ru" withCompletion: ^(NSArray *feeds) {
            
            self.feeds = feeds;
            
            [self.tableView reloadData];
        }];
            
    }


    
#pragma mark - UITableViewDataSource & UITableViewDelegate
    
    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        
        return _feeds.count;
    }
    
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
        FeedCell *cell = [tableView dequeueReusableCellWithIdentifier:FeedCellReuseIdentifier forIndexPath:indexPath];
        
        cell.feed = [_feeds objectAtIndex:indexPath.row];
        
        return cell;
    }
    
    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        
        return 140.0;
    }
    
    -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        
        FeedInfoViewController *feedInfoViewController = [[FeedInfoViewController alloc] initWithFeed: [_feeds objectAtIndex:indexPath.row]];
        
        [self.navigationController showViewController:feedInfoViewController sender:self];
    }

@end
