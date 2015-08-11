//
//  DetailProfileImageViewController.m
//  Instagram2.0
//
//  Created by Edil Ashimov on 8/11/15.
//  Copyright (c) 2015 Rachel Schneebaum. All rights reserved.
//

#import "DetailProfileImageViewController.h"
#import "Photo.h"
@interface DetailProfileImageViewController ()
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property Photo *photo;

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

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"Delete"]) {
       NSMutableArray *arrayOfImages = [NSMutableArray arrayWithCapacity:10];

        [arrayOfImages removeObject:[NSString stringWithFormat:@"%@", self.photo]];

        }
}
























                            @end
