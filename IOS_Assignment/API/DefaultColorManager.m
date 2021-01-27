//
//  DefaultColorManager.m
//  IOS_Assignment
//
//  Created by ESB21632 on 2021/1/19.
//  Copyright © 2021 陳彥廷21632. All rights reserved.
//

#import "DefaultColorManager.h"

@implementation DefaultColorManager {
    NSUserDefaults *defaultColorData;
    NSString *defaultColor;
}

-(BOOL)checkDefaultColor {
    defaultColorData =[NSUserDefaults standardUserDefaults];
    defaultColor = [defaultColorData objectForKey:@"defaultColor"];
    if(defaultColor == nil || [defaultColor isEqualToString:@"淺色模式"]){
        return YES;
    }else {
        return NO;
    }
}

-(void)setDefaultColor: (NSString*)color {
    defaultColorData =[NSUserDefaults standardUserDefaults];
    [defaultColorData setObject:color forKey:@"defaultColor"];
}

-(NSString *)lightColor {
    return @"淺色模式";
}

-(NSString *)darkColor {
    return @"深色模式";
}

@end
