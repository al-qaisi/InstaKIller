//
//  PhotoCollectionViewController.m
//  InstaKiller
//
//  Created by user on 16.03.2020.
//  Copyright © 2020 temp. All rights reserved.
//

#import <VKSdk.h>
#import "VKModel.h"
#import "PhotoCollectionViewController.h"
#import "PhotoCollectionViewCell.h"
#import "FullPhotoViewController.h"

@interface PhotoCollectionViewController () {
    VKModel* vkModel;
    NSArray<VKPhoto*>* photos;
}

@end

@implementation PhotoCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

/**
* Method name: initWithCoder
* Description: initializes ivars
* Parameters: decoder
*/
- (id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if(self) {
        vkModel = [VKModel sharedInstance];
        photos = [vkModel requestPhotos];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return photos.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell setImageWithURL: photos[indexPath.row]];
    
    return cell;
}


#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    VKPhoto *vkPhoto = photos[indexPath.row];
    FullPhotoViewController *fullPhotoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FullPhotoViewController"];
    fullPhotoVC.vkPhoto = vkPhoto;
    [self.navigationController pushViewController:fullPhotoVC animated:YES];
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
