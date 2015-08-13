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
#import "CameraViewController.h"
#import "DetailProfileImageViewController.h"
#import "UserPhotoCell.h"
#import "User.h"
#import "Photo.h"

@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UserPhotoCellDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *profileCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIButton *changeProfilePicButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *photosButton;
@property (weak, nonatomic) IBOutlet UIButton *friendsButton;
@property NSArray *photos;
@property NSArray *testPhotos;
@property BOOL isEditingProfile;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.moc = delegate.managedObjectContext;

    NSLog(@"%@", self.users.firstObject);
    NSLog(@"%@", self.user.username);
    NSLog(@"%@", self.user.password);
    NSLog(@"%@", self.user.firstName);
    NSLog(@"%@", self.user.lastName);

    NSMutableArray *tempImages = [NSMutableArray new];
    UIImage *photo1 = [UIImage imageNamed:@"4.1.03"];
    [tempImages addObject:photo1];
    UIImage *photo2 = [UIImage imageNamed:@"4.1.05"];
    [tempImages addObject:photo2];
    UIImage *photo3 = [UIImage imageNamed:@"4.1.07"];
    [tempImages addObject:photo3];
    UIImage *photo4 = [UIImage imageNamed:@"4.2.01"];
    [tempImages addObject:photo4];
    UIImage *photo5 = [UIImage imageNamed:@"4.2.03"];
    [tempImages addObject:photo5];

    self.testPhotos = [NSArray arrayWithArray:tempImages];

    [self setUserInformation];
    [self loadOwnPhotos];
}

-(void)loadOwnPhotos {
    NSFetchRequest *userPhotoRequest = [[NSFetchRequest alloc] initWithEntityName:@"Photo"];
    userPhotoRequest.predicate = [NSPredicate predicateWithFormat:@"isUserPhoto == %@", self.user];
    NSSortDescriptor *userPhotoSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"whenTaken" ascending:false];
    userPhotoRequest.sortDescriptors = @[userPhotoSortDescriptor];
    self.photos = [self.moc executeFetchRequest:userPhotoRequest error:nil];
    if (self.photos.count > 0) {
        NSLog(@"%@, %@", [self.photos valueForKey:@"username"], [self.photos valueForKey:@"image"]);
    }
}

//-(void)storePhoto:(UIImage *)image withFileName:(NSString *)fileName {
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
//    NSString *libraryDirectory = [paths objectAtIndex:0];
//    NSString *path = [libraryDirectory stringByAppendingPathComponent:fileName];
//    NSData *imageData = UIImagePNGRepresentation(image);
//    [imageData writeToFile:path atomically:YES];
//    Photo *photo = [Photo new];
//    photo.name = fileName;
//    self.photo = photo;
//    [self.photo setValue:fileName forKey:@"name"];
//}

-(void)storeProfilePic:(UIImage *)image withFileName:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = [paths objectAtIndex:0];
    NSString *path = [libraryDirectory stringByAppendingPathComponent:fileName];
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:path atomically:YES];
    image = [UIImage imageNamed:fileName];
    self.user.profilePic = fileName;
    [self.user setValue:fileName forKey:@"profilePic"];
    [self.moc save:nil];
    NSLog(@"%@", self.user.profilePic);
}

-(void)setUserInformation {
    if (self.user.profilePic == nil) {
        self.profilePictureImageView.image = [UIImage imageNamed:@"profile_default"];
    } else {
        self.profilePictureImageView.image = [UIImage imageNamed:self.user.profilePic];
    }
    [self storeProfilePic:self.profilePictureImageView.image withFileName:self.user.profilePic];
    NSLog(@"%@", self.user.profilePic);

    if (self.user.textDescription.length > 0) {
        self.descriptionTextView.text = self.user.textDescription;
    } else {
        self.descriptionTextView.text = @"Enter description";
    }

    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", self.user.firstName, self.user.lastName];
    self.isEditingProfile = false;
    self.editButton.hidden = false;
    self.editButton.enabled = true;
    self.doneButton.hidden = true;
    self.doneButton.enabled = false;
    self.descriptionTextView.userInteractionEnabled = false;
    self.descriptionTextView.editable = false;
    self.changeProfilePicButton.enabled = false;
    self.changeProfilePicButton.hidden = true;
}

-(void)switchEditDoneButtons {
    if (self.isEditingProfile) {
        self.editButton.hidden = true;
        self.editButton.enabled = false;
        self.doneButton.hidden = false;
        self.doneButton.enabled = true;
        self.profilePictureImageView.userInteractionEnabled = true;
        self.descriptionTextView.userInteractionEnabled = true;
        self.descriptionTextView.editable = true;
        self.changeProfilePicButton.enabled = true;
        self.changeProfilePicButton.hidden = false;
    } else {
        self.editButton.hidden = false;
        self.editButton.enabled = true;
        self.doneButton.hidden = true;
        self.doneButton.enabled = false;
        self.profilePictureImageView.userInteractionEnabled = false;
        self.descriptionTextView.userInteractionEnabled = false;
        self.descriptionTextView.editable = false;
        self.changeProfilePicButton.enabled = false;
        self.changeProfilePicButton.hidden = true;
    }
}

#pragma mark - UICollectionView data source methods
#pragma mark -

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UserPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"userProfilePhotosID" forIndexPath:indexPath];
    cell.delegate = self;
    cell.cellImage = self.testPhotos[indexPath.row];

    return cell;
}

-(void)userPhotoCell:(UserPhotoCell *)cell isSelectedWithTap:(UITapGestureRecognizer *)sender {
    DetailProfileImageViewController *detailProfileVC =[self.storyboard instantiateViewControllerWithIdentifier:@"detailProfileVC"];
    [self.navigationController pushViewController:detailProfileVC animated:YES];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.testPhotos.count;
}


#pragma mark - space for IBActions in case needed

-(IBAction)onEditButtonPressed:(UIButton *)sender {
    self.isEditingProfile = true;
    [self switchEditDoneButtons];
}

-(IBAction)onDoneButtonPressed:(UIButton *)sender {
    self.isEditingProfile = false;
    [self switchEditDoneButtons];
    [self.descriptionTextView resignFirstResponder];
    if (self.descriptionTextView.text.length > 0) {
        self.user.textDescription = self.descriptionTextView.text;
        [self.user setValue:self.descriptionTextView.text forKey:@"textDescription"];
        [self.moc save:nil];
    }
}

- (IBAction)onPhotosButtonPressed:(UIButton *)sender {
    CameraViewController *cameraVC = [self.storyboard instantiateViewControllerWithIdentifier:@"cameraVC"];
    [self.navigationController pushViewController:cameraVC animated:YES];
    cameraVC.moc = self.moc;
    cameraVC.user = self.user;
    cameraVC.photos = self.photos;
}

- (IBAction)onFriendsButtonPressed:(UIButton *)sender {
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

@end
