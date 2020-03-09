//
//  ViewController.m
//  InstaKiller
//
//  Created by user on 05.03.2020.
//  Copyright © 2020 temp. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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

@end
