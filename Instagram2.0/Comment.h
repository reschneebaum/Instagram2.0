//
//  Comment.h
//  Instagram2.0
//
//  Created by Rachel Schneebaum on 8/14/15.
//  Copyright (c) 2015 Rachel Schneebaum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo;

@interface Comment : NSManagedObject

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) Photo *onPhoto;

@end
