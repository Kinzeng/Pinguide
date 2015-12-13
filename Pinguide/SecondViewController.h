//
//  SecondViewController.h
//  Pinguide
//
//  Created by Kevin on 12/8/15.
//  Copyright © 2015 LMMSKZ. All rights reserved.
//

#import "RootViewController.h"
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SecondViewController : UIViewController

@property (weak, nonatomic) PFUser *user;
@property (weak, nonatomic) RootViewController *root;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

