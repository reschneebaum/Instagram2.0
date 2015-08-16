//
//  CommentTableViewController.h
//  Instagram2.0
//
//  Created by Rachel Schneebaum on 8/14/15.
//  Copyright (c) 2015 Rachel Schneebaum. All rights reserved.
//

#import "Photo.h"
#import <UIKit/UIKit.h>

@interface CommentTableViewController : UITableViewController

@property NSManagedObjectContext *moc;
@property NSArray *photos;
@property Photo *photo;

@end
