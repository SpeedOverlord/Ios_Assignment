//
//  AppleITunesViewController.m
//  IOS_Assignment
//
//  Created by ESB21632 on 2021/1/26.
//  Copyright © 2021 陳彥廷21632. All rights reserved.
//

#import "AppleITunesViewController.h"

@interface AppleITunesViewController ()
@end

@implementation AppleITunesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}

-(void)initView {
        WKWebView *webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.view = webView;
        NSURL *url = [NSURL URLWithString:@"https://support.apple.com/itunes"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webView loadRequest:request];
}


@end
