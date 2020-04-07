//
//  PhotoCollectionViewCell.m
//  InstaKiller
//
//  Created by user on 16.03.2020.
//  Copyright © 2020 temp. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import "UIImageView+RemoteFile.h"

@interface PhotoCollectionViewCell() {
    __weak IBOutlet UIImageView *vkImage;
}

@end

@implementation PhotoCollectionViewCell

- (void)setImageWithURL:(VKPhoto *)vkPhoto {
    [vkImage setImageWithRemoteFileURL: vkPhoto.photo_130 placeholderImage: [UIImage imageNamed:@"me"]];
}

//TODO: add method for initializing big format image view on click
//TODO: add view to show full image format (with caching)
-(void)requestUserInfo {

}


@end
