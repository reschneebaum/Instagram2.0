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
    self.usernameTextField.text = @"user2";
    self.passwordTextField.text = @"test2";
}

-(void)loadUsers {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    NSSortDescriptor *userSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:true];
    request.sortDescriptors = @[userSortDescriptor];
    self.users = [self.moc executeFetchRequest:request error:nil];
    NSLog(@"%@, %@", [self.users valueForKey:@"username"], [self.users valueForKey:@"password"]);
}

- (IBAction)onLoginButtonPressed:(UIButton *)sender {
    for (User *user in self.users) {
        if ([user.username isEqualToString:self.usernameTextField.text] && [user.password isEqualToString:self.passwordTextField.text]) {
            self.areUsers = true;
            self.user = user;
        }
    }

    if (self.areUsers == true) {
        NSLog(@"go to profile page!");
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
    } else {
        NSLog(@"go to signup page!");
        // note: create a helper method that returns nothing & takes UIAlertController as parameter
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
            self.usernameTextField.text = usernameTextField.text;
            UITextField *passwordTextField = ((UITextField *)[wrongAccountAlert.textFields objectAtIndex:3]);
            self.passwordTextField.text = passwordTextField.text;
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
    // note: user helper method mentioned above
    UIAlertController *createAccountAlert = [UIAlertController alertControllerWithTitle:@"Create a new account" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [createAccountAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"First Name";
    }];
    [createAccountAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Last Name";
    }];
    [createAccountAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Username";
    }];
    [createAccountAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Password";
        textField.secureTextEntry = true;
    }];
    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *firstNameTextField = ((UITextField *)[createAccountAlert.textFields objectAtIndex:0]);
        UITextField *lastNameTextField = ((UITextField *)[createAccountAlert.textFields objectAtIndex:1]);
        UITextField *usernameTextField = ((UITextField *)[createAccountAlert.textFields objectAtIndex:2]);
        self.usernameTextField.text = usernameTextField.text;
        UITextField *passwordTextField = ((UITextField *)[createAccountAlert.textFields objectAtIndex:3]);
        self.passwordTextField.text = passwordTextField.text;
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
    [createAccountAlert addAction:addAction];
    [createAccountAlert addAction:cancelAction];
    [self presentViewController:createAccountAlert animated:true completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ProfileViewController *profileVC = segue.destinationViewController;
    profileVC.moc = self.moc;
    profileVC.user = self.user;
    profileVC.users = self.users;
}

@end
