//
//  Photo.h
//  Instagram2.0
//
//  Created by Rachel Schneebaum on 8/14/15.
//  Copyright (c) 2015 Rachel Schneebaum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, Friend, User;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * likesNumber;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * urlString;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * whenTaken;
@property (nonatomic, retain) Comment *comments;
@property (nonatomic, retain) Friend *friendLikes;
@property (nonatomic, retain) Friend *isFriendPhoto;
@property (nonatomic, retain) User *isLiked;
@property (nonatomic, retain) User *isUserPhoto;

@end
