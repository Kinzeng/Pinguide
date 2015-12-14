//
//  MyFriendsViewController.m
//  Pinguide
//
//  Created by Kevin on 12/13/15.
//  Copyright © 2015 LMMSKZ. All rights reserved.
//

#import "MyFriendsViewController.h"

@implementation MyFriendsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidLoad];
    self.root = (RootViewController *)[self parentViewController];
    self.user = [self.root getUser];
    
    PFRelation *relation = [self.user relationForKey: @"friends"];
    [[relation query] findObjectsInBackgroundWithBlock: ^(NSArray *objects, NSError *error) {
        if (!error) {
            self.friends = objects;
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.friends count];
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
    
    NSString *name = [[[self convertToString: self.friends[indexPath.row][@"firstName"]]
                       stringByAppendingString: @" "]
                      stringByAppendingString: [self convertToString: self.friends[indexPath.row][@"lastName"]]];
    cell.textLabel.text = name;
    
    return cell;
}

- (NSString *)convertToString: (id)object {
    return [NSString stringWithFormat: @"%@", object];
}

@end
