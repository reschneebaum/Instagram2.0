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

@interface CameraViewController ()
@property UIImagePickerController *picker;
@property UIImagePickerController *picker2;
@property UIImage *image;
@property IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *barbuttonbackground;
@property (weak, nonatomic) IBOutlet UIButton *takePictureButton;
@property (weak, nonatomic) IBOutlet UIButton *libraryButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UIButton *xbutton;
@property (weak, nonatomic) IBOutlet UIButton *gridButton;
@property (weak, nonatomic) IBOutlet UIButton *rotateCameraButton;
@property (weak, nonatomic) IBOutlet UIButton *flashLightButton;
@property UIColor *UIColor;
@property NSManagedObjectContext *moc;
@property Photo *photo;
@property BOOL *arePhotos;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//    self.moc = delegate.managedObjectContext;
//
//    [self checkForAndLoadPhotos];

//  testing photo storing
//    self.image = [UIImage imageNamed:@"flash"];
//}
//
//-(void)checkForAndLoadPhotos {
//    NSFetchRequest *photosRequest = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
//    photosRequest.predicate = [NSPredicate predicateWithFormat:@"userPhotos CONTAINS %@", self.user];
//    NSSortDescriptor *userPhotosSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"username" ascending:true];
//    photosRequest.sortDescriptors = @[userPhotosSortDescriptor];
//    self.photos = [self.moc executeFetchRequest:photosRequest error:nil];
//    if (self.photos.count == 0) {
//        NSLog(@"no photos in array");
//        self.arePhotos = false;
//    }
//}
//
//-(void)storePhoto:(Photo *)photo withFileName:(NSString *)fileName {
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
//    NSString *libraryDirectory = [paths objectAtIndex:0];
//    NSString *path = [libraryDirectory stringByAppendingPathComponent:fileName];
//    NSData *imageData = UIImagePNGRepresentation(self.image);
//    [imageData writeToFile:path atomically:YES];
//    photo.name = fileName;
//    self.photo = photo;
//    [self.photo setValue:fileName forKey:@"name"];
}

- (IBAction)TakePhoto {
    self.picker =[[UIImagePickerController alloc] init];
    self.picker.delegate = self;
    [self.picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:self.
     picker animated:YES completion:NULL];
}

- (IBAction)ChooseExisting {
    _picker2 =[[UIImagePickerController alloc] init];
    self.picker2.delegate = self;
    [self.picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:self.picker2 animated:YES completion:NULL];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imageView setImage:self.image];

//    note to self: instantiate instance of photo class and assign value to property, then pass into the following:
//    [self storePhoto:photo withFileName:photo.urlString];

//  testing photo storing
    Photo *photo = [Photo new];
    photo.urlString = [NSString stringWithFormat:@"flash"];

//  resume code
//    [self storePhoto:photo withFileName:photo.urlString];

    [self.moc save:nil];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (IBAction)onDoneButtonPressed:(UIButton *)sender {

}

@end
