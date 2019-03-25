//
//  PlaceViewController.h
//  Avia Tickets
//
//  Created by Марат Нургалиев on 23/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "Enums.h"


@protocol PlaceViewControllerDelegate <NSObject>
   
    - (void)selectPlace:(id)place withType:(PlaceType)placeType andDataType:(DataSourceType)dataType;

@end


@interface PlaceViewController : UIViewController
    
    @property (nonatomic, strong) id<PlaceViewControllerDelegate>delegate;

    
    - (instancetype)initWithType:(PlaceType)type;

@end

