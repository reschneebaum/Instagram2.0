//
//  CameraViewController.h
//  Instagram2.0
//
//  Created by Rachel Schneebaum on 8/11/15.
//  Copyright (c) 2015 Rachel Schneebaum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface CameraViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property User *user;
@property NSArray *photos;
@property NSManagedObjectContext *moc;

- (IBAction)TakePhoto;
- (IBAction)ChooseExisting;


@end
