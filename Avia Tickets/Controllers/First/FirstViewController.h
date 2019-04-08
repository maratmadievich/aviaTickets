//
//  FirstViewController.h
//  Avia Tickets
//
//  Created by Admin on 4/8/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentViewController.h"




@interface FirstViewController : UIPageViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (strong, nonatomic) UIButton *nextButton;

@property (strong, nonatomic) UIPageControl *pageControl;

@end

