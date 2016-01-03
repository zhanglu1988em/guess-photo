//
//  ViewController.m
//  04-疯狂猜图
//
//  Created by zhanglu1988em on 16/1/3.
//  Copyright © 2016年 wbder. All rights reserved.
//

#import "ViewController.h"
#import "QuestionsMode.h"

@interface ViewController ()
@property (nonatomic,strong) UIButton*  coverBtn;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn;
@property (nonatomic,assign)    int index;
@property (nonatomic,strong) NSArray*  quesArry;
@property (weak, nonatomic) IBOutlet UILabel *itemIndexLbl;
@property (weak, nonatomic) IBOutlet UILabel *itenTitle;
@property (weak, nonatomic) IBOutlet UIView *answerView;
@property (weak, nonatomic) IBOutlet UIView *optionsView;
@end



@implementation ViewController

-(NSArray*) quesArry
{
    if (_quesArry == nil) {
        _quesArry = [QuestionsMode Questions];
    }
    return _quesArry;
}

-(UIButton* )coverBtn{
    if (_coverBtn == nil) {
        _coverBtn = [[UIButton alloc] initWithFrame:self.view.bounds];
        [_coverBtn setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.5]] ;
        [_coverBtn setAlpha:0.0f];
        [_coverBtn addTarget:self action:@selector(zoomImage) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_coverBtn];
    }
    return _coverBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.index = -1;
    [self nextItem];
}


-(IBAction)zoomImage
{

    if (self.coverBtn.alpha == 0.0) {
       
        int w = self.view.bounds.size.width;
        int h = w;
        int y = (self.view.bounds.size.height - h) * 0.5;
        [UIView animateWithDuration:1.0f animations:^{
            self.coverBtn.alpha = 1.0;
            self.imageBtn.frame= CGRectMake(0,y, w, h);
             [self.view bringSubviewToFront:self.imageBtn];
        }];
    }
    else
    {
        [UIView animateWithDuration:1.0f animations:^{
            self.imageBtn.frame= CGRectMake(85,98, 150, 150);
        } completion:^(BOOL finished) {
            self.coverBtn.alpha = 0.0;
        }];
    }
}

- (IBAction)nextItem {
    
    ++ _index;
    QuestionsMode *mode = self.quesArry[self.index];
    [self.imageBtn setImage:[UIImage imageNamed: [mode valueForKey:@"icon"]] forState:UIControlStateNormal];
    [self.itemIndexLbl setText:[NSString stringWithFormat:@"%d / %d",_index + 1,self.quesArry.count]];
    [self.itenTitle setText:[mode valueForKey:@"title"]];
    int answerLength = [[mode valueForKey:@"answer"] length];
   // NSLog(@"%d",answerLength);
    
#define kColSpacing 5

#define ansW 35
#define ansH 35
    
    for (UIView *vw in self.answerView.subviews) {
        [vw removeFromSuperview];
    }
    int x = (self.view.bounds.size.width - (answerLength * ansW + (answerLength - 1) * kColSpacing)) * 0.5;
    for (int i = 0; i < answerLength; ++ i) {
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        btn.frame=  CGRectMake(x + (ansW + kColSpacing ) * i, 0, ansW, ansH);
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
        [self.answerView addSubview:btn];
    }
    
    
    for (UIView *vw in self.optionsView.subviews) {
        [vw removeFromSuperview];
    }
#define  kOptionsColCount   7
#define kColSpacingY 5
    int optionsLength = [[mode valueForKey:@"options"] count];
    
    int nEdge = (self.view.bounds.size.width - (ansW * kOptionsColCount  + kColSpacing * ( kOptionsColCount -1))) * 0.5;
    NSLog(@"%d",optionsLength);
    for (int i = 0; i < optionsLength; ++ i) {
        int nAtX = i % kOptionsColCount;
        int nAtY = i / kOptionsColCount;
        int x = nEdge + (ansW + kColSpacing) * nAtX;
        int y = kColSpacingY + (ansW + kColSpacingY) * nAtY;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, ansW, ansW)];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:UIControlStateHighlighted];
        [btn setTitle:[mode  valueForKey:@"options"][i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.optionsView addSubview:btn];

    }
    
    
    
}


/* 调整状态栏*/
-(UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
