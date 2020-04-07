//
//  PhotoCollectionViewCell.h
//  InstaKiller
//
//  Created by user on 16.03.2020.
//  Copyright © 2020 temp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VKSdk.h"


@interface PhotoCollectionViewCell : UICollectionViewCell

-(void)setImageWithURL: (VKPhoto*)vkPhoto;

@end
 
