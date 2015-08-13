//
//  User.h
//  Instagram2.0
//
//  Created by Rachel Schneebaum on 8/12/15.
//  Copyright (c) 2015 Rachel Schneebaum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Friend, Photo;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * textDescription;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * profilePic;
@property (nonatomic, retain) NSSet *friends;
@property (nonatomic, retain) NSSet *userPhotos;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addFriendsObject:(Friend *)value;
- (void)removeFriendsObject:(Friend *)value;
- (void)addFriends:(NSSet *)values;
- (void)removeFriends:(NSSet *)values;

- (void)addUserPhotosObject:(Photo *)value;
- (void)removeUserPhotosObject:(Photo *)value;
- (void)addUserPhotos:(NSSet *)values;
- (void)removeUserPhotos:(NSSet *)values;

@end
