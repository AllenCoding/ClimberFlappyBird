//
//  FCBirdViewController.m
//  FastCounter
//
//  Created by LiuYong on 2018/4/16.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#import "FCBirdViewController.h"
#import "FCBirdGameViewController.h"

@interface FCBirdViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *background;
@property (strong, nonatomic) IBOutlet UIImageView *birdView;

@end

@implementation FCBirdViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=YES;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    
}

/*开始游戏*/
- (IBAction)startGame:(UIButton *)sender {
    FCBirdGameViewController*gvc=[[FCBirdGameViewController alloc]init];
    [self.navigationController pushViewController:gvc animated:YES];
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
