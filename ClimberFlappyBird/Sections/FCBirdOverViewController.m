//
//  FCBirdOverViewController.m
//  FastCounter
//
//  Created by LiuYong on 2018/4/17.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "FCBirdOverViewController.h"

@interface FCBirdOverViewController ()

@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *bestLabel;

@end

@implementation FCBirdOverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
    self.scoreLabel.text=[defaults objectForKey:@"score"];
    self.bestLabel.text=[defaults objectForKey:@"bestscore"];

}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    return self;
}

- (IBAction)action:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    if (sender.tag==99) {
        if (self.delegate&&[self.delegate respondsToSelector:@selector(didClickReplay)]) {
            [self.delegate didClickReplay];
        }
    }else{
        if (self.delegate&&[self.delegate respondsToSelector:@selector(didClickReturn)]) {
            [self.delegate didClickReturn];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
