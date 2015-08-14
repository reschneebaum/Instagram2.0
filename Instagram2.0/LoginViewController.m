//
//  ViewController.m
//  Instagram2.0
//
//  Created by Rachel Schneebaum on 8/10/15.
//  Copyright (c) 2015 Rachel Schneebaum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "User.h"

@interface LoginViewController ()

@property NSManagedObjectContext *moc;
@property NSArray *users;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property BOOL areUsers;
@property User *user;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.moc = delegate.managedObjectContext;
    [self loadUsers];

    self.passwordTextField.secureTextEntry = true;
    self.usernameTextField.text = @"fiaz";
    self.passwordTextField.text = @"sami";
}

-(void)loadUsers {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    NSSortDescriptor *userSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:true];
    request.sortDescriptors = @[userSortDescriptor];
    self.users = [self.moc executeFetchRequest:request error:nil];
    NSLog(@"%@, %@", [self.users valueForKey:@"username"], [self.users valueForKey:@"password"]);
}

-(void)presentAlertController:(UIAlertController *)alertController {
    alertController = [UIAlertController alertControllerWithTitle:@"Create a new account" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"First Name";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Last Name";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Username";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Password";
        textField.secureTextEntry = true;
    }];
    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *firstNameTextField = ((UITextField *)[alertController.textFields objectAtIndex:0]);
        UITextField *lastNameTextField = ((UITextField *)[alertController.textFields objectAtIndex:1]);
        UITextField *usernameTextField = ((UITextField *)[alertController.textFields objectAtIndex:2]);
        self.usernameTextField.text = usernameTextField.text;
        UITextField *passwordTextField = ((UITextField *)[alertController.textFields objectAtIndex:3]);
        self.passwordTextField.text = passwordTextField.text;
        NSManagedObject *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.moc];
        if (usernameTextField.text.length > 0 && passwordTextField.text.length > 0) {
            [user setValue:firstNameTextField.text forKey:@"firstName"];
            [user setValue:lastNameTextField.text forKey:@"lastName"];
            [user setValue:usernameTextField.text forKey:@"username"];
            [user setValue:passwordTextField.text forKey:@"password"];
            [self.moc save:nil];
            [self loadUsers];
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    [alertController addAction:addAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:true completion:nil];
}

- (IBAction)onLoginButtonPressed:(UIButton *)sender {
    for (User *user in self.users) {
        if ([user.username isEqualToString:self.usernameTextField.text] && [user.password isEqualToString:self.passwordTextField.text]) {
            self.areUsers = true;
            self.user = user;
        }
        if ([user.username isEqualToString:self.usernameTextField.text] && ![user.password isEqualToString:self.passwordTextField.text]) {
            NSLog(@"wrong password!");
        }
    }
    if (self.areUsers) {
        NSLog(@"go to profile page!");
        ProfileViewController *profileVC=[self.storyboard instantiateViewControllerWithIdentifier:@"profileVC"];
        [self.navigationController pushViewController:profileVC animated:YES];
        profileVC.user = self.user;
        profileVC.users = self.users;
        profileVC.moc = self.moc;
        NSLog(@"self.user.username: %@", self.user.username);
        NSLog(@"self.users.count: %lu", (unsigned long)self.users.count);
    } else {
        NSLog(@"go to signup page!");
        UIAlertController *wrongAccountAlert = [UIAlertController new];
        [self presentAlertController:wrongAccountAlert];
    }
}

- (IBAction)onCreateAccountButtonPressed:(UIButton *)sender {
    UIAlertController *createAccountAlert = [UIAlertController new];
    [self presentAlertController:createAccountAlert];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

@end
