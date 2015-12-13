//
//  PinMeViewController.h
//  Pinguide
//
//  Created by Kevin on 12/8/15.
//  Copyright © 2015 LMMSKZ. All rights reserved.
//

#import "PinMeViewController.h"
#import "SecondViewController.h"
#import "RootViewController.h"
#include <stdlib.h>
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>

@interface PinMeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *pinButton;
@property (weak, nonatomic) IBOutlet UILabel *xLabel;
@property (weak, nonatomic) IBOutlet UILabel *yLabel;
@property (weak, nonatomic) PFUser *user;
@property (weak, nonatomic) RootViewController *root;

@end

