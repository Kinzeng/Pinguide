//
//  LoginViewController.h
//  Pinguide
//
//  Created by Kevin on 12/11/15.
//  Copyright © 2015 LMMSKZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end
