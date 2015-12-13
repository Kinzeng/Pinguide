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
    /*
    PFUser *user = [PFUser user];
    user.username = @"my name";
    user.password = @"my pass";
    user.email = @"email@example.com";
    
    // other fields can be set if you want to save more information
    user[@"phone"] = @"650-555-0000";
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
        } else {
            NSString *errorString = [error userInfo][@"error"];
            //NSLog(errorString);
        }
    }];
    */
    self.root = (RootViewController *)[self parentViewController];
    self.user = [self.root getUser];
    /*
    PFQuery *xQuery = [PFQuery queryWithClassName: @"User"];
    PFQuery *yQuery = [PFQuery queryWithClassName: @"User"];
    [xQuery includeKey: @"xCoordinates"];
    [yQuery includeKey: @"yCoordinates"];
    [xQuery findObjectsInBackgroundWithBlock: ^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(objects[0]);
        }
        else {
            
        }
    }];
    [yQuery findObjectsInBackgroundWithBlock: ^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(objects[0]);
        }
        else {
            
        }
    }];
     */
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
