//
//  FullPhotoViewController.h
//  InstaKiller
//
//  Created by user on 09.04.2020.
//  Copyright © 2020 temp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VKSdk.h>
#import "PhotoCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface FullPhotoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *fullPhotoIV;

@property (weak) VKPhoto *vkPhoto;

@end

NS_ASSUME_NONNULL_END
