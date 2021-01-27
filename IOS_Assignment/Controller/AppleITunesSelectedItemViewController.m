//
//  AppleITunesSelectedItemViewController.m
//  IOS_Assignment
//
//  Created by ESB21632 on 2021/1/26.
//  Copyright © 2021 陳彥廷21632. All rights reserved.
//

#import "AppleITunesSelectedItemViewController.h"

@interface AppleITunesSelectedItemViewController () {
    NSString *Url;
}

@end

@implementation AppleITunesSelectedItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        [self initView];
        // Do any additional setup after loading the view.
}

-(void)initView {
    WKWebView *webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = webView;
    NSURL *url = [NSURL URLWithString:Url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}


-(void)storeUrlString: (NSString*)urlString {
    Url = [NSString stringWithString:urlString];
}

@end
