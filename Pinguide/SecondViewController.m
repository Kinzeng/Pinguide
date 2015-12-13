//
//  SecondViewController.m
//  Pinguide
//
//  Created by Kevin on 12/8/15.
//  Copyright © 2015 LMMSKZ. All rights reserved.
//

#import "SecondViewController.h"
#import <Parse/Parse.h>

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.root = (RootViewController *)[self parentViewController];
    self.user = [self.root getUser];
}

- (void)viewWillAppear:(BOOL)animated {
    self.nameField.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)makeMap:(id)sender {
    PFObject *map = [PFObject objectWithClassName: @"Map"];
    map[@"name"] = self.nameField.text;
    [map save];
    
    PFRelation *relation = [self.user relationForKey: @"maps"];
    [relation addObject: map];
    [self.user save];
    
    [self.root setSelectedIndex: 0];
}

@end
