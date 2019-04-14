//
//  MainViewController.h
//  Avia Tickets
//
//  Created by Марат Нургалиев on 23/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedsViewController.h"
#import "PlaceViewController.h"
#import "TicketsViewController.h"
#import "Enums.h"
#import "ApiManager.h"
#import "DataManager.h"
#import "ProgressView.h"
#import "FirstViewController.h"
#import "NSString+Localize.h"


@interface MainViewController : UIViewController
    
    @property (nonatomic, strong) UIView *placeContainerView;
    
    @property (nonatomic, strong) UIButton *departureButton;
    
    @property (nonatomic, strong) UIButton *arrivalButton;
    
    @property (nonatomic, strong) UIButton *searchButton;
    
    @property (nonatomic, strong) UIBarButtonItem *feedsButton;
    
    
    @property (nonatomic) SearchRequest searchRequest;
  
@end

