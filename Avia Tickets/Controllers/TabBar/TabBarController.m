//
//  TabBarController.m
//  Avia Tickets
//
//  Created by Марат Нургалиев on 31/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

    - (instancetype)init {
    
        self = [super initWithNibName:nil bundle:nil];
        
        if (self) {
        
            self.viewControllers = [self createViewControllers];
           
            self.tabBar.tintColor = [UIColor blackColor];
        }
        
        return self;
    }


    - (NSArray<UIViewController*> *)createViewControllers {
        
        NSMutableArray<UIViewController*> *controllers = [NSMutableArray new];
        
        MainViewController *mainViewController = [[MainViewController alloc] init];
        
        mainViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle: [@"search_tab" localize] image: [UIImage imageNamed: @"search"] selectedImage: [UIImage imageNamed: @"search"]];
        
        UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController: mainViewController];
        
        [controllers addObject: mainNavigationController];
        
       
        MapViewController *mapViewController = [[MapViewController alloc] init];
        
        mapViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle: [@"map_tab" localize] image: [UIImage imageNamed: @"map"] selectedImage: [UIImage imageNamed: @"map"]];
        
        UINavigationController *mapNavigationController = [[UINavigationController alloc] initWithRootViewController: mapViewController];
       
        [controllers addObject:mapNavigationController];
        
        
        FeedsViewController *feedsViewController = [[FeedsViewController alloc] init];
        
        feedsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle: [@"feed_tab" localize] image: [UIImage imageNamed: @"feed"] selectedImage: [UIImage imageNamed: @"feed"]];
        
        UINavigationController *feedsNavigationController = [[UINavigationController alloc] initWithRootViewController: feedsViewController];
        
        [controllers addObject:feedsNavigationController];
        
        
        TicketsViewController *favoriteViewController = [[TicketsViewController alloc] initFavoriteTicketsController];
       
        favoriteViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:[@"favorites_tab" localize] image:[UIImage imageNamed:@"favorite"] selectedImage:[UIImage imageNamed:@"favorite"]];
        
        UINavigationController *favoriteNavigationController = [[UINavigationController alloc] initWithRootViewController:favoriteViewController];
        
        [controllers addObject:favoriteNavigationController];


        return controllers;
    }


@end
