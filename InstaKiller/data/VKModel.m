//
//  VKModel.m
//  InstaKiller
//
//  Created by user on 02.04.2020.
//  Copyright © 2020 temp. All rights reserved.
//

#import "VKModel.h"
#import <VKSdk.h>


@implementation VKModel

static int PHOTOS_COUNT = 200;
static VKModel* _sharedInstance = nil;


+ (VKModel*) sharedInstance {
    
    if(!_sharedInstance) {
        _sharedInstance = [[VKModel alloc] init];
    }
    
    return _sharedInstance;
}


- (void)authenticateWithVKWithDelegate: (id<VKSdkDelegate, VKSdkUIDelegate>)vkUIDelegate {
    _sdkInstance = [VKSdk initializeWithAppId:@"7355842"];
    [_sdkInstance registerDelegate: vkUIDelegate];
    [_sdkInstance setUiDelegate: vkUIDelegate];

    NSArray *SCOPE = @[@"photos, wall"];

    [VKSdk wakeUpSession:SCOPE completeBlock:^(VKAuthorizationState state, NSError *error) {
       if(state == VKAuthorizationInitialized) {
           NSLog(@"Try to authorize...");
           [VKSdk authorize: SCOPE];
       } else if (state == VKAuthorizationAuthorized) {
            NSLog(@" already authorized");
       } else if (error) {
           NSLog(@"error %@", error);
           // Some error happend, but you may try later
       }
    }];
}

//TODO: make method for getting userinfo
- (void)requestOwnerInfo {
        
}


- (NSArray<VKPhoto*> *)requestPhotos {
    NSLog(@"trying to request photos...");
    VKRequest *getPhotosRequest = [VKRequest requestWithMethod:@"photos.get" andParameters:@{@"owner_id":@37845064, @"album_id":@"saved", @"count":[NSNumber numberWithInt:PHOTOS_COUNT]}
        modelClass: [VKPhotoArray class]];

    getPhotosRequest.waitUntilDone = YES;
    
    __block VKPhotoArray * photoArray = nil;
    [getPhotosRequest executeWithResultBlock: ^(VKResponse *response) {
        photoArray = [[VKPhotoArray alloc] initWithDictionary:response.json];
        NSLog(@"items count: %lu", photoArray.items.count);
        } errorBlock:^(NSError * error) {
        if (error.code != VK_API_ERROR) {
            [error.vkError.request repeat];
        } else {
            NSLog(@"VK error: %@", error);
        }
    }];
    
    return photoArray.items;
}

@end
