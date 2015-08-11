//
//  Friend.h
//  
//
//  Created by Rachel Schneebaum on 8/11/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo, User;

@interface Friend : NSManagedObject

@property (nonatomic, retain) NSSet *friendPhotos;
@property (nonatomic, retain) User *friends;
@end

@interface Friend (CoreDataGeneratedAccessors)

- (void)addFriendPhotosObject:(Photo *)value;
- (void)removeFriendPhotosObject:(Photo *)value;
- (void)addFriendPhotos:(NSSet *)values;
- (void)removeFriendPhotos:(NSSet *)values;

@end
