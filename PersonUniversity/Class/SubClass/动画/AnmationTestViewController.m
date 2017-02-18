//
//  AnmationTestViewController.m
//  PersonUniversity
//
//  Created by 何亚运 on 2017/2/14.
//  Copyright © 2017年 YYStar. All rights reserved.
//

#import "AnmationTestViewController.h"
#import <Speech/Speech.h>
#import <AVFoundation/AVFoundation.h>
@interface AnmationTestViewController ()

@property (nonatomic, strong) UIView *redView;
// 录音设备
@property (nonatomic, strong) AVAudioRecorder *recorider;
// 监听设备
@property (nonatomic, strong) AVAudioRecorder *monitor;
//
@property (nonatomic, strong) NSTimer *timer;
// 记录本地录制的文件路径
@property (nonatomic, strong) NSURL *recordUrl;


@end

@implementation AnmationTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_timer invalidate];
    _timer = nil;
}

//SFSpeechRecognizer：这个类是语音识别的操作类，用于语音识别用户权限的申请，语言环境的设置，语音模式的设置以及向Apple服务发送语音识别的请求。
//SFSpeechRecognitionTask：这个类是语音识别服务请求任务类，每一个语音识别请求都可以抽象为一个SFSpeechRecognitionTask实例，其中SFSpeechRecognitionTaskDelegate协议中约定了许多请求任务过程中的监听方法。
//SFSpeechRecognitionRequest:语音识别请求类，需要通过其子类来进行实例化。
//SFSpeechURLRecognitionRequest：通过音频URL来创建语音识别请求。
//SFSpeechAudioBufferRecognitionRequest:通过音频流来创建语音识别请求。
//SFSpeechRecognitionResult：语音识别请求结果类。
//SFTranscription：语音转换后的信息类。
//SFTranscriptionSegment：语音转换中的音频节点类。

// 识别本地语音
- (void)recognizeLocalAudioFile {
//    //1.创建本地化标识符
//    NSLocale *local = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
//    //2.创建一个语音识别对象
//    SFSpeechRecognizer *loclaeRecognize = [[SFSpeechRecognizer alloc] initWithLocale:local];
//    //3.将bundle 中的资源文件加载出来返回一个url
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"音乐文件.mp3" withExtension:nil];
//    //4.将资源包中获取的url(录音文件的地址)传递给 request对象
//    SFSpeechURLRecognitionRequest *request = [[SFSpeechURLRecognitionRequest alloc] initWithURL:url];
//    [loclaeRecognize recognitionTaskWithRequest:request resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
//        if (error == nil) {
//            NSLog(@"%@",result.bestTranscription.formattedString);
//        } else {
//            NSLog(@"解析错误");
//        }
//    }];
    // 设置录音环境
    // 音频会话
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:NULL];
    // 参数设置
    /*
     * settings 参数
     1.AVNumberOfChannelsKey 通道数 通常为双声道 值2
     2.AVSampleRateKey 采样率 单位HZ 通常设置成44100 也就是44.1k,采样率必须要设为11025才能使转化成mp3格式后不会失真
     3.AVLinearPCMBitDepthKey 比特率 8 16 24 32
     4.AVEncoderAudioQualityKey 声音质量
     ① AVAudioQualityMin  = 0, 最小的质量
     ② AVAudioQualityLow  = 0x20, 比较低的质量
     ③ AVAudioQualityMedium = 0x40, 中间的质量
     ④ AVAudioQualityHigh  = 0x60,高的质量
     ⑤ AVAudioQualityMax  = 0x7F 最好的质量
     5.AVEncoderBitRateKey 音频编码的比特率 单位Kbps 传输的速率 一般设置128000 也就是128kbps
     
     */
    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   [NSNumber numberWithFloat: 14400.0], AVSampleRateKey,
                                   [NSNumber numberWithInt: kAudioFormatAppleIMA4], AVFormatIDKey,
                                   [NSNumber numberWithInt: 2], AVNumberOfChannelsKey,
                                   [NSNumber numberWithInt: AVAudioQualityMin], AVEncoderAudioQualityKey,
                                   nil];
    NSString *recordPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"redcord.caf"];
    // 录音文件URL
    NSURL *recordUrl = [NSURL fileURLWithPath:recordPath];
    // 录音设备
    _recordUrl = recordUrl;
    _recorider = [[AVAudioRecorder alloc] initWithURL:recordUrl settings:recordSetting error:NULL];
    
    // 监听器
    NSString *monitorPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"monitor.caf"];
    NSURL *monitorUrl = [NSURL fileURLWithPath:monitorPath];
    AVAudioRecorder *monitor = [[AVAudioRecorder alloc] initWithURL:monitorUrl settings:recordSetting error:NULL];
    [monitor record];
    _monitor = monitor;
    [self start];
    
}
- (void)start {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    _timer = timer;
}
- (void)updateTimer {
    // 更新
    static NSInteger timer = 0;
    YYLog(@"%ld", timer++);
    [_monitor updateMeters];
    // 获取音调，-160没有声音，0时最大
//    float power = [_monitor peakPowerForChannel:0];
//    YYLog(@"power = %.f",power);
//    if (power>-20) {
        // 开始录音
        if (!_recorider.isRecording) {
            [_recorider record];
        }
        
//    }
//    else {
//        if (_recorider.isRecording) {
//            [_recorider stop];
//            // 开始识别
//            [self stoprecord];
//        }
//    }
}


