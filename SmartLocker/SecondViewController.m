//
//  SecondViewController.m
//  SmartLocker
//
//  Created by Ian Chen on 17/10/15.
//  Copyright (c) 2015 Ian Chen. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

BOOL acked;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    acked = NO;
    self.signView.alpha = 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (DeliveryTableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"cell";
    
    DeliveryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[DeliveryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDate *now = [NSDate date];
    int tosub = (int)indexPath.row * -1 * 3600 * (24-(int)indexPath.row);
    NSDate *day = [now dateByAddingTimeInterval:tosub];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd MMM yyyy, E";
    cell.date.text = [NSString stringWithFormat:@"Date: %@", [dateFormatter stringFromDate: day]];
    dateFormatter.dateFormat = @"h:mm a";
    cell.time.text = [NSString stringWithFormat:@"Time, %@", [dateFormatter stringFromDate:day]];
    [cell.status setImage:[UIImage imageNamed:@"acknowledge.png"]];
    if (indexPath.row == 0 && !acked) {
        [cell.status setImage:[UIImage imageNamed:@"delivered.png"]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        self.signView.alpha = 1;
    }
}


- (IBAction)acknowledge:(id)sender {
    acked = YES;
    self.signView.alpha = 0;
    [self.table reloadData];
}
- (IBAction)cancel:(id)sender {
    self.signView.alpha = 0;
    [self.table reloadData];
}


@end
