//
//  ViewController.m
//  反弹运动
//
//  Created by Macx on 2017/8/13.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "ViewController.h"
#import "UIView+WP.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *ballImageView;

@end

CGFloat speedX = 5;

CGFloat speedY = 5;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(startRun:)];

    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (IBAction)startRun:(id)sender {

    // 临界条件判断
    
    if (_ballImageView.x < 0 || _ballImageView.x > [UIScreen mainScreen].bounds.size.width - _ballImageView.width)
    {
        speedX = -speedX;
    }
    if (_ballImageView.y < 0 || _ballImageView.y > [UIScreen mainScreen].bounds.size.height - _ballImageView.height)
    {
        speedY = -speedY;
    }
//    NSLog(@"---%f",speedX);
//    
//    NSLog(@"---%f",speedY);
//    
    
    [UIView animateWithDuration:0.25 animations:^{
        
        _ballImageView.x -= speedX ;
        
        _ballImageView.y +=  speedY;
    }];
    

}



@end
