//
//  FCBirdGameViewController.m
//  FastCounter
//
//  Created by LiuYong on 2018/4/16.
//  Copyright © 2018年 LiuYong. All rights reserved.
//

#define fullHeight  (AppHeight-120)

#import "FCBirdGameViewController.h"
#import "FCBirdOverViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface FCBirdGameViewController ()<FCBirdOverDelegate,AVAudioPlayerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *backgroundView;//背景图
@property(nonatomic,strong)UIImageView *birdView;//小鸟视图
@property(nonatomic,strong)UIImageView*upPipeView;//上面管子
@property(nonatomic,strong)UIImageView*downPipeView;//下面的管子
@property (strong, nonatomic) IBOutlet UIView *readyView;//预备视图
@property(nonatomic,strong)UILabel*scoreLabel;//分数Label
@property(nonatomic,assign)NSInteger score;//分数

@property(nonatomic,assign)NSTimer *timer;//定时器
@property(nonatomic,strong) UIImageView *bottomView;//底部View
@property(nonatomic,assign)BOOL autoDown;/*自动下降*/
@property(nonatomic,assign)NSInteger number;//下降频率

@property(nonatomic,strong)AVAudioPlayer*player;/*背景乐*/
@property(nonatomic,strong)AVAudioPlayer*touchPlayer;/*点击时播放*/
@property(nonatomic,strong)AVAudioPlayer*pipePlayer;/*过管子时播放*/

@property(nonatomic,strong)FCBirdOverViewController*bvc;


@end

@implementation FCBirdGameViewController

-(UILabel *)scoreLabel{
    if (!_scoreLabel) {
        _scoreLabel=[[UILabel alloc]initWithFrame:CGRectMake((AppWidth-200)/2, 80, 200, 40)];
        _scoreLabel.font=kBfont(50);
        _scoreLabel.textColor=kWhiteColor;
        _scoreLabel.textAlignment=1;
    }
    return _scoreLabel;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden=NO;
    [self.timer invalidate];
    self.timer=nil;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    
}
/*点击游戏开始*/
- (IBAction)tapToStartGame:(UITapGestureRecognizer *)sender {
    self.readyView.hidden=YES;
    self.timer=[NSTimer scheduledTimerWithTimeInterval:0.009 target:self selector:@selector(move) userInfo:nil repeats:YES];
    [self.birdView startAnimating];
}

-(void)loadUI{
    /*给小鸟添加动画*/
    NSArray*images=@[@"Yellow_Bird_Wing_Down",@"Yellow_Bird_Wing_Straight",@"Yellow_Bird_Wing_Up"];
    NSMutableArray*data=[NSMutableArray new];
    for (int i=0; i<images.count; i++) {
        UIImage*image=[UIImage imageNamed:images[i]];
        [data addObject:image];
    }
    self.birdView=[[UIImageView alloc]initWithFrame:CGRectMake(100, 300, 40, 40)];
    self.birdView.image=[UIImage imageNamed:@"Yellow_Bird_Wing_Straight"];
    [self.view addSubview:self.birdView];
    self.birdView.animationImages=data;
    self.birdView.animationDuration=0.5;
    self.birdView.animationRepeatCount=0;
    self.autoDown=NO;
    self.number=0;
    /*设置地面 宽多给15 是为了有移动衔接效果*/
    self.bottomView=[[UIImageView alloc]initWithFrame:CGRectMake(0, AppHeight-120,AppWidth+15, 120)];
    self.bottomView.image=[UIImage imageNamed:@"Bottom_Scroller"];
    [self.view addSubview:self.bottomView];
    /*随机生成管子*/
    [self randomPipeView];
    /*添加定时器 使管子移动*/
    NSString*path=[[NSBundle mainBundle]pathForResource:@"gophermusic" ofType:@"mp3"];
    self.player=[[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:path] error:nil];
    self.player.delegate=self;
    [self.player play];
 
    self.score=0;
    self.scoreLabel.text=[NSString stringWithFormat:@"%ld",(long)self.score];
    [self.view addSubview:self.scoreLabel];
    
}


/*随机生成管子*/
-(void)randomPipeView{

    /*管子1+间隙+管子2*/
    
    /*随机生成管子空隙  */
    NSInteger xspace= (arc4random() % 11)+(160-(self.score/3)*10);
    /*随机生成上下管子的长度比例*/
    /*两根管子的总长度*/
    CGFloat pipeViewHeight =fullHeight-xspace;
    
//    int value = (arc4random() % 2) + 1;
//    int value = (arc4random() % 2) + 2; 2-3
//    int value = (arc4random() % 2) + 3;//3-4
//        int value = (arc4random() % 2) + 4;//4-5
    //    double value=(double)arc4random()/0x100000000;


//    NSLog(@"随机的数是:%d",value);
    float pro=(float)(4 + (arc4random() %2))/10;
    /*上面管子*/
    self.upPipeView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Downward_Green_Pipe"]];
    self.upPipeView.frame=CGRectMake(AppWidth, 0, 70, pipeViewHeight*pro);
    [self.view addSubview:self.upPipeView];
    /*下面管子*/
    self.downPipeView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Upward_Green_Pipe"]];
    self.downPipeView.frame=CGRectMake(AppWidth,fullHeight-pipeViewHeight*(1-pro), 70, pipeViewHeight*(1-pro));
    [self.view addSubview:self.downPipeView];
    /*将scoreLabel显示在视图的最上层*/
    [self.view bringSubviewToFront:self.scoreLabel];
    
}


