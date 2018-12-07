//
//  BRPluginCell.m
//  BalaenicepsRexDemo
//
//  Created by 毕博洋 on 2018/12/7.
//  Copyright © 2018 毕博洋. All rights reserved.
//

#import "BRPluginCell.h"
#import "UIView+BRLayout.h"

@interface BRPluginCell ()

@property (nonatomic, strong) UILabel *nameLabel;

@end
@implementation BRPluginCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,20, self.contentView.width, 14.)];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_nameLabel];
    }
    return self;
}



- (void)setTitleWith:(NSDictionary *)dic{
    NSLog(@"______%@",dic);
    
    NSString *nameStr = dic[@"pluginName"];
    _nameLabel.text = nameStr;
}


@end
