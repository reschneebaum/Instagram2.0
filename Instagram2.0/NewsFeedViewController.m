//
//  NewsFeedViewController.m
//  Instagram2.0
//
//  Created by Rachel Schneebaum on 8/11/15.
//  Copyright (c) 2015 Rachel Schneebaum. All rights reserved.
//

#import "NewsFeedViewController.h"
#import "ProfileViewController.h"
#import "CameraViewController.h"
#import "SearchViewController.h"
#import "FriendProfileViewController.h"
#import "DetailImageViewController.h"
#import "CommentTableViewController.h"
#import "PhotoDetailCell.h"
#import "User.h"
#import "Photo.h"

@interface NewsFeedViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;
@property (weak, nonatomic) IBOutlet UIButton *usernameButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@end

@implementation NewsFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.selectedImageView.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@", self.photo.image]];
}


#pragma mark - UITableView data source methods
#pragma mark -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photos.count;
}

-(PhotoDetailCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCellID"];

    return cell;
}

- (IBAction)onUsernameButtonPressed:(UIButton *)sender {
    FriendProfileViewController *friendVC =[self.storyboard instantiateViewControllerWithIdentifier:@"friendVC"];
    [self.navigationController pushViewController:friendVC animated:true];
    friendVC.user.username = self.usernameButton.titleLabel.text;
    friendVC.moc = self.moc;
}

- (IBAction)onLikeButtonPressed:(UIButton *)sender {
    self.likeButton.layer.backgroundColor = [[UIColor redColor]CGColor];
    self.likeButton.layer.cornerRadius = 5.0;
    self.likeButton.titleLabel.textColor = [UIColor whiteColor];
//    self.photo.likesNumber = (int)self.photo.likesNumber + 1;
    
}

- (IBAction)onCommentButtonClass:(UIButton *)sender {
    CommentTableViewController *commentVC =[self.storyboard instantiateViewControllerWithIdentifier:@"commentVC"];
    [self.navigationController pushViewController:commentVC animated:true];
    commentVC.moc = self.moc;
    commentVC.photo = self.photo;
}

#pragma mark - set up toolbar button segues
#pragma mark -

- (IBAction)onHomeButtonPressed:(UIBarButtonItem *)sender {
    sender.enabled = false;
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
