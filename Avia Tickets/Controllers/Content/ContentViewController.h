//
//  ContentViewController.h
//  Avia Tickets
//
//  Created by Admin on 4/8/19.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentViewController : UIViewController

@property (nonatomic, strong) NSString *contentText;

@property (nonatomic, strong) UIImage *image;

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UILabel *contentLabel;


@property (nonatomic) int index;

@end
