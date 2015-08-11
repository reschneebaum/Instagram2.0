//
//  DetailProfileImageViewController.m
//  Instagram2.0
//
//  Created by Edil Ashimov on 8/11/15.
//  Copyright (c) 2015 Rachel Schneebaum. All rights reserved.
//

#import "DetailProfileImageViewController.h"

@interface DetailProfileImageViewController ()
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end

@implementation DetailProfileImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)onCreateAccountButtonPressed:(UIButton *)sender {
    NSString *alertViewText = [[NSString alloc] initWithFormat:@"Are you sure you want to delete this image?"];
    UIAlertView *alert = [[UIAlertView alloc]
                                 initWithTitle:@"Delete Image?"
                                 message:alertViewText delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
    [alert show];
//    [alert release];
}
@end
