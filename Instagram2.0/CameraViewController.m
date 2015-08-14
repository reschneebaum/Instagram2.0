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
@property UIImage *image;
@property IBOutlet UIImageView *imageView;
@property Photo *photo;
@property BOOL *arePhotos;
@property NSString *imagePath;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.moc = delegate.managedObjectContext;

//    [self checkForAndLoadPhotos];

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

-(void)storePhoto:(Photo *)photo fromImagePath:(NSString *)imagePath {

}

-(void)storePhoto:(Photo *)photo withFileName:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = [paths objectAtIndex:0];
    NSString *path = [libraryDirectory stringByAppendingPathComponent:fileName];
    NSData *imageData = UIImagePNGRepresentation(self.image);
    [imageData writeToFile:path atomically:YES];
    photo.name = fileName;
    self.photo = photo;
    [self.photo setValue:fileName forKey:@"name"];
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
    [picker dismissViewControllerAnimated:true completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:true completion:nil];
}

-(IBAction)takePhoto:(UIButton *)sender {
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

-(IBAction)selectPhoto:(UIButton *)sender {
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:true completion:nil];
}






//  testing photo storing
//Photo *photo = [Photo new];
//photo.image = @"profile_default";

//  resume code
//[self storePhoto:photo withFileName:photo.image];
//[self.moc save:nil];
//[self dismissViewControllerAnimated:YES completion:NULL];

@end
