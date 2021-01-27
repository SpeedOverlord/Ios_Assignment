//
//  FavoriteManager.h
//  IOS_Assignment
//
//  Created by 陳彥廷21632 on 2021/1/11.
//  Copyright © 2021 陳彥廷21632. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FavoriteManager : NSObject

-(void)addFavorite: (NSArray*)favorite;
-(BOOL)isFavorite:(NSString*) isFavorite;
-(void)deleteFavorite:(NSArray*)favoriteItem;

-(NSInteger)getFavoriteNumber;

-(NSArray *)getFavoriteList;

@end

NS_ASSUME_NONNULL_END
