//
//  DefaultColorManager.h
//  IOS_Assignment
//
//  Created by ESB21632 on 2021/1/19.
//  Copyright © 2021 陳彥廷21632. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DefaultColorManager : NSObject

-(BOOL)checkDefaultColor;
-(void)setDefaultColor: (NSString*)color;
-(NSString *)lightColor;
-(NSString *)darkColor;


@end

NS_ASSUME_NONNULL_END
