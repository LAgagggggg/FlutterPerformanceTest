//
//  PerformanceTestTableViewCell.h
//  PerformanceAdvanture
//
//  Created by LAgagggggg on 2018/10/9.
//  Copyright © 2018 nil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PerformanceTestItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface PerformanceTestTableViewCell : UITableViewCell

@property (strong,nonatomic) PerformanceTestItem * item;
@end

NS_ASSUME_NONNULL_END
