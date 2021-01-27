//
//  favoriteMovie.m
//  IOS_Assignment
//
//  Created by 陳彥廷21632 on 2021/1/11.
//  Copyright © 2021 陳彥廷21632. All rights reserved.
//

#import "favoriteMovie.h"

@interface favoriteMovie () {
    NSMutableArray *favoriteMovieArray;
}

@end

@implementation favoriteMovie

-(id)init {
    self = [super init];
    if(self) {
        favoriteMovieArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)saveFavorite:(NSArray*)favoriteMovie {
    [favoriteMovieArray addObject:favoriteMovie];
}

-(void)removeFavorite:(NSArray*)favoriteMovie  {
    
    NSMutableArray *trackNames = [favoriteMovieArray valueForKey:@"trackName"];
    int integerWantToRemove = 0;
    for (int i = 0; i < trackNames.count; i++) {
        if([[favoriteMovieArray[i] valueForKey:@"trackName"] isEqual: [favoriteMovie valueForKey:@"trackName"]]) {
            integerWantToRemove = i;
        }
    }
     [favoriteMovieArray removeObjectAtIndex:integerWantToRemove];
}

-(NSMutableArray*)getData {
    return favoriteMovieArray;
}

@end
