//
// SearchFriendsViewController.m
//  Pinguide
//
//  Created by Kevin on 12/8/15.
//  Copyright © 2015 LMMSKZ. All rights reserved.
//

#import "SearchFriendsViewController.h"
#import <Parse/Parse.h>

@implementation SearchFriendsViewController

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

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.names count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             
                             simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier: simpleTableIdentifier];
    }
    
    
    cell.textLabel.text = self.names[indexPath.row];
    PFRelation *relation = [self.user relationForKey: @"friends"];
    [[relation query] findObjectsInBackgroundWithBlock: ^(NSArray *objects, NSError *error) {
        if (!error) {
            if ([objects containsObject: self.foundFriends[indexPath.row]]) {
                cell.textLabel.textColor = [UIColor greenColor];
            }
        }
    }];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle: @"Add Friend?"
                                message: NULL
                                preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *confirmButton = [UIAlertAction
                               actionWithTitle: @"Confirm"
                               style: UIAlertActionStyleDefault
                               handler: ^(UIAlertAction *action) {
                                   PFRelation *relation = [self.user relationForKey: @"friends"];
                                   [relation addObject: self.foundFriends[indexPath.row]];
                                   [self.user saveInBackgroundWithBlock: ^(BOOL succeeded, NSError *error) {
                                           [self.tableView reloadData];
                                           [alert dismissViewControllerAnimated:YES completion: nil];
                                   }];
                               }];
    UIAlertAction *cancelButton = [UIAlertAction
                                   actionWithTitle: @"Cancel"
                                   style: UIAlertActionStyleDefault
                                   handler: ^(UIAlertAction *action) {
                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                   }];
    [alert addAction: cancelButton];
    [alert addAction: confirmButton];
    [alert.view setNeedsLayout];
    [self presentViewController: alert animated: YES completion: nil];
    
    [self.tableView reloadData];

}

- (IBAction)searchFriends:(id)sender {
    self.names = [NSArray arrayWithObjects: @"Loading...", nil];
    [self.tableView reloadData];
    
    NSArray *input = [self.nameField.text componentsSeparatedByString: @" "];
    
    PFQuery *query = [PFUser query];
    
    NSLog([self.user username]);
    [query whereKey: @"username" notEqualTo: [self.user username]];
    
    

    for (int i = 0; i < [input count]; i++) {
        NSArray<PFQuery *> *subs = [NSArray array];
        subs = [subs arrayByAddingObject: [[PFUser query] whereKey:@"firstName" containsString: input[i]]];
        subs = [subs arrayByAddingObject: [[PFUser query] whereKey:@"lastName" containsString: input[i]]];
        
        query = [PFQuery orQueryWithSubqueries: subs];
    }
    
    [query findObjectsInBackgroundWithBlock: ^(NSArray *objects, NSError *error) {
        if (!error) {
            if ([objects count] == 0) {
                self.names = [NSArray arrayWithObjects: @"No Matches", nil];
            }
            else {
                NSArray *foundNames = [NSMutableArray array];
                NSArray *foundFriends = [NSMutableArray array];
                for (int i = 0; i < [objects count]; i++) {
                    if (![[self.user username] isEqualToString: [objects[i] username]]) {
                        NSString *name = [[[self convertToString: objects[i][@"firstName"]]
                                        stringByAppendingString: @" "]
                                        stringByAppendingString: [self convertToString: objects[i][@"lastName"]]];
                        foundNames = [foundNames arrayByAddingObject: name];
                        foundFriends = [foundFriends arrayByAddingObject: objects[i]];
                    }
                }
                self.names = foundNames;
                self.foundFriends = foundFriends;
            }
            [self.tableView reloadData];
        }
    }];
}

- (NSString *)convertToString: (id)object {
    return [NSString stringWithFormat: @"%@", object];
}

@end
