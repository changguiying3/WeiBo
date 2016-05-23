//
//  WBStatusCell.h
//  WeiBo
//
//  Created by mac on 16/5/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBStatusFrame;
@interface WBStatusCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableview;
@property(nonatomic, strong) WBStatusFrame *statusFrame;
@end
