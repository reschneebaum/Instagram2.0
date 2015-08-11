//
//  ProfileViewController.m
//  Instagram2.0
//
//  Created by Rachel Schneebaum on 8/11/15.
//  Copyright (c) 2015 Rachel Schneebaum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ProfileViewController.h"
#import "User.h"
#import "Photo.h"

@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *profileCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *photosButton;
@property (weak, nonatomic) IBOutlet UIButton *friendsButton;
@property NSArray *photos;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", self.users.firstObject);
    NSLog(@"%@", self.user.username);
    NSLog(@"%@", self.user.password);
    NSLog(@"%@", self.user.firstName);
    NSLog(@"%@", self.user.lastName);

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.moc = delegate.managedObjectContext;
    [self setUserInformation];
    [self loadOwnPhotos];
}

-(void)loadOwnPhotos {
    NSFetchRequest *userPhotoRequest = [[NSFetchRequest alloc] initWithEntityName:@"Photo"];
    userPhotoRequest.predicate = [NSPredicate predicateWithFormat:@"userPhotos CONTAINS %@", self.user];
    NSSortDescriptor *userPhotoSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"whenTaken" ascending:false];
    userPhotoRequest.sortDescriptors = @[userPhotoSortDescriptor];
    self.photos = [self.moc executeFetchRequest:userPhotoRequest error:nil];
    NSLog(@"%@, %@", [self.photos valueForKey:@"username"], [self.photos valueForKey:@"urlString"]);
}

-(void)setUserInformation {
    // add profile pic property
//    self.profilePictureImageView = self.user.profilePicture;
//    self.nameLabel.text = [NSString stringWithFormat:<#(NSString *), ...#>]
}


#pragma mark - UICollectionView data source methods
#pragma mark -

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"userProfilePhotosID" forIndexPath:indexPath];
    // note: will replace with custom cell
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}


#pragma mark - space for IBActions in case needed

- (IBAction)onEditButtonPressed:(UIButton *)sender {
}

- (IBAction)onDoneButtonPressed:(UIButton *)sender {
}

- (IBAction)onPhotosButtonPressed:(UIButton *)sender {
}

- (IBAction)onFriendsButtonPressed:(UIButton *)sender {
}

@end
