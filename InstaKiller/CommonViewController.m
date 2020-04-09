//
//  CommonViewController.m
//  InstaKiller
//
//  Created by user on 09.04.2020.
//  Copyright © 2020 temp. All rights reserved.
//

#import "CommonViewController.h"

@interface CommonViewController ()

@end

@implementation CommonViewController

- (void)viewDidLoad {
  
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {
    NSLog(@"Common View did appear");
}

- (IBAction)onShowPhotosTouch:(id)sender {
    [super viewDidLoad];
         UIViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PhotoCollectionViewController"];

         [self.navigationController pushViewController:vc animated:YES];
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
