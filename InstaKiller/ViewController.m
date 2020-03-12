//
//  ViewController.m
//  InstaKiller
//
//  Created by user on 05.03.2020.
//  Copyright © 2020 temp. All rights reserved.
//

#import "ViewController.h"
#import <VKSdk.h>


@interface ViewController () <VKSdkDelegate, VKSdkUIDelegate>

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *notificationLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.username = @"William";
    self.password = @"secret";
    
    self.passwordTextField.secureTextEntry = YES;
    
 
    VKSdk *sdkInstance = [VKSdk initializeWithAppId:@"7348715"];
    [sdkInstance registerDelegate: self];
    [sdkInstance setUiDelegate: self];
    
    NSArray *SCOPE = @[@"photos"];
    
    [VKSdk wakeUpSession:SCOPE completeBlock:^(VKAuthorizationState state, NSError *error) {
        if(state == VKAuthorizationInitialized) {
            NSLog(@"Try to authorize...");
            [VKSdk authorize: SCOPE];
        } else if (state == VKAuthorizationAuthorized) {
            // Authorized and ready to go
        } else if (error) {
            // Some error happend, but you may try later
        }
    }];
    
}

- (IBAction)onPressLoginButton:(id)sender {
    if ([self.username isEqualToString: [self.usernameTextField text]])
    {
        NSLog(@"Success");
        [self.notificationLabel setText:@"Login successful"];
    } else {
        NSLog(@"Failure");
        [self.notificationLabel setText:@"Login credentials incorrect"];
    }
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result {
    if (result.token) {
        NSLog(@"Authorization successful. Token: %@", result.token);
    } else if (result.error) {
        NSLog(@"Authorization error. description: %@", result.error);
    }
}


- (void)vkSdkUserAuthorizationFailed {
    NSLog(@"Authorization failed");
}


- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    NSLog(@"In View Controller");
    [self presentViewController:controller animated:YES completion:nil];
}


- (void)vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    
}


@end
