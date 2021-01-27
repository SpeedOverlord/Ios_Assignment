//
//  searchITunesMusic.m
//  IOS_Assignment
//
//  Created by 陳彥廷21632 on 2020/12/31.
//  Copyright © 2020 陳彥廷21632. All rights reserved.
//

#import "searchITunesMusic.h"
#import "AFNetworking.h"
@implementation searchITunesMusic {
    NSDictionary *searchData;
    
}

-(void)initSearch :(NSString *) inputData musicBlock:(void (^)(NSDictionary *))completeAction{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *encodeString = [inputData stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *combinePart1 = @"https://itunes.apple.com/search?term=";
    NSString *combinePart2 = @"&country=TW&limit=200";
    NSString *combineString = [combinePart1 stringByAppendingString: encodeString];
    combineString = [combineString stringByAppendingString: combinePart2];
    [manager GET: combineString parameters:nil headers: nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *returnObj =  [self nsdictionaryConverter:responseObject];
        completeAction(returnObj);
    }
         failure: ^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }
     ];
}

-(NSDictionary *)nsdictionaryConverter: (id) responseObject{
    NSError *jsonError;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject: responseObject options:NSJSONWritingPrettyPrinted error:&jsonError];
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData: jsonData options:NSJSONReadingMutableContainers error:nil];
    return jsonDictionary;
}

-(NSDictionary *)getSearchData {
    return searchData;
}

@end
