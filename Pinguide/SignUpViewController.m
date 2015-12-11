//
//  SignUpViewController.m
//  Pinguide
//
//  Created by Kevin on 12/11/15.
//  Copyright © 2015 LMMSKZ. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

@implementation SignUpViewController

- (IBAction)signUp:(id)sender {
    if ([self.firstField.text isEqualToString: @""] || [self.lastField.text isEqualToString: @""] || [self.usernameField.text isEqualToString: @""] || [self.emailField.text isEqualToString: @""] || [self.passwordField.text isEqualToString: @""] || [self.confirmField.text isEqualToString: @""]) {
        UIAlertController *alert=   [UIAlertController
                                     alertControllerWithTitle: @"Missing Information"
                                     message: @"Please fill out all of the text fields"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okButton = [UIAlertAction
                                   actionWithTitle: @"Ok"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action)
                                   {
                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                   }];
        [alert addAction: okButton];
        [self presentViewController: alert animated: YES completion: nil];
    }
    else if (![self.passwordField.text isEqualToString: self.confirmField.text]) {
        UIAlertController *alert=   [UIAlertController
                                     alertControllerWithTitle: @"Passwords Don't Match"
                                     message: @"Check your passwords and try again"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okButton = [UIAlertAction
                                   actionWithTitle: @"Ok"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action)
                                   {
                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                   }];
        [alert addAction: okButton];
        [self presentViewController: alert animated: YES completion: nil];
    }
    else {
        PFUser *user = [PFUser user];
        user.username = self.usernameField.text;
        user.password = self.passwordField.text;
        user.email = self.emailField.text;
        user[@"firstName"] = self.firstField.text;
        user[@"lastName"] = self.lastField.text;
        
        [user signUpInBackgroundWithBlock: ^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                UIAlertController *alert=   [UIAlertController
                                             alertControllerWithTitle: @"Sign Up Success!"
                                             message: @""
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okButton = [UIAlertAction
                                           actionWithTitle: @"Ok"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action)
                                           {
                                               [alert dismissViewControllerAnimated:YES completion:nil];
                                               [self performSegueWithIdentifier: @"returnToLogin" sender: sender];
                                           }];
                [alert addAction: okButton];
                [self presentViewController: alert animated: YES completion: nil];
            }
            else {
                UIAlertController *alert=   [UIAlertController
                                             alertControllerWithTitle: @"Sign Up Error"
                                             message: [error userInfo][@"error"]
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okButton = [UIAlertAction
                                           actionWithTitle: @"Ok"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action)
                                           {
                                               [alert dismissViewControllerAnimated:YES completion:nil];
                                           }];
                [alert addAction: okButton];
                [self presentViewController: alert animated: YES completion: nil];
            }
        }];
    }
}

- (IBAction)cancel:(id)sender {
    [self performSegueWithIdentifier: @"returnToLogin" sender: sender];
}

@end
