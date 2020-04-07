//
//  VKModel.h
//  InstaKiller
//
//  Created by user on 02.04.2020.
//  Copyright © 2020 temp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VKSdk.h>

@interface VKModel <VKSdkDelegate, VKSdkUIDelegate> : NSObject

@property (atomic, strong) VKSdk *sdkInstance;

+(VKModel*) sharedInstance;
-(void)authenticateWithVKWithDelegate : (id<VKSdkDelegate, VKSdkUIDelegate>)vkUIDelegate;
-(NSArray<VKPhoto*> *)requestPhotos;

@end
