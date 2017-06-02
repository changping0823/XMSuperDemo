//
//  XMPlayerView.h
//  XMSuperDemo
//
//  Created by 任长平 on 2017/5/5.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol XMPlayerViewDelegate <NSObject>


@end

@interface XMPlayerView : UIView

//@property (nonatomic ,copy) NSString *playerPath;
@property(nonatomic, strong)NSURL *playerUrl;

@property (nonatomic ,readonly) AVPlayerItem *item;

@property (nonatomic ,readonly) AVPlayerLayer *playerLayer;

@property (nonatomic ,readonly) AVPlayer *player;

@property (nonatomic ,weak) id <XMPlayerViewDelegate> delegate;

- (id)initWithUrl:(NSURL *)url delegate:(id<XMPlayerViewDelegate>)delegate;
- (id)initWithPath:(NSString *)path delegate:(id<XMPlayerViewDelegate>)delegate;



@end
