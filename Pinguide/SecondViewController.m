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

@property (weak, nonatomic) IBOutlet UILabel *retrievedData;

@end

@implementation SecondViewController

@synthesize objectID;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    PFQuery *query = [PFQuery queryWithClassName: @"Data"];
    
    self.retrievedData.text = [query getObjectWithId: self.objectID][@"text"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
