//
//  CameraViewController.m
//  Instagram2.0
//
//  Created by Rachel Schneebaum on 8/11/15.
//  Copyright (c) 2015 Rachel Schneebaum. All rights reserved.
//

#import "AppDelegate.h"
#import "CameraViewController.h"
#import "Photo.h"
#import "User.h"

@interface CameraViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property UIImagePickerController *picker;
@property IBOutlet UIImageView *imageView;
@property UIImage *image;
@property Photo *photo;
@property NSString *imagePath;
@property BOOL *arePhotos;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.moc = delegate.managedObjectContext;

    [self checkForAndLoadPhotos];

//  testing photo storing
    self.image = [UIImage imageNamed:@"profile_default"];
}

#pragma mark - photo storage
#pragma mark -

-(void)checkForAndLoadPhotos {
    NSFetchRequest *photosRequest = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    photosRequest.predicate = [NSPredicate predicateWithFormat:@"isUserPhoto == %@", self.user];
    NSSortDescriptor *userPhotosSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"whenTaken" ascending:false];
    photosRequest.sortDescriptors = @[userPhotosSortDescriptor];
    self.photos = [self.moc executeFetchRequest:photosRequest error:nil];
    if (self.photos.count == 0) {
        NSLog(@"no photos in array");
        self.arePhotos = false;
    }
}

-(void)storeToDirectorySelectedImage:(UIImage *)image {
    NSData *imageData = UIImagePNGRepresentation(image);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    self.imagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",@"cached"]];

    NSLog((@"pre writing to file"));
    if (![imageData writeToFile:self.imagePath atomically:NO]) {
        NSLog((@"Failed to cache image data to disk"));
    } else {
        NSLog(@"the cachedImagedPath is %@",self.imagePath);
    }
}

-(void)storePhotoFromImagePath {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:self.moc];
    Photo *photo = [[Photo alloc]initWithEntity:entity insertIntoManagedObjectContext:self.moc];
    [photo setValue:self.imagePath forKey:@"image"];
    [self.user addUserPhotosObject:photo];
    [self.moc save:nil];
}

-(void)presentNoCameraAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"No camera available on device" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:true completion:nil];
}

#pragma mark - UIImagePickerController methods
#pragma mark -

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.image = info[UIImagePickerControllerOriginalImage];
    [self.imageView setImage:self.image];
    [self storeToDirectorySelectedImage:self.image];
    [self storePhotoFromImagePath];
    [picker dismissViewControllerAnimated:true completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:true completion:nil];
}

-(IBAction)takePhoto:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [UIImagePickerController new];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:true completion:nil];
    } else {
        [self presentNoCameraAlert];
    }
}

- (IBAction)selectPhoto:(UIBarButtonItem *)sender {
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:true completion:nil];
}

- (IBAction)onDismissButtonPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


@end
