//
//  NotificationCenter.m
//  Avia Tickets
//
//  Created by Admin on 4/8/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import "NotificationCenter.h"

@interface NotificationCenter () <UNUserNotificationCenterDelegate>

@end


@implementation NotificationCenter

+ (instancetype)sharedInstance {
    
    static NotificationCenter *instance;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
    
        instance = [[NotificationCenter alloc] init];
    });
    
    return instance;
}


- (void)registerService {

    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    center.delegate = self;
    
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              
        if (!error) {
            
            NSLog(@"request authorization succeeded!");
        }
        
    }];
    
}


- (void)sendNotification:(Notification)notification {
   
    if (@available(iOS 10.0, *)) {
      
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
       
        content.title = notification.title;
        
        content.body = notification.body;
       
        content.sound = [UNNotificationSound defaultSound];
        
        if (notification.imageURL) {
           
            UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"image" URL:notification.imageURL options:nil error:nil];
           
            if (attachment) {
               
                content.attachments = @[attachment];
            }
            
        }
        
        NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
       
        NSDateComponents *components = [calendar componentsInTimeZone:[NSTimeZone systemTimeZone] fromDate:notification.date];
       
        NSDateComponents *newComponents = [[NSDateComponents alloc] init];
        
        newComponents.calendar = calendar;
       
        newComponents.timeZone = [NSTimeZone defaultTimeZone];
       
        newComponents.month = components.month;
        
        newComponents.day = components.day;
        
        newComponents.hour = components.hour;
        
        newComponents.minute = components.minute;
        
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:newComponents repeats:NO];
        
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Notification"
                                                                              content:content trigger:trigger];
        
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
       
        [center addNotificationRequest:request withCompletionHandler:nil];
    }
    else {
        
        UILocalNotification *localNotification = [[UILocalNotification alloc] init]; //UILocalNotification
        
        localNotification.fireDate = notification.date;
        
        if (notification.title) {
          
            localNotification.alertBody = [NSString stringWithFormat:@"%@ - %@", notification.title, notification.body];
        }
        else {
           
            localNotification.alertBody = notification.body;
        }
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
    
}


Notification NotificationMake(NSString* _Nullable title, NSString* _Nonnull body, NSDate* _Nonnull date, NSURL * _Nullable  imageURL) {
  
    Notification notification;
    
    notification.title = title;
    
    notification.body = body;
    
    notification.date = date;
    
    notification.imageURL = imageURL;
    
    return notification;
}


@end
