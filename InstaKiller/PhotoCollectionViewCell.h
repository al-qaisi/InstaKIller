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

/**
 * Method name: setImageWithURL
 * Description: sets cell's ImageView image with url from vkPhoto
 * Parameters: vkPhoto
 */
- (void)setImageWithURL: (VKPhoto*)vkPhoto;

@end
