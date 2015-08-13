//
//  ProfileViewController.h
//  Instagram2.0
//
//  Created by Rachel Schneebaum on 8/11/15.
//  Copyright (c) 2015 Rachel Schneebaum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Photo.h"

@interface ProfileViewController : UIViewController

@property User *user;
@property NSArray *users;
@property NSManagedObjectContext *moc;
@property Photo *photo;

@end
