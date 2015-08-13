//
//  UserPhotoCell.m
//  Instagram2.0
//
//  Created by Rachel Schneebaum on 8/13/15.
//  Copyright (c) 2015 Rachel Schneebaum. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailProfileImageViewController.h"
#import "UserPhotoCell.h"
#import "User.h"
#import "Photo.h"

@implementation UserPhotoCell

-(IBAction)onImageTapped:(UITapGestureRecognizer *)sender {
    [self.delegate userPhotoCell:self isSelectedWithTap:sender];
}

@end
