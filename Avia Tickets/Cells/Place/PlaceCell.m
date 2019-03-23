//
//  PlaceCell.m
//  Avia Tickets
//
//  Created by Марат Нургалиев on 23/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import "PlaceCell.h"

@implementation PlaceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _labelName = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, ([UIScreen mainScreen].bounds.size.width - 20), 20)];
        
        _labelName.textAlignment = NSTextAlignmentLeft;
        
        [self.contentView addSubview:_labelName];
        
        
        _labelCode = [[UILabel alloc] initWithFrame: CGRectMake(10, 40, ([UIScreen mainScreen].bounds.size.width - 20), 20)];
        
        _labelCode.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_labelCode];
    }
    
    return self;
}

@end
