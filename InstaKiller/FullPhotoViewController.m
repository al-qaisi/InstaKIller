//
//  FullPhotoViewController.m
//  InstaKiller
//
//  Created by user on 09.04.2020.
//  Copyright © 2020 temp. All rights reserved.
//

#import "FullPhotoViewController.h"
#import "UIImageViewExtended.h"

@interface FullPhotoViewController ()

@end

@implementation FullPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [_fullPhotoIV setImageWithRemoteFileURL: _vkPhoto.photo_1280 placeholderImage:[UIImage imageNamed:@"photos_refresh"]];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
