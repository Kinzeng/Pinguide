//
//  FirstViewController.m
//  Pinguide
//
//  Created by Kevin on 12/8/15.
//  Copyright © 2015 LMMSKZ. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import <Parse/Parse.h>

@interface FirstViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) PFUser *user;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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
    
    PFQuery query = [PFQuery ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendData:(id)sender {
    self.user = [PFUser user];
    self.user.username = self.usernameField.text;
    self.user.password = self.passwordField.text;
    [self.user signUp];
    NSLog(@"saved");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: @"secondView"]) {
        NSLog(@"segue");
        //SecondViewController *controller = (SecondViewController *) segue;
        //controller.objectID = self.data.objectId;
    }
    
}

@end
