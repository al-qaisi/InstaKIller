//
//  ViewController.m
//  InstaKiller
//
//  Created by user on 05.03.2020.
//  Copyright © 2020 temp. All rights reserved.
//

#import "AuthViewController.h"
#import <VKSdk.h>
#import "VKModel.h"

@interface AuthViewController () <VKSdkDelegate, VKSdkUIDelegate> {
    VKModel *vkModel;
}

@end

@implementation AuthViewController


-(id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if(self) {
        NSLog(@"initiated PHV");
        vkModel = [VKModel sharedInstance];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)onPressLoginButton:(id)sender {
    [vkModel authenticateWithVKWithDelegate:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
    if (result.token) {
        NSLog(@"Authorization successful. Token: %@", result.token);
        
        UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CommonViewController"];

        [self.navigationController pushViewController:vc animated:YES];
    } else if (result.error) {
        NSLog(@"Authorization error. description: %@", result.error);
    }
}


- (void)vkSdkUserAuthorizationFailed {
    NSLog(@"Authorization failed");
}


- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    NSLog(@"In shouldPresent method");
    [self presentViewController:controller animated:YES completion:nil];
}


- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    
}


@end
