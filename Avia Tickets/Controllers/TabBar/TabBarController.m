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
           
            self.tabBar.tintColor = [UIColor blueColor];
        }
        
        return self;
    }


    - (NSArray<UIViewController*> *)createViewControllers {
        
        NSMutableArray<UIViewController*> *controllers = [NSMutableArray new];
        
        MainViewController *mainViewController = [[MainViewController alloc] init];
        
        mainViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle: @"Поиск" image: [UIImage imageNamed: @"search"] selectedImage: [UIImage imageNamed: @"search"]];
        
        UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController: mainViewController];
        
        [controllers addObject: mainNavigationController];
        
        MapViewController *mapViewController = [[MapViewController alloc] init];
        
        mapViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle: @"Карта цен" image: [UIImage imageNamed: @"map"] selectedImage: [UIImage imageNamed: @"map"]];
        
        UINavigationController *mapNavigationController = [[UINavigationController alloc] initWithRootViewController: mapViewController];
       
        [controllers addObject:mapNavigationController];
        
        FeedsViewController *feedsViewController = [[FeedsViewController alloc] init];
        
        feedsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle: @"Новости" image: [UIImage imageNamed: @"feed"] selectedImage: [UIImage imageNamed: @"feed"]];
        
        UINavigationController *feedsNavigationController = [[UINavigationController alloc] initWithRootViewController: feedsViewController];
        
        [controllers addObject:feedsNavigationController];

        return controllers;
    }


@end
