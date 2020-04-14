//
//  VKModel.h
//  InstaKiller
//
//  Created by user on 02.04.2020.
//  Copyright © 2020 temp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VKSdk.h>
#import "DownloadHelper.h"
/**
 * Class name: sharedInstance
 * Description: represents data source for application view controllers
*/
@interface VKModel <VKSdkDelegate, VKSdkUIDelegate> : NSObject

/**
 * Property name: sdkInstance
 * Description: instance of VKSDK
*/
@property (atomic, strong) VKSdk *sdkInstance;

/**
 * Method name: sharedInstance
 * Description: returns singletone of VKModel instance
 * Parameters: none
*/
+ (VKModel*)sharedInstance;

/**
 * Method name: authenticateWithVKWithDelegate
 * Description: authenticates user
 * Parameters: VK UI Delegate
*/
- (void)authenticateWithVKWithDelegate : (id<VKSdkDelegate, VKSdkUIDelegate>)vkUIDelegate;

/**
 * Method name: requestPhotos
 * Description: fetches and returns array of VKPhotos instances, which contain url of each photo
 * Parameters: none
*/
- (NSArray<VKPhoto*> *)requestPhotos;

/**
 * Method name: requestWall
 * Description: fetches and returns info about owner's wall
 * Parameters: none
*/
- (void)requestWallPosts:(id<DownloadHelperDelegateCommon>)delegate;

/**
 * Method name: requestUsersInfo
 * Description: returns users info by  their ids
 * Parameters: none
*/
- (void)requestUsersInfo:(id<DownloadHelperDelegateCommon>)delegate withOwnerId:(NSNumber *) owner_id;

@end
