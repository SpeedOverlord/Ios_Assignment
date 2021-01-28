//
//  searchITunesMusic.h
//  IOS_Assignment
//
//  Created by 陳彥廷21632 on 2020/12/31.
//  Copyright © 2020 陳彥廷21632. All rights reserved.
//

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN

@interface SearchITunesMusic : NSObject

-(void)initSearch :(NSString *) inputData musicBlock:(void (^)(NSDictionary *))completeAction;


@end

NS_ASSUME_NONNULL_END
