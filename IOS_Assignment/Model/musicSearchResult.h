//
//  musicSearchResult.h
//  IOS_Assignment
//
//  Created by 陳彥廷21632 on 2020/12/31.
//  Copyright © 2020 陳彥廷21632. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface musicSearchResult : NSObject

@property (nonatomic, copy, readonly) NSString *trackName;
@property (nonatomic, copy, readonly) NSString *artist;
@property (nonatomic, copy, readonly) NSString *collectionName;
@property (nonatomic, readonly) NSNumber *trackTime;
@property (nonatomic, copy, readonly) NSString *coverURL;
@property (nonatomic, copy, readonly) NSString *trackViewURL;

-(id)initWithTrackName:(NSString*)trackName artist:(NSString*)artist collectionName:(NSString*)collectionName trackTime:(NSNumber*)trackTime coverURL:(NSString*)coverURL trackViewURL:(NSString*)trackViewURL;

-(NSDictionary*)tableRepresentation;

@end

NS_ASSUME_NONNULL_END
