//
//  FavoriteManager.m
//  IOS_Assignment
//
//  Created by 陳彥廷21632 on 2021/1/11.
//  Copyright © 2021 陳彥廷21632. All rights reserved.
//

#import "FavoriteManager.h"
@interface FavoriteManager() {
    NSMutableArray *favoriteCombineArray;
    NSUserDefaults *favoriteData;
    NSMutableArray *currentFavoriteArray;
    NSMutableArray *favoriteList;
}

@end

@implementation FavoriteManager

-(id)init {
    self = [super init];
    if(self) {
//        NSString *appDomin = [[NSBundle mainBundle]bundleIdentifier];
        favoriteCombineArray = [[NSMutableArray alloc]init];
        favoriteData = [NSUserDefaults standardUserDefaults];
        currentFavoriteArray = [NSMutableArray new];
        favoriteList = [NSMutableArray new];
    }
    return self;
}

-(void)updateDataArray {
    [favoriteCombineArray removeAllObjects];
    if([self getFavorite] != nil) {
        [favoriteCombineArray addObjectsFromArray: [self getFavorite]];
    }
    [self storeDataInLocalDevice];
}

-(void)storeDataInLocalDevice {
    favoriteData = [NSUserDefaults standardUserDefaults];
    [favoriteData setObject:favoriteCombineArray forKey:@"FavoriteData"];
    [favoriteData synchronize];
}


-(void)addFavorite: (NSArray*)favorite {
   favoriteData = [NSUserDefaults standardUserDefaults];
    NSMutableArray *currentFavoriteArray;
    currentFavoriteArray = [NSMutableArray new];
    [currentFavoriteArray setArray:[favoriteData objectForKey:@"FavoriteData"]];
    if([currentFavoriteArray count]!='\0') {
        [favoriteList setArray: currentFavoriteArray];
    }
    [favoriteList addObject:favorite];
    [currentFavoriteArray removeAllObjects];
    [self updateDataArray];
}

-(NSMutableArray*)getFavorite {
    return favoriteList;
}

-(void)deleteFavorite:(NSArray*)favoriteItem {
    favoriteData = [NSUserDefaults standardUserDefaults];
    currentFavoriteArray = [favoriteData objectForKey:@"FavoriteData"];
    int rowsWantToRemove = 0;
    for(int i = 0; i< [currentFavoriteArray count]; i++) {
        if([[currentFavoriteArray[i] valueForKey:@"trackName"] isEqualToString:[favoriteItem valueForKey:@"trackName"]]) {
            rowsWantToRemove = i;
        }
    }
    NSMutableArray *deleteObject = [NSMutableArray new];
    [deleteObject setArray: currentFavoriteArray];
    [deleteObject removeObjectAtIndex:rowsWantToRemove];
    NSMutableArray *fixedCombineArray;
    fixedCombineArray = [NSMutableArray new];
    [fixedCombineArray addObject:deleteObject];
    favoriteData = [NSUserDefaults standardUserDefaults];
    [favoriteData setObject:deleteObject forKey:@"FavoriteData"];
    [favoriteData synchronize];
}


-(BOOL)isFavorite:(NSString*) isFavorite{
    BOOL favoriteStatus = NO;
    favoriteData = [NSUserDefaults standardUserDefaults];
    currentFavoriteArray = [favoriteData objectForKey:@"FavoriteData"];
    for(int i = 0; i< [currentFavoriteArray count]; i++) {
        if([[currentFavoriteArray[i] valueForKey:@"trackName"] isEqualToString:isFavorite]) {
            favoriteStatus = YES;
            return favoriteStatus;
        }else {
            favoriteStatus = NO;
        }
    }
    return favoriteStatus;
}

-(NSInteger)getFavoriteNumber {
    favoriteData = [NSUserDefaults standardUserDefaults];
    NSArray* favoriteList = [NSArray new];
    favoriteList =  [favoriteData objectForKey:@"FavoriteData"];
    NSInteger FavoriteNumber = (NSInteger)((int)[[favoriteData objectForKey:@"FavoriteData"] count]);
    return FavoriteNumber;
}

-(NSArray *)getFavoriteList {
    favoriteData = [NSUserDefaults standardUserDefaults];
    NSArray* favoriteList = [NSArray new];
    favoriteList =  [favoriteData objectForKey:@"FavoriteData"];
    return favoriteList;
}

@end
