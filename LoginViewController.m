//
//  LoginViewController.m
//  Pinguide
//
//  Created by Kevin on 12/11/15.
//  Copyright © 2015 LMMSKZ. All rights reserved.
//

#import "LoginViewController.h"
#import "RootViewController.h"

@implementation LoginViewController

- (IBAction)login:(id)sender {
    [PFUser logInWithUsernameInBackground: self.usernameField.text password:self.passwordField.text block: ^(PFUser *user, NSError *error){
        if (user) {
            NSLog(@"success");
            self.user = user;
            [self performSegueWithIdentifier: @"logInSuccess" sender: sender];
        }
        else {
            UIAlertController *alert = [UIAlertController
                                        alertControllerWithTitle: @"Log In Failed"
                                        message: @"Check your username and password and try again"
                                        preferredStyle: UIAlertControllerStyleAlert];
            
            UIAlertAction *okButton = [UIAlertAction
                                       actionWithTitle: @"Ok"
                                       style: UIAlertActionStyleDefault
                                       handler: ^(UIAlertAction *action) {
                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                       }];
            [alert addAction: okButton];
            [self presentViewController: alert animated: YES completion: nil];
        }
    }];
}

- (IBAction)signUp:(id)sender {
    [self performSegueWithIdentifier: @"signUp" sender: sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: @"logInSuccess"]) {
        RootViewController *controller = (RootViewController *)segue.destinationViewController;
        controller.user = self.user;
    }
}

@end
