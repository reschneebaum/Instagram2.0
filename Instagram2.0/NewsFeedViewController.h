//
//  NewsFeedViewController.h
//  Instagram2.0
//
//  Created by Rachel Schneebaum on 8/11/15.
//  Copyright (c) 2015 Rachel Schneebaum. All rights reserved.
//

#import "User.h"
#import "Photo.h"
#import <UIKit/UIKit.h>

@interface NewsFeedViewController : UIViewController

@property NSManagedObjectContext *moc;
@property NSArray *photos;
@property Photo *photo;
@property User *user;

@end
