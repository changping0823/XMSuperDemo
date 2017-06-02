//
//  XMPlayerView.m
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/5.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "XMPlayerView.h"

@interface XMPlayerView ()

@property(nonatomic, strong)AVMutableVideoComposition *mainComposition;

@property (nonatomic ,readwrite) AVPlayerItem *item;

@property (nonatomic ,readwrite) AVPlayerLayer *playerLayer;

@property (nonatomic ,readwrite) AVPlayer *player;

@property (nonatomic ,strong)  id timeObser;

@property (nonatomic ,assign) float videoLength;

@end

@implementation XMPlayerView
-(id)initWithUrl:(NSURL *)url delegate:(id<XMPlayerViewDelegate>)delegate{
    if (self = [super init]) {
        self.backgroundColor = [UIColor grayColor];
        self.playerUrl = url;
        self.delegate = delegate;
        [self setUpPlayer];
        [self addSwipeView];
    }
    return self;
}
- (id)initWithPath:(NSString *)path delegate:(id<XMPlayerViewDelegate>)delegate {
    return [self initWithUrl:[NSURL fileURLWithPath:path] delegate:delegate];
}
-(void)setUpPlayer{
    
    self.player = [AVPlayer playerWithPlayerItem:self.item];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.layer addSublayer:self.playerLayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playToEndTimeNotification:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:self.item];
    
    [self addVideoKVO];
    [self addVideoTimerObserver];
    
}
-(void)playToEndTimeNotification:(NSNotification *)notification{
    [self.player seekToTime:CMTimeMake(0, 1)];
    [self.player play];
}
-(void)setPlayerUrl:(NSURL *)playerUrl{
    _playerUrl = playerUrl;
    self.item = [[AVPlayerItem alloc] initWithURL:_playerUrl];
}



#pragma mark - KVO
- (void)addVideoKVO{

    [self.item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [self.item addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [self.item addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
}


- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSString*, id> *)change context:(nullable void *)context {
    
    
    if ([keyPath isEqualToString:@"status"]) {
        NSLog(@"status == %ld",(long)_item.status);
        AVPlayerItemStatus status = _item.status;
        switch (status) {
            case AVPlayerItemStatusReadyToPlay:{
                NSLog(@"AVPlayerItemStatusReadyToPlay");
                [self.player play];
                self.videoLength = floor(self.item.asset.duration.value * 1.0/ self.item.asset.duration.timescale);
            }
                break;
            case AVPlayerItemStatusUnknown:
                NSLog(@"AVPlayerItemStatusUnknown");
                break;
            case AVPlayerItemStatusFailed:
                NSLog(@"AVPlayerItemStatusFailed");
                NSLog(@"%@",self.item.error);
                break;
                
            default:
                break;
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        
    } else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) {
        
    }
}

#pragma mark - TimerObserver
- (void)addVideoTimerObserver {
    __weak typeof (self)weakSelf = self;
    _timeObser = [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        float currentTimeValue = time.value*1.0/time.timescale/weakSelf.videoLength;
        
    }];
}
- (void)removeVideoTimerObserver {
    [_player removeTimeObserver:_timeObser];
}



-(void)addSwipeView{
    
}



-(void)layoutSubviews{
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
}

- (void)removeVideoKVO {
    [self.item removeObserver:self forKeyPath:@"status"];
    [self.item removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [self.item removeObserver:self forKeyPath:@"playbackBufferEmpty"];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];

    [self.player pause];
    [self removeVideoKVO];
    [self removeVideoTimerObserver];
    
}

@end
