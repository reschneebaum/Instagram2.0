//
//  DetailProfileImageViewController.m
//  Instagram2.0
//
//  Created by Edil Ashimov on 8/11/15.
//  Copyright (c) 2015 Rachel Schneebaum. All rights reserved.
//

#import "DetailImageViewController.h"
#import "ProfileViewController.h"
#import "NewsFeedViewController.h"
#import "CameraViewController.h"
#import "SearchViewController.h"
#import "FriendProfileViewController.h"
#import "CommentTableViewController.h"
#import "Photo.h"

@interface DetailImageViewController ()

@property Photo *photo;

@end

@implementation DetailImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}



#pragma mark - set up toolbar button segues
#pragma mark -

- (IBAction)onHomeButtonPressed:(UIBarButtonItem *)sender {
    NewsFeedViewController *NewsVC =[self.storyboard instantiateViewControllerWithIdentifier:@"NewsVC"];
    [self.navigationController pushViewController:NewsVC animated:true];
}

- (IBAction)onSearchButtonPressed:(UIBarButtonItem *)sender {
    SearchViewController *searchVC =[self.storyboard instantiateViewControllerWithIdentifier:@"searchVC"];
    [self.navigationController pushViewController:searchVC animated:true];
}

- (IBAction)onCameraButtonPressed:(UIBarButtonItem *)sender {
    CameraViewController *cameraVC =[self.storyboard instantiateViewControllerWithIdentifier:@"cameraVC"];
    [self.navigationController pushViewController:cameraVC animated:true];
}

- (IBAction)onLikesButtonPressed:(UIBarButtonItem *)sender {
    // note: make sure this passes only liked photos array
    NewsFeedViewController *newsVC =[self.storyboard instantiateViewControllerWithIdentifier:@"NewsVC"];
    [self.navigationController pushViewController:newsVC animated:true];
}

- (IBAction)onProfileButtonPressed:(UIBarButtonItem *)sender {
    ProfileViewController *profileVC = [self.storyboard instantiateViewControllerWithIdentifier:@"profileVC"];
    [self.navigationController pushViewController:profileVC animated:true];
}




@end
