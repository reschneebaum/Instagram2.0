//
//  ViewController.m
//  Instagram2.0
//
//  Created by Rachel Schneebaum on 8/10/15.
//  Copyright (c) 2015 Rachel Schneebaum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "User.h"

@interface LoginViewController ()

@property NSManagedObjectContext *moc;
@property NSArray *users;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property BOOL areUsers;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.moc = delegate.managedObjectContext;
    [self loadUsers];

    self.passwordTextField.secureTextEntry = true;
}

-(void)loadUsers {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    NSSortDescriptor *userSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:true];
    request.sortDescriptors = @[userSortDescriptor];
    self.users = [self.moc executeFetchRequest:request error:nil];
    NSLog(@"%@, %@", [self.users valueForKey:@"username"], [self.users valueForKey:@"password"]);
}

- (IBAction)onLoginButtonPressed:(UIButton *)sender {
//    if (self.users.count > 0) {
    for (User *user in self.users) {
        while (!([user.username isEqualToString:self.usernameTextField.text] && [user.password isEqualToString:self.passwordTextField.text])) {
            self.areUsers = false;

            if (user == self.users.lastObject)
                break;
        }
    }

        if (self.areUsers == true) {
            NSLog(@"go to profile page!");
        } else {
            NSLog(@"go to signup page!");
            UIAlertController *wrongAccountAlert = [UIAlertController alertControllerWithTitle:@"Create a new account" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [wrongAccountAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                    textField.placeholder = @"First Name";
            }];
            [wrongAccountAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                    textField.placeholder = @"Last Name";
            }];
            [wrongAccountAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                    textField.placeholder = @"Username";
            }];
            [wrongAccountAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                    textField.placeholder = @"Password";
                textField.secureTextEntry = true;
            }];
            UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                UITextField *firstNameTextField = ((UITextField *)[wrongAccountAlert.textFields objectAtIndex:0]);
                UITextField *lastNameTextField = ((UITextField *)[wrongAccountAlert.textFields objectAtIndex:1]);
                UITextField *usernameTextField = ((UITextField *)[wrongAccountAlert.textFields objectAtIndex:2]);
                UITextField *passwordTextField = ((UITextField *)[wrongAccountAlert.textFields objectAtIndex:3]);
                NSManagedObject *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.moc];
                [user setValue:firstNameTextField.text forKey:@"firstName"];
                [user setValue:lastNameTextField.text forKey:@"lastName"];
                [user setValue:usernameTextField.text forKey:@"username"];
                [user setValue:passwordTextField.text forKey:@"password"];
                [self.moc save:nil];
                [self loadUsers];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }];
            [wrongAccountAlert addAction:addAction];
            [wrongAccountAlert addAction:cancelAction];
            [self presentViewController:wrongAccountAlert animated:true completion:nil];
        }
}

- (IBAction)onCreateAccountButtonPressed:(UIButton *)sender {
}

@end
