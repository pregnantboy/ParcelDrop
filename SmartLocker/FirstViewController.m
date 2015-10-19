//
//  FirstViewController.m
//  SmartLocker
//
//  Created by Ian Chen on 17/10/15.
//  Copyright (c) 2015 Ian Chen. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

NSString *ip;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.iptext.alpha = 0;
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"ip"] == NULL) {
        [[NSUserDefaults standardUserDefaults] setValue:@"31.124" forKey:@"ip"];
    }
    ip = [[NSUserDefaults standardUserDefaults] valueForKey:@"ip"];
    [self loadCam];
    [self setLockImage];
    
}

- (IBAction)toggleLock:(id)sender {
    if ([self.lock.imageView.image isEqual:[UIImage imageNamed:@"lock.png"]]) {
        [self sendUnlockRequest];
        [self setUnlockImage];
    } else {
        [self sendLockRequest];
        [self setLockImage];
    }
}
- (IBAction)refreshVid:(id)sender {
    [self loadCam];
}

- (void)sendUnlockRequest  {
    NSString *unlockAddress = @"http://192.168.76.102:3000/unlock";
    
    NSMutableURLRequest *request =
    [NSMutableURLRequest requestWithURL:[NSURL
                                         URLWithString:unlockAddress]
                            cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                        timeoutInterval:0.1
     ];
    
    NSURLResponse *response= nil;
    [request setHTTPMethod: @"GET"];
    
    [NSURLConnection sendSynchronousRequest:request
                          returningResponse:&response error:nil];
    NSLog(@"%@", response);
    if (response == NULL) {
        [self sendUnlockRequest];
    }
}


- (void)sendLockRequest  {
    NSString *serverAddress = @"http://192.168.76.102:3000/lock";
    
    NSMutableURLRequest *request =
    [NSMutableURLRequest requestWithURL:[NSURL
                                         URLWithString:serverAddress]
                            cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                        timeoutInterval:0.1
     ];
    
    [request setHTTPMethod: @"GET"];
    
    NSURLResponse *response= nil;
    
    [NSURLConnection sendSynchronousRequest:request
                          returningResponse:&response error:nil];
    NSLog(@"%@", response);
    if (response == NULL) {
        [self sendLockRequest];
    }
}

- (void)loadCam {
    NSURL *videoUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.%@:8080/video",ip]];
    
    
    NSString *html = [NSString stringWithFormat:@"<img style=\"-webkit-user-select: none\" src=\"%@\" width=\"100%%\" height=\"100%%\">", videoUrl];
    
    [self.webView loadHTMLString:html baseURL:nil];
}
- (IBAction)iptext:(id)sender {
    if (self.iptext.alpha == 0) {
        self.iptext.alpha = 1;
        self.iptext.text = ip;
    } else {
        self.iptext.alpha = 0;
        [[NSUserDefaults standardUserDefaults] setValue:self.iptext.text forKey:@"ip"];
        ip = self.iptext.text;
    }
}

- (void)setLockImage {
    [self.lock setImage:[UIImage imageNamed:@"lock.png"] forState:UIControlStateNormal];
}

- (void)setUnlockImage {
    [self.lock setImage:[UIImage imageNamed:@"unlock.png"] forState:UIControlStateNormal];
}

@end
