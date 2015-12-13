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
    self.root = (RootViewController *)[self parentViewController];
    self.user = [self.root getUser];

    NSArray *xCoordinates = self.user[@"xCoordinates"];
    NSArray *yCoordinates = self.user[@"yCoordinates"];
    NSString *xString = @"";
    NSString *yString = @"";
    for (int i = 0; i < [xCoordinates count]; i++) {
        xString = [xString stringByAppendingString: [NSString stringWithFormat: @"%@", [xCoordinates objectAtIndex: i]]];
        if (i < [xCoordinates count] - 1)
            xString = [xString stringByAppendingString: @", "];
        
        yString = [yString stringByAppendingString: [NSString stringWithFormat: @"%@", [yCoordinates objectAtIndex: i]]];
        if (i < [xCoordinates count] - 1)
            yString = [yString stringByAppendingString: @", "];
    }
    self.xLabel.text = xString;
    self.yLabel.text = yString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pinMe:(id)sender {
    NSNumber *x = [NSNumber numberWithInt: arc4random_uniform(1000)];
    NSNumber *y = [NSNumber numberWithInt: arc4random_uniform(1000)];
    [self.user addObject: x forKey: @"xCoordinates"];
    [self.user addObject: y forKey: @"yCoordinates"];
    [self.user saveInBackground];
}



@end
