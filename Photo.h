//
//  Photo.h
//  
//
//  Created by Rachel Schneebaum on 8/11/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Friend, User;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSString * urlString;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * likesNumber;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * whenTaken;
@property (nonatomic, retain) User *userPhotos;
@property (nonatomic, retain) Friend *friendPhotos;

@end