/*点击背景让小鸟飞*/
- (IBAction)tapToFly:(UITapGestureRecognizer *)sender {
    self.autoDown=NO;/*是否自动下降*/
    if (self.touchPlayer) {
        [self.touchPlayer stop];
        self.touchPlayer=nil;
    }
    NSString*path=[[NSBundle mainBundle]pathForResource:@"punch" ofType:@"wav"];
    self.touchPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:path] error:nil];
    [self.touchPlayer play];
}

-(void)move{
    
    /*地面的移动  平移15px后又还原 才会有动画效果*/
    CGRect frame=self.bottomView.frame;
    if (frame.origin.x==-15) {
        frame.origin.x=0;
    }
    frame.origin.x--;
    self.bottomView.frame=frame;
    
    /*管子的移动*/
    CGRect upframe=self.upPipeView.frame;
    upframe.origin.x-=(self.score/10)*1+1;
//    upframe.origin.x--;
    self.upPipeView.frame=upframe;
    
    CGRect downframe=self.downPipeView.frame;
    downframe.origin.x-=(self.score/10)*1+1;
//    downframe.origin.x--;
    self.downPipeView.frame=downframe;
    
    /*如果消失了 再随机生成柱子*/
    if (self.upPipeView.origin.x<-70) {
        [self randomPipeView];
    }
    if (self.birdView.frame.origin.y==0) {
        [self gameOver];
    }
    //点击上升
    if (self.autoDown==NO) {
        CGRect frame=self.birdView.frame;
        frame.origin.y-=2;
        self.number+=3;
        self.birdView.frame=frame;
        if (self.number>=100) {
            self.autoDown=YES;
        }
    }
    //不点击，自动下降
    if(self.autoDown&&self.birdView.frame.origin.y<AppHeight-120-40){
        CGRect frame=self.birdView.frame;
        frame.origin.y++;
        self.number-=2;
        self.birdView.frame=frame;
        self.number=0;
    }
    if (self.birdView.frame.origin.y>=AppHeight-120-40) {
        //游戏结束 与底部接触
        [self gameOver];
    }
    
    //碰撞（交集）判断两个视图之间是否有交集
    BOOL ret1=CGRectIntersectsRect(self.birdView.frame, self.upPipeView.frame);
    BOOL ret2=CGRectIntersectsRect(self.birdView.frame, self.downPipeView.frame);
    if (ret1==true||ret2==true) {
        //碰撞
        [self gameOver];
    }
    if (self.upPipeView.frame.origin.x==30) {
        self.score++;
        self.scoreLabel.text=[NSString stringWithFormat:@"%ld",(long)self.score];
        if (self.pipePlayer) {
            [self.pipePlayer stop];
            self.pipePlayer=nil;
        }
        NSString*path=[[NSBundle mainBundle]pathForResource:@"pipe" ofType:@"mp3"];
        self.pipePlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:path] error:nil];
        [self.pipePlayer play];
    }
}


//游戏结束
-(void)gameOver{
    
    NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"bestscore"]) {
        [defaults setObject:[NSString stringWithFormat:@"%ld",self.score] forKey:@"score"];
        [defaults setObject:[NSString stringWithFormat:@"%ld",self.score] forKey:@"bestscore"];

    }else{
        if (self.score>[[defaults objectForKey:@"bestscore"] integerValue]) {
            [defaults setObject:[NSString stringWithFormat:@"%ld",self.score] forKey:@"score"];
            [defaults setObject:[NSString stringWithFormat:@"%ld",self.score] forKey:@"bestscore"];

        }else{
            [defaults setObject:[NSString stringWithFormat:@"%ld",self.score] forKey:@"score"];
        }
    }
    [defaults synchronize];
    
    if (self.player) {
        [self.timer invalidate];
        self.timer=nil;
        [self.birdView stopAnimating];
        [self.player stop];
    }
    /*播放碰撞音乐*/
    NSString *url=[[NSBundle mainBundle]pathForResource:@"Sound16" ofType:@"wav"];
    self.player=[[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:url] error:nil];
    [self.player play];
  /**跳转到失败页面*/
    FCBirdOverViewController*ovc=[[FCBirdOverViewController alloc]init];
    ovc.delegate=self;
    [self presentViewController:ovc animated:YES completion:nil];
}

#pragma mark AVAudioDelegate
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    if (player==self.player) {
//        if (flag) {
//            NSString *url=[[NSBundle mainBundle]pathForResource:@"Sound16" ofType:@"wav"];
//            self.player=[[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:url] error:nil];
//            [self.player play];
//        }
    }
}


#pragma mark FCBirdViewDelegte

-(void)didClickReturn{
    
    [self.downPipeView removeFromSuperview];
    [self.upPipeView removeFromSuperview];
    
    self.downPipeView=nil;
    self.upPipeView=nil;
    [self.birdView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)didClickReplay{
    /*再来一次*/
    [self.birdView removeFromSuperview];
    [self.downPipeView removeFromSuperview];
    [self.upPipeView removeFromSuperview];
    [self.bottomView removeFromSuperview];
    self.score=0;
    self.readyView.hidden=NO;
    [self loadUI];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
