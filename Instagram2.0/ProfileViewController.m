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
    self.photos = [NSArray new];
}

-(void)loadOwnPhotos {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Photo"];
    NSSortDescriptor *userSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:true];
    request.sortDescriptors = @[userSortDescriptor];
    self.users = [self.moc executeFetchRequest:request error:nil];
    NSLog(@"%@, %@", [self.users valueForKey:@"username"], [self.users valueForKey:@"password"]);
}


#pragma mark - UICollectionView data source methods
#pragma mark -

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCellID" forIndexPath:indexPath];
    // note: will replace with custom cell
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
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
