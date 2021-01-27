//
//  favoriteMovie.h
//  IOS_Assignment
//
//  Created by 陳彥廷21632 on 2021/1/11.
//  Copyright © 2021 陳彥廷21632. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface favoriteMovie : NSObject

@property (nonatomic, copy, readonly) NSString *trackName;
@property (nonatomic, copy, readonly) NSString *artistName;
@property (nonatomic, copy, readonly) NSString *collcetionName;
@property (nonatomic, copy, readonly) NSString *trackTimeMillis;
@property (nonatomic, copy, readonly) NSString *artworkUrl30;
@property (nonatomic, copy, readonly) NSString *longDescripton;

-(void)saveFavorite:(NSArray*)favoriteMovie;
-(void)removeFavorite:(NSArray*)favoriteMovie;
-(NSMutableArray*)getData;

@end

NS_ASSUME_NONNULL_END
