//
//  FriendViewController.m
//  Pinguide
//
//  Created by Kevin on 12/14/15.
//  Copyright © 2015 LMMSKZ. All rights reserved.
//

#import "FriendViewController.h"

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.friendLabel.text = [[[self convertToString: self.selectedFriend[@"firstName"]]
                               stringByAppendingString: @" "]
                               stringByAppendingString: [self convertToString: self.selectedFriend[@"lastName"]]];
    
    PFRelation *relation = [self.selectedFriend relationForKey: @"maps"];
    PFQuery *query = [relation query];
    [query whereKey: @"public" equalTo: [NSNumber numberWithBool: YES]];
    
    [query findObjectsInBackgroundWithBlock: ^(NSArray *maps, NSError *error) {
        if (!error){
            self.friendMaps = maps;
            [self.tableView reloadData];
        }
        else
            NSLog(@"map load failed");
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             
                             simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier: simpleTableIdentifier];
    }
    
    cell.textLabel.text = self.friendMaps[indexPath.row][@"name"];
    
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.friendMaps count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedMap = self.friendMaps[indexPath.row];
    [self performSegueWithIdentifier: @"friendMapPressed" sender: nil];
}

- (NSString *)convertToString: (id)object {
    return [NSString stringWithFormat: @"%@", object];
}

- (IBAction)goBack:(id)sender {
    [self performSegueWithIdentifier: @"friendReturn" sender: sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: @"friendMapPressed"]) {
        FriendMapViewController *controller = (FriendMapViewController *)[segue destinationViewController];
        controller.user = self.user;
        controller.selectedFriend = self.selectedFriend;
        controller.map = self.selectedMap;
    }
    else if ([self.from isEqualToString: @"search"]) {
        RootViewController *controller = (RootViewController *)[segue destinationViewController];
        controller.user = self.user;
        [controller setSelectedIndex: 1];
    }
    else if([self.from isEqualToString: @"list"]) {
        RootViewController *controller = (RootViewController *)[segue destinationViewController];
        controller.user = self.user;
        [controller setSelectedIndex: 2];
    }
}

@end
