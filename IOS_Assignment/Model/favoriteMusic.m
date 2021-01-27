//
//  favoriteMusic.m
//  IOS_Assignment
//
//  Created by 陳彥廷21632 on 2021/1/11.
//  Copyright © 2021 陳彥廷21632. All rights reserved.
//

#import "favoriteMusic.h"

@interface favoriteMusic () {
    NSMutableArray *favoriteMusicArray;
}

@end


@implementation favoriteMusic
-(id)init {
    self = [super init];
    if(self) {
        favoriteMusicArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)saveFavorite:(NSArray*)favoriteMovie {
    [favoriteMusicArray addObject:favoriteMovie];
}

-(void)removeFavorite:(NSArray*)favoriteMovie  {
    
    NSMutableArray *trackNames = [favoriteMusicArray valueForKey:@"trackName"];
    int integerWantToRemove = 0;
    for (int i = 0; i < trackNames.count; i++) {
        if([[favoriteMusicArray[i] valueForKey:@"trackName"] isEqual: [favoriteMovie valueForKey:@"trackName"]]) {
            integerWantToRemove = i;
        }
    }
     [favoriteMusicArray removeObjectAtIndex:integerWantToRemove];
}

-(NSMutableArray*)getData {
    return favoriteMusicArray;
}

@end
