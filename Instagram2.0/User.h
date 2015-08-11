//
//  User.h
//  
//
//  Created by Rachel Schneebaum on 8/11/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject, Photo;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * textDescription;
@property (nonatomic, retain) NSSet *userPhotos;
@property (nonatomic, retain) NSSet *friends;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addUserPhotosObject:(Photo *)value;
- (void)removeUserPhotosObject:(Photo *)value;
- (void)addUserPhotos:(NSSet *)values;
- (void)removeUserPhotos:(NSSet *)values;

- (void)addFriendsObject:(NSManagedObject *)value;
- (void)removeFriendsObject:(NSManagedObject *)value;
- (void)addFriends:(NSSet *)values;
- (void)removeFriends:(NSSet *)values;

@end