- (void)stoprecord {
    // 停止定时器
    [_timer invalidate];
    // 监听也停止,并且删除监听器里的文件
    [_monitor stop];
    [_monitor deleteRecording];
    
}
- (void)playreord {
    // 创建语音识别对象,需要一个NSLocale对象创建一个
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    SFSpeechRecognizer *sfrecognizer = [[SFSpeechRecognizer alloc] initWithLocale:locale];
    // 读取本地录取的文件,将资源传给request对象
    SFSpeechURLRecognitionRequest *request = [[SFSpeechURLRecognitionRequest alloc] initWithURL:_recordUrl];
    // 解析
    [sfrecognizer recognitionTaskWithRequest:request resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        if (error) {
            YYLog("解析错误");
        } else {
            YYLog(@"%@",result.bestTranscription.formattedString);
        }
    }];
}

- (void)readMicrophone {
    // 申请语音识别权限
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (status) {
                case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                    YYLog(@"结果未知，语音识别未授权");
                    break;
                case SFSpeechRecognizerAuthorizationStatusDenied:
                    YYLog(@"用户未（拒绝）授权使用语音识别");
                    break;
                case SFSpeechRecognizerAuthorizationStatusRestricted:
                    YYLog(@"语音识别在这台设备上受到限制（不支持）");
                    break;
                case SFSpeechRecognizerAuthorizationStatusAuthorized:
                    YYLog(@"授权语音识别（录音）");
                    // 权限申请成功了，才能去操作，也就是创建SFSpeechRecognizer：这个类是语音识别的操作类，等操作
                    break;
                    
                default:
                    break;
            }
        });
    }];
}

#pragma mark - setupUI
- (void)setupUI {
    
    
    
    UIButton *localButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [localButton setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    localButton.frame = CGRectMake(30, kSCREENHEIGHT-100, kSCREENWIDTH-60, 40);
    [localButton setTitle:@"star" forState:(UIControlStateNormal)];
    [self.view addSubview:localButton];
    [localButton addTarget:self action:@selector(recognizeLocalAudioFile) forControlEvents:UIControlEventTouchUpInside];
    ;
    UIButton *stop = [UIButton buttonWithType:UIButtonTypeCustom];
    [stop setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    stop.frame = CGRectMake(30, kSCREENHEIGHT-160, kSCREENWIDTH-60, 40);
    [stop setTitle:@"stop" forState:(UIControlStateNormal)];
    [self.view addSubview:stop];
    [stop addTarget:self action:@selector(stoprecord) forControlEvents:UIControlEventTouchUpInside];
    ;
    UIButton *paly = [UIButton buttonWithType:UIButtonTypeCustom];
    [paly setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    paly.frame = CGRectMake(30, kSCREENHEIGHT-220, kSCREENWIDTH-60, 40);
    [paly setTitle:@"play" forState:(UIControlStateNormal)];
    [self.view addSubview:paly];
    [paly addTarget:self action:@selector(playreord) forControlEvents:UIControlEventTouchUpInside];
    ;
    
    
    UIButton *mircoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    mircoButton.frame = CGRectMake(30, kSCREENHEIGHT-300, kSCREENWIDTH-60, 40);
    [mircoButton setTitle:@"语音识别权限获取" forState:(UIControlStateNormal)];
    [self.view addSubview:mircoButton];
    [mircoButton setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [mircoButton addTarget:self action:@selector(readMicrophone) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(30, 100, 100, 100)];
    redView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:redView];
    [redView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(redViewTap)]];
//    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).offset(100);
//        make.left.equalTo(self.view.mas_left).offset(30);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(100);
//    }];
    _redView = redView;
}
#pragma mark - action
- (void)redViewTap {
    
//    CAShapeLayer *clickCicrleLayer = [CAShapeLayer layer];
//    clickCicrleLayer.frame = CGRectMake(0, 0, 50, 50);
//    clickCicrleLayer.backgroundColor = [UIColor redColor].CGColor;
//    clickCicrleLayer.cornerRadius = 8;
//    clickCicrleLayer.fillColor = [UIColor redColor].CGColor;
//    clickCicrleLayer.strokeColor = [UIColor greenColor].CGColor;
//    clickCicrleLayer.lineWidth = 10;
//    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
//    [bezierPath addArcWithCenter:CGPointMake(_redView.width/2, _redView.bounds.size.height/2) radius:30 startAngle:0 endAngle:2 * M_PI clockwise:YES];
//    [bezierPath stroke];
//    [bezierPath closePath];
//    clickCicrleLayer.path = bezierPath.CGPath;
//    [_redView.layer addSublayer:clickCicrleLayer];
    
    CABasicAnimation *basicAnmation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicAnmation.duration = 0.8;
    basicAnmation.fromValue = @0.5;
    basicAnmation.toValue = @3;
    basicAnmation.autoreverses = YES;
//    basicAnmation.repeatCount = MAXFLOAT;
    basicAnmation.removedOnCompletion = NO;
    basicAnmation.fillMode = kCAFillModeForwards;
    [_redView.layer addAnimation:basicAnmation forKey:@"redView"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)getNumber:(NSInteger)number {
    return number;
}

@end
