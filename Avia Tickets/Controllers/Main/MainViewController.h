//
//  MainViewController.h
//  Avia Tickets
//
//  Created by Марат Нургалиев on 23/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct SearchRequest {
    
    __unsafe_unretained NSString *origin;
    
    __unsafe_unretained NSString *destionation;
    
    __unsafe_unretained NSDate *departDate;
    
    __unsafe_unretained NSDate *returnDate;
} SearchRequest;

@interface MainViewController : UIViewController
  
@end

