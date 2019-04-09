//
//  ProgressView.h
//  Avia Tickets
//
//  Created by Admin on 4/8/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView

    + (instancetype)sharedInstance;


    - (void)show:(void (^)(void))completion;

    - (void)dismiss:(void (^)(void))completion;


@end
