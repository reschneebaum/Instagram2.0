//
//  Friend.h
//  Instagram2.0
//
//  Created by Rachel Schneebaum on 8/14/15.
//  Copyright (c) 2015 Rachel Schneebaum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo, User;

@interface Friend : NSManagedObject

@property (nonatomic, retain) NSSet *friendPhotos;
@property (nonatomic, retain) User *isFriendOf;
@property (nonatomic, retain) Photo *likes;
@end

@interface Friend (CoreDataGeneratedAccessors)

- (void)addFriendPhotosObject:(Photo *)value;
- (void)removeFriendPhotosObject:(Photo *)value;
- (void)addFriendPhotos:(NSSet *)values;
- (void)removeFriendPhotos:(NSSet *)values;

@end
