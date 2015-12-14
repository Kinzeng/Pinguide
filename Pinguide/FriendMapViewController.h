//
//  FriendMapViewController.h
//  Pinguide
//
//  Created by Kevin on 12/14/15.
//  Copyright © 2015 LMMSKZ. All rights reserved.
//

#import "FriendViewController.h"
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>

@interface FriendMapViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *xLabel;
@property (weak, nonatomic) IBOutlet UILabel *yLabel;
@property (weak, nonatomic) PFUser *user;
@property (weak, nonatomic) PFUser *selectedFriend;
@property (weak, nonatomic) PFObject *map;

@end