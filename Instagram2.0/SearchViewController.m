//
//  SearchViewController.m
//  Instagram2.0
//
//  Created by Rachel Schneebaum on 8/11/15.
//  Copyright (c) 2015 Rachel Schneebaum. All rights reserved.
//

#import "SearchViewController.h"
#import "ProfileViewController.h"
#import "NewsFeedViewController.h"
#import "CameraViewController.h"
#import "FriendProfileViewController.h"
#import "DetailImageViewController.h"
#import "CommentTableViewController.h"
#import "PhotoDetailCell.h"

@interface SearchViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - UITableView data source methods
#pragma mark

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photos.count;
}

-(PhotoDetailCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchTableViewID"];

    return cell;
}

#pragma mark - set up toolbar button segues
#pragma mark -

- (IBAction)onHomeButtonPressed:(UIBarButtonItem *)sender {
    NewsFeedViewController *NewsVC =[self.storyboard instantiateViewControllerWithIdentifier:@"NewsVC"];
    [self.navigationController pushViewController:NewsVC animated:true];
}

- (IBAction)onSearchButtonPressed:(UIBarButtonItem *)sender {
    sender.enabled = false;
}

- (IBAction)onCameraButtonPressed:(UIBarButtonItem *)sender {
    CameraViewController *cameraVC =[self.storyboard instantiateViewControllerWithIdentifier:@"cameraVC"];
    [self.navigationController pushViewController:cameraVC animated:true];
}

- (IBAction)onLikesButtonPressed:(UIBarButtonItem *)sender {
        NewsFeedViewController *newsVC =[self.storyboard instantiateViewControllerWithIdentifier:@"NewsVC"];
        [self.navigationController pushViewController:newsVC animated:true];
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
        request.predicate = [NSPredicate predicateWithFormat:@"isLiked == %@", self.user];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"whenTaken" ascending:true]];
        newsVC.photos = [self.moc executeFetchRequest:request error:nil];
        newsVC.moc = self.moc;
        newsVC.user = self.user;

}

- (IBAction)onProfileButtonPressed:(UIBarButtonItem *)sender {
    ProfileViewController *profileVC = [self.storyboard instantiateViewControllerWithIdentifier:@"profileVC"];
    [self.navigationController pushViewController:profileVC animated:true];
}

@end
