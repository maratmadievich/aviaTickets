//
//  AppDelegate.m
//  Avia Tickets
//
//  Created by Марат Нургалиев on 23/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //Создание окна
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    
    self.window = [[UIWindow alloc] initWithFrame: windowFrame];

    //Инициализация окна выбора билетов
    MainViewController *ticketsViewController = [[MainViewController alloc] init];
    
    ticketsViewController.title = @"Билеты";
    
    UINavigationController *ticketsNavigationController = [[UINavigationController alloc] initWithRootViewController: ticketsViewController];
    
    
    //Инициализация окна вывода новостей
    FeedsViewController *feedsViewController = [[FeedsViewController alloc] init];
    
    feedsViewController.title = @"Новости";
    
    UINavigationController *feedsNavigationController = [[UINavigationController alloc] initWithRootViewController: feedsViewController];
    
    
    //Инициализация окна отображения карты
    MapViewController *mapViewController = [[MapViewController alloc] init];
    
    mapViewController.title = @"Карта";
    
    UINavigationController *mapNavigationController = [[UINavigationController alloc] initWithRootViewController: mapViewController];
    
    
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    NSArray *tabsArray = [[NSArray alloc] initWithObjects: ticketsNavigationController,
                          feedsNavigationController,
                          mapNavigationController,
                          nil];
    
    tabBarController.viewControllers = tabsArray;
    
    int i = 0;
    
    for (UIBarButtonItem *barButton in tabBarController.toolbarItems) {
        
        switch (i) {
            case 0:
                
                barButton.image = [UIImage imageNamed: @"search"];
                
                break;
                
            case 1:
                
                barButton.image = [UIImage imageNamed: @"news"];
                
                break;
                
            default:
                
                barButton.image = [UIImage imageNamed: @"map"];
                
                break;
                
        }
        
        i += 1;
    }
    
    self.window.rootViewController = tabBarController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
