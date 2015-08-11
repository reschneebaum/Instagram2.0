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
   UIAlertView *alertViewText = [[UIAlertView alloc]
                                 initWithTitle:@"Are Your Sure You Want to Delete This Image?"
                                 message:alertViewText delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:Delete  , nil

    
@end
