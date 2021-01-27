//
//  searchButtonView.h
//  IOS_Assignment
//
//  Created by 陳彥廷21632 on 2020/12/30.
//  Copyright © 2020 陳彥廷21632. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol searchButtonViewDelegate;

@interface searchButtonView : UIView
@property (nonatomic, copy) void (^buttonAction)(UIButton *);
@property (weak)id<searchButtonViewDelegate>delegate;


@end

NS_ASSUME_NONNULL_END
