//
//  InputView.h
//  IOS_Assignment
//
//  Created by 陳彥廷21632 on 2020/12/28.
//  Copyright © 2020 陳彥廷21632. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol InputViewDelegate;

@interface InputView : UIView
@property (weak) id<InputViewDelegate>delegate;
@property (nonatomic)UITextField *textField;
-(void)changeDefaultColor;
-(void)resignTextField;
@end

//@protocol InputViewDelegate <NSObject>
//@required
//- (void)textFieldDidBeginEditing:(InputView *)textField;
//- (BOOL)textFieldShouldEndEditing:(InputView *)textField;
//- (void)textFieldDidEndEditing:(InputView *)textField;
//- (BOOL)textFieldShouldReturn:(InputView *)textField;
//@end

NS_ASSUME_NONNULL_END
