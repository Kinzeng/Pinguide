//
//  FriendMapViewController.m
//  Pinguide
//
//  Created by Kevin on 12/14/15.
//  Copyright © 2015 LMMSKZ. All rights reserved.
//

#import "FriendMapViewController.h"

@implementation FriendMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self updateLabels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)goBack:(id)sender {
    [self performSegueWithIdentifier: @"friendMapReturn" sender: sender];
}

- (void)updateLabels {
    NSArray *latitudes = self.map[@"latitudes"];
    NSArray *longitudes = self.map[@"longitudes"];
    if ([latitudes count] > 0) {
        NSString *latString = @"";
        NSString *lonString = @"";
        for (int i = 0; i < [latitudes count]; i++) {
            latString = [latString stringByAppendingString: [NSString stringWithFormat: @"%@", [latitudes objectAtIndex: i]]];
            if (i < [latitudes count] - 1)
                latString = [latString stringByAppendingString: @", "];
            
            lonString = [lonString stringByAppendingString: [NSString stringWithFormat: @"%@", [longitudes objectAtIndex: i]]];
            if (i < [longitudes count] - 1)
                lonString = [lonString stringByAppendingString: @", "];
        }
        self.xLabel.text = latString;
        self.yLabel.text = lonString;
    }
    else {
        self.xLabel.text = @"No coordinates";
        self.yLabel.text = @"";
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: @"friendMapReturn"]) {
        FriendViewController *controller = (FriendViewController *)[segue destinationViewController];
        controller.user = self.user;
        controller.selectedFriend = self.selectedFriend;
    }
}


@end

