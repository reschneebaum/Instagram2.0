//
//  UserPhotoCell.h
//  Instagram2.0
//
//  Created by Rachel Schneebaum on 8/13/15.
//  Copyright (c) 2015 Rachel Schneebaum. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserPhotoCellDelegate <NSObject>

-(void)userPhotoCell:(id)cell isSelectedWithTap:(UITapGestureRecognizer *)sender;

@end

@interface UserPhotoCell : UICollectionViewCell

@property (nonatomic, assign) id <UserPhotoCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;

@end
