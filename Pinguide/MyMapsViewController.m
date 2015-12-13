//
//  MyMapsViewController.m
//  Pinguide
//
//  Created by Kevin on 12/13/15.
//  Copyright © 2015 LMMSKZ. All rights reserved.
//

#import "MyMapsViewController.h"

@implementation MyMapsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.root = (RootViewController *)[self parentViewController];
    self.user = [self.root getUser];
    
    UITableView *tableView = (id)[self.view viewWithTag:1];
    UIEdgeInsets contentInset = tableView.contentInset;
    contentInset.top = 40;
    [tableView setContentInset:contentInset];
}

- (void)viewWillAppear:(BOOL)animated {
    PFRelation *relation = [self.user relationForKey: @"maps"];
    [[relation query] findObjectsInBackgroundWithBlock: ^(NSArray *maps, NSError *error) {
        if (!error){
            NSLog(@"maps loaded");
            self.myMaps = maps;
            
            [self.tableView reloadData];
        }
        else
            NSLog(@"map load failed");
    }];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.myMaps count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:SimpleTableIdentifier];
    }
    
    cell.textLabel.text = self.myMaps[indexPath.row][@"name"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(self.myMaps[indexPath.row][@"name"]);
    [self performSegueWithIdentifier: @"mapPressed" sender: nil];
}

- (IBAction)newMap:(id)sender {
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle: @"New Map"
                                message: NULL
                                preferredStyle: UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler: ^(UITextField *textField) {
       textField.placeholder = @"Map Name";
    }];
    
    UIAlertAction *okButton = [UIAlertAction
                               actionWithTitle: @"Ok"
                               style: UIAlertActionStyleDefault
                               handler: ^(UIAlertAction *action) {
                                   PFObject *map = [PFObject objectWithClassName: @"Map"];
                                   map[@"name"] = alert.textFields.firstObject.text;
                                   [map save];
                                   
                                   PFRelation *relation = [self.user relationForKey: @"maps"];
                                   [relation addObject: map];
                                   [self.user saveInBackgroundWithBlock: ^(BOOL succeeded, NSError *error) {
                                       if (succeeded) {
                                           NSLog(@"map and user saved");
                                           
                                           self.myMaps = [self.myMaps arrayByAddingObject: map];
                                           
                                           [self.tableView reloadData];
                                           [alert dismissViewControllerAnimated:YES completion: nil];
                                       }
                                       else [alert dismissViewControllerAnimated:YES completion:nil];
                                   }];
                               }];
    UIAlertAction *cancelButton = [UIAlertAction
                               actionWithTitle: @"Cancel"
                               style: UIAlertActionStyleDefault
                               handler: ^(UIAlertAction *action) {
                                   [alert dismissViewControllerAnimated:YES completion:nil];
                               }];
    [alert addAction: cancelButton];
    [alert addAction: okButton];
    [alert.view setNeedsLayout];
    [self presentViewController: alert animated: YES completion: nil];
    
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: @"mapPressed"]) {
        PinMeViewController *controller = (PinMeViewController *)[segue destinationViewController];
        controller.user = self.user;
    }
}

@end
