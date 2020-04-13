//
//  PhotoCollectionViewCell.m
//  InstaKiller
//
//  Created by user on 16.03.2020.
//  Copyright © 2020 temp. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import "UIImageViewExtended.h"

@interface PhotoCollectionViewCell() {
    /**
    * IVar name: vkImage
    * Description: cell's UIIm  ageView content
    * Parameters: vkImage
    */
    __weak IBOutlet UIImageView *vkImage;
}

@end

@implementation PhotoCollectionViewCell

/**
 * Method name: setImageWithURL
 * Description: fires when photoCollectionViewController renders new cell. calls UIImageView extention method to set image with url
 * Params: vkPhoto
*/
- (void)setImageWithURL:(VKPhoto *)vkPhoto {
    [vkImage setImageWithRemoteFileURL: vkPhoto.photo_130 placeholderImage: [UIImage imageNamed:@"photos_refresh"]];
}


- (void)requestUserInfo {

}

@end
