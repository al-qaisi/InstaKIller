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

/**
 * Method name: initWithCoder
 * Description: instantiates iVars
 * Params: decoder
*/
- (id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if(self) {
        vkModel = [VKModel sharedInstance];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 * Method name: onPressLoginButton
 * Description: fires when login button is clicked. initializes authorization process
 * Params: sender
*/
- (IBAction)onPressLoginButton:(id)sender {
    [vkModel authenticateWithVKWithDelegate:self];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

/**
 * Method name: vkSdkAccessAuthorizationFinishedWithResult
 * Description: fires when authorization is succesfully finished. navigates to CommonViewController
 * Params: result
*/
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
    [self presentViewController:controller animated:YES completion:nil];
}


- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    
}

@end
