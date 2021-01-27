//
//  musicSearchResult.m
//  IOS_Assignment
//
//  Created by 陳彥廷21632 on 2020/12/31.
//  Copyright © 2020 陳彥廷21632. All rights reserved.
//

#import "musicSearchResult.h"

@implementation musicSearchResult

-(id)initWithTrackName:(NSString*)trackName artist:(NSString*)artist collectionName:(NSString*)collectionName trackTime:(NSNumber*)trackTime coverURL:(NSString*)coverURL trackViewURL:(NSString*)trackViewURL {
    self = [super init];
    if(self){
        _trackName = trackName;
        _artist = artist;
        _collectionName = collectionName;
        _trackTime = trackTime;
        _coverURL = coverURL;
        _trackViewURL = trackViewURL;
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder*)coder {
    [coder encodeObject:self.trackName forKey:@"trackName"];
    [coder encodeObject:self.artist forKey:@"artist"];
    [coder encodeObject:self.collectionName forKey:@"collectionName"];
    [coder encodeObject:self.trackTime forKey:@"trackTime"];
    [coder encodeObject:self.coverURL forKey:@"coverURL"];
    [coder encodeObject:self.trackViewURL forKey:@"trackViewURL"];
}

-(id)initWithCoder:(NSCoder*)decoder {
    self = [super init];
    if(self) {
        _trackName = [decoder decodeObjectForKey:@"trackName"];
        _artist = [decoder decodeObjectForKey:@"artist"];
        _collectionName = [decoder decodeObjectForKey:@"collectionName"];
        _trackTime = [decoder decodeObjectForKey:@"trackTime"];
        _coverURL = [decoder decodeObjectForKey:@"coverURL"];
        _trackViewURL = [decoder decodeObjectForKey:@"trackViewURL"];
    }
    return self;
}

@end
