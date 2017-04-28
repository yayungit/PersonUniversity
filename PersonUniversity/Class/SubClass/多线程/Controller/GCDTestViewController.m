//
//  GCDTestViewController.m
//  PersonUniversity
//
//  Created by 何亚运 on 2017/2/8.
//  Copyright © 2017年 YYStar. All rights reserved.
//

#import "GCDTestViewController.h"

@interface GCDTestViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@end



@implementation GCDTestViewController


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSDate *date = [NSDate date];
    YYLog(@"date=%@", date);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeInterval timeInterval1970 = [date timeIntervalSince1970];
    YYLog(@"timeInterval1970 = %0.f", timeInterval1970);
    
    NSString *datestr = [formatter stringFromDate:date];
    YYLog(@"datestr=%@", datestr);
    
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSString *datestr2 = [formatter stringFromDate:date];
    YYLog(@"datestr=%@", datestr2);
    
    
    
    
    
    
    
    
    
}








- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(30, 100, 100, 100);
    [self.view addSubview:imageView];
    _imageView = imageView;
}
- (IBAction)nsthreadClick:(id)sender {
    // NSThread
    [self creatNewThread];
}
//
- (IBAction)gcdClick:(id)sender {
    // 串行同步
    // 不开辟（避开）线程， block间同步（顺序）序执行
//    [self chuanxingtongbu];
    
    // 串行异步
    // 避开线程开辟一个新的线程线程，block间同步执行
//    [self chuanxingyibu];
    
    // 并行同步
    // 不避开（不开辟）线程， block间同步执行
//    [self bingxingtongbu];
    
    // 并行异步
    // 避开线程（开辟新的线程）， block间并发执行
    [self bingxingyibu];
    // 全剧队列，所有的应用程序均可使用并发队列，没必要通过dispatch_queue_create 生成，直接get获取；
    // 既然支持并发队列，那就跟并发同步，并发异步测试结果一个，就不测试了
//    dispatch_queue_t gloable_queu = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

// 串行同步
- (void)chuanxingtongbu {
    dispatch_queue_t chuanxing_queue = dispatch_queue_create("chuanxing_queue", DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i < 5; i++) {
        dispatch_sync(chuanxing_queue, ^{
            YYLog(@"currentThread-->%@--->i=%d",[NSThread currentThread],i);
        });
    }
}
// 串行异步
- (void)chuanxingyibu {
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i < 5; i++) {
        dispatch_async(queue, ^{
            YYLog(@"currentThread-->%@--->i=%d",[NSThread currentThread],i);
        });
    }

}
// 并行同步
- (void)bingxingtongbu {
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 5; i++) {
        dispatch_sync(queue, ^{
            YYLog(@"currentThread-->%@--->i=%d",[NSThread currentThread],i);
        });
    }
}
// 并行异步
- (void)bingxingyibu {
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 5; i++) {
        dispatch_async(queue, ^{
            YYLog(@"currentThread-->%@--->i=%d",[NSThread currentThread],i);
        });
    }
}



- (IBAction)nsOperationClick:(id)sender {
    
    
}

- (void)creatNewThread {
//    [NSThread detachNewThreadWithBlock:^{
//        [self downLoadImage];
//    }];
//    [self performSelectorInBackground:@selector(downLoadImage) withObject:nil];
    // 此方式需要手动开启
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(downLoadImage) object:nil];
    [thread start];
}
- (void)downLoadImage {
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://p1.bpimg.com/524586/475bc82ff016054ds.jpg"]];
    UIImage *image = [UIImage imageWithData:data];
    [self performSelectorOnMainThread:@selector(reloadUIImageWith:) withObject:image waitUntilDone:YES];
}
- (void)reloadUIImageWith:(UIImage *)image {
    _imageView.image = image;
}


@end
