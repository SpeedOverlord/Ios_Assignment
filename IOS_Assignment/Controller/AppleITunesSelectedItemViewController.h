//
//  AppleITunesSelectedItemViewController.h
//  IOS_Assignment
//
//  Created by ESB21632 on 2021/1/26.
//  Copyright © 2021 陳彥廷21632. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <StoreKit/StoreKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppleITunesSelectedItemViewController : UIViewController

-(void)storeUrlString: (NSString*)urlString;

@end

NS_ASSUME_NONNULL_END
