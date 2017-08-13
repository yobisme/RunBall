//
//  ViewController.m
//  重力下的小球运动
//
//  Created by Macx on 2017/8/13.
//  Copyright © 2017年 Macx. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *ballImageView;

@property (strong, nonatomic) CMMotionManager *mgr;

@property (assign, nonatomic) CGFloat deltaX;

@property (assign, nonatomic) CGFloat deltaY;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mgr = [CMMotionManager new];
    
    if(!self.mgr.isAccelerometerAvailable) {
        return;
    }
    
    self.mgr.accelerometerUpdateInterval = 1.0 / 60.0;
    
    [self.mgr startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        [self updateBallFrameWithAccelerometerData:accelerometerData];
    }];
    
}
- (void)updateBallFrameWithAccelerometerData:(CMAccelerometerData *)accelerometerData {
    
    //  设置衰减值
    float padValue = 0.8;
    
    // 1. 完成小球随着加速计方向上移动
    CGRect originFrame = self.ballImageView.frame;
    
    CGRect newFrame = originFrame;
    
    // 2. 累计添加的数量，越加越多
    self.deltaX = self.deltaX + accelerometerData.acceleration.x;
    
    self.deltaY = self.deltaY + accelerometerData.acceleration.y;
    
    newFrame.origin.y = newFrame.origin.y - self.deltaY;
    
    newFrame.origin.x = newFrame.origin.x + self.deltaX;
    
    // 3. 边界检查
    if(newFrame.origin.x < 0) {
        newFrame.origin.x = 0;
        self.deltaX = - self.deltaX * padValue;
    }
    
    if(newFrame.origin.x > self.view.frame.size.width - originFrame.size.width) {
        newFrame.origin.x = self.view.frame.size.width - originFrame.size.width;
        self.deltaX = - self.deltaX * padValue;
    }
    
    if(newFrame.origin.y < 0 ) {
        newFrame.origin.y = 0;
        self.deltaY = - self.deltaY * padValue;
    }
    
    if(newFrame.origin.y > self.view.frame.size.height - originFrame.size.height) {
        newFrame.origin.y = self.view.frame.size.height - originFrame.size.height;
        self.deltaY = - self.deltaY * padValue;
    }
    self.ballImageView.frame = newFrame;
    
}




@end
