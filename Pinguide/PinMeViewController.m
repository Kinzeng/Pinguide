//
//  PinMeViewController.m
//  Pinguide
//
//  Created by Kevin on 12/8/15.
//  Copyright © 2015 LMMSKZ. All rights reserved.
//

#import "PinMeViewController.h"

@interface PinMeViewController ()

@end

@implementation PinMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self updateLabels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pinMe:(id)sender {
    NSNumber *x = [NSNumber numberWithInt: arc4random_uniform(1000)];
    NSNumber *y = [NSNumber numberWithInt: arc4random_uniform(1000)];
    [self.map addObject: x forKey: @"latitudes"];
    [self.map addObject: y forKey: @"longitudes"];
    [self.map save];
    [self.user save];
    [self updateLabels];
}

- (IBAction)return:(id)sender {
    [self performSegueWithIdentifier: @"selfMapReturn" sender: sender];
}

- (void)updateLabels {
    NSArray *latitudes = self.map[@"latitudes"];
    NSArray *longitudes = self.map[@"longitudes"];
    if ([latitudes count] > 0) {
        NSString *latString = @"";
        NSString *lonString = @"";
        for (int i = 0; i < [latitudes count]; i++) {
            latString = [latString stringByAppendingString: [NSString stringWithFormat: @"%@", [latitudes objectAtIndex: i]]];
            if (i < [latitudes count] - 1)
                latString = [latString stringByAppendingString: @", "];
        
            lonString = [lonString stringByAppendingString: [NSString stringWithFormat: @"%@", [longitudes objectAtIndex: i]]];
            if (i < [longitudes count] - 1)
                lonString = [lonString stringByAppendingString: @", "];
        }
        self.xLabel.text = latString;
        self.yLabel.text = lonString;
    }
    else {
        self.xLabel.text = @"No coordinates";
        self.yLabel.text = @"";
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: @"selfMapReturn"]) {
        RootViewController *controller = (RootViewController *)[segue destinationViewController];
        controller.user = self.user;
    }
}


@end
