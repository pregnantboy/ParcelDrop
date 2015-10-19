//
//  SecondViewController.h
//  SmartLocker
//
//  Created by Ian Chen on 17/10/15.
//  Copyright (c) 2015 Ian Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeliveryTableViewCell.h"

@interface SecondViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIView *signView;

@end

