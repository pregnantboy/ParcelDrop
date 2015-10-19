//
//  FirstViewController.h
//  SmartLocker
//
//  Created by Ian Chen on 17/10/15.
//  Copyright (c) 2015 Ian Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *lock;
@property (weak, nonatomic) IBOutlet UITextField *iptext;

@end

