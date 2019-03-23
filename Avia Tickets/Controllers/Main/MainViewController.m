//
//  MainViewController.m
//  Avia Tickets
//
//  Created by Марат Нургалиев on 23/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import "MainViewController.h"
#import "DataManager.h"

@interface MainViewController ()

@end

@implementation MainViewController


    - (void)viewDidLoad {
        
        [super viewDidLoad];
        
//        [[DataManager sharedInstance] loadData];
        
        [self addSubviews];
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDataComplete) name:kDataManagerLoadDataDidComplete object:nil];
    }
    
    
    - (void)dealloc {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kDataManagerLoadDataDidComplete object:nil];
    }
    
    
    - (void)loadDataComplete {
       
        self.view.backgroundColor = [UIColor yellowColor];
    }
    
    
    - (void) addSubviews {
        
        CGRect frameLabelFrom = CGRectMake(16.0, 80.0, ([UIScreen mainScreen].bounds.size.width - 32.0), 20.0);
        
        _labelFrom = [[UILabel alloc] initWithFrame: frameLabelFrom];
        
        _labelFrom.font = [UIFont systemFontOfSize:20.0 weight:UIFontWeightBold];
        
        _labelFrom.textColor = [UIColor darkGrayColor];
        
        _labelFrom.textAlignment = NSTextAlignmentCenter;
        
        _labelFrom.text = @"Выберите город вылета";
        
        [self.view addSubview: _labelFrom];
        
        
        CGRect frameTextFieldFrom = CGRectMake(16.0, 120.0, ([UIScreen mainScreen].bounds.size.width - 32.0), 40.0);
        
        _textFieldFrom = [[UITextField alloc] initWithFrame:frameTextFieldFrom];
        
        _textFieldFrom.borderStyle = UITextBorderStyleRoundedRect;
        
        _textFieldFrom.placeholder = @"Откуда";
        
        _textFieldFrom.font = [UIFont systemFontOfSize:20.0 weight:UIFontWeightLight];
        
        [self.view addSubview: _textFieldFrom];
        
        
        CGRect frameLabelTo = CGRectMake(16.0, 180.0, ([UIScreen mainScreen].bounds.size.width - 32.0), 20.0);
        
        _labelTo = [[UILabel alloc] initWithFrame: frameLabelTo];
        
        _labelTo.font = [UIFont systemFontOfSize:20.0 weight:UIFontWeightBold];
        
        _labelTo.textColor = [UIColor darkGrayColor];
        
        _labelTo.textAlignment = NSTextAlignmentCenter;
        
        _labelTo.text = @"Выберите город посадки";
        
        [self.view addSubview: _labelTo];

        
        CGRect frameTextFieldTo = CGRectMake(16.0, 220.0, ([UIScreen mainScreen].bounds.size.width - 32.0), 40.0);
        
        _textFieldTo = [[UITextField alloc] initWithFrame:frameTextFieldTo];
        
        _textFieldTo.borderStyle = UITextBorderStyleRoundedRect;
        
        _textFieldTo.placeholder = @"Куда";
        
        _textFieldTo.font = [UIFont systemFontOfSize:20.0 weight:UIFontWeightLight];
        
        [self.view addSubview: _textFieldTo];
    }


@end
