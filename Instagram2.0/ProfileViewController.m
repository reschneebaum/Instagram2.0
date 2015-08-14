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
    UIImage *image1 = [UIImage imageNamed:@"image1"];
    [tempImages addObject:image1];
    UIImage *image2 = [UIImage imageNamed:@"image2"];
    [tempImages addObject:image2];
    UIImage *image3 = [UIImage imageNamed:@"image3"];
    [tempImages addObject:image3];
    UIImage *image4 = [UIImage imageNamed:@"image4"];
    [tempImages addObject:image4];
    UIImage *image5 = [UIImage imageNamed:@"image5"];
    [tempImages addObject:image5];
    UIImage *image6 = [UIImage imageNamed:@"image6"];
    [tempImages addObject:image6];
    UIImage *image7 = [UIImage imageNamed:@"image7"];
    [tempImages addObject:image7];
    UIImage *image8 = [UIImage imageNamed:@"image8"];
    [tempImages addObject:image8];
    UIImage *image9 = [UIImage imageNamed:@"image9"];
    [tempImages addObject:image9];
    UIImage *image10 = [UIImage imageNamed:@"image10"];
    [tempImages addObject:image10];

    self.testPhotos = [NSArray arrayWithArray:tempImages];
    for (UIImage *image in self.testPhotos) {
        NSData *imageData = UIImagePNGRepresentation(image);
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",@"cached"]];

        NSLog((@"pre writing to file"));
        if (![imageData writeToFile:imagePath atomically:NO]) {
            NSLog((@"Failed to cache image data to disk"));
        } else {
            NSLog(@"the cachedImagedPath is %@",imagePath);
        }

        NSMutableArray *photoUrlStrings = [NSMutableArray new];
        [photoUrlStrings addObject:imagePath];
        for (NSString *urlString in photoUrlStrings) {
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:self.moc];
            Photo *photo = [[Photo alloc]initWithEntity:entity insertIntoManagedObjectContext:self.moc];
//            [photo setValue:[NSString stringWithFormat:@"%@", urlString] forKey:@"photo"];
        }
        [self.moc save:nil];

    }

    [self setUserInformation];
//    [self loadOwnPhotos];
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

-(void)storePhoto:(UIImage *)image withFileName:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = [paths objectAtIndex:0];
    NSString *path = [libraryDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", fileName]];
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:path atomically:YES];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:self.moc];
    Photo *photo = [[Photo alloc]initWithEntity:entity insertIntoManagedObjectContext:self.moc];
    self.photo = photo;
    self.photo.name = [NSString stringWithFormat:@"%@", fileName];
    [self.photo setValue:[NSString stringWithFormat:@"%@", fileName] forKey:@"name"];
    NSLog(@"%@", fileName);
}

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
}

-(void)setUserInformation {
    if (self.user.profilePic == nil) {
        self.profilePictureImageView.image = [UIImage imageNamed:@"profile_default"];
    } else {
        self.profilePictureImageView.image = [UIImage imageNamed:self.user.profilePic];
    }
    [self storeProfilePic:self.profilePictureImageView.image withFileName:self.user.profilePic];

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

-(UserPhotoCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UserPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"userProfilePhotosID" forIndexPath:indexPath];
    cell.delegate = self;
    cell.cellImage.image = self.testPhotos[indexPath.row];

    return cell;
}

-(void)userPhotoCell:(UserPhotoCell *)cell isSelectedWithTap:(UITapGestureRecognizer *)sender {
    DetailProfileImageViewController *detailProfileVC =[self.storyboard instantiateViewControllerWithIdentifier:@"detailProfileVC"];
    [self.navigationController pushViewController:detailProfileVC animated:YES];
}

-(NSInteger)collectionView:(UserPhotoCell *)collectionView numberOfItemsInSection:(NSInteger)section {
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
