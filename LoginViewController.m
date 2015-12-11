//
//  LoginViewController.m
//  Pinguide
//
//  Created by Kevin on 12/11/15.
//  Copyright © 2015 LMMSKZ. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@implementation LoginViewController

- (IBAction)login:(id)sender {
    [PFUser logInWithUsernameInBackground: self.usernameField.text password:self.passwordField.text block: ^(PFUser *user, NSError *error){
        if (user) {
            NSLog(@"success");
            [self performSegueWithIdentifier: @"logInSuccess" sender: sender];
        }
        else {
            NSLog([error userInfo][@"error"]);
        }
        
    }];
}

- (IBAction)signUp:(id)sender {
    [self performSegueWithIdentifier: @"signUp" sender: sender];
}

@end
