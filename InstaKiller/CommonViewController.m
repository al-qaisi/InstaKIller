//
//  CommonViewController.m
//  InstaKiller
//
//  Created by user on 16.03.2020.
//  Copyright © 2020 temp. All rights reserved.
//

#import "CommonViewController.h"
#import "VKSdk.h"

@implementation CommonViewController
- (IBAction)onShowPhotosTouch:(id)sender {
    UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PhotoCollectionViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onButtonTouch:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
