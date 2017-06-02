//
//  XMStatusCell.m
//  XMSuperDemo
//
//  Created by 任长平 on 2016/12/13.
//  Copyright © 2016年 任长平. All rights reserved.
//

#import "XMStatusCell.h"
#import "UIImageView+WebCache.h"

@interface XMStatusCell ()
/** VIP */
@property (nonatomic, strong) UIImageView * VIPImage;
/** 用户等级 */
@property (nonatomic, strong) UIImageView * levelImage;
/** 用户头像 */
@property (nonatomic, strong) UIImageView * headerImage;
/** 用户昵称 */
@property (nonatomic, strong) UILabel * nickNameLabel;
/** 发布时间 */
@property (nonatomic, strong) UILabel * timeLabel;
/** 微博内容 */
@property (nonatomic, strong) UILabel * contentLabel;
/** 微博图片 */
@property (nonatomic, strong) UIView * photoView;

@end

@implementation XMStatusCell

+(instancetype)createTableViewCell:(UITableView *)tableView{
    NSString * identifier = @"XMStatusCell";
    XMStatusCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[XMStatusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellStyleDefault;
        [self initView];
        [self makeConstraints];
    }
    return self;
}
-(void)initView{
    self.headerImage = [[UIImageView alloc]init];
    self.headerImage.clipsToBounds = YES;
    [self addSubview:self.headerImage];
    
    self.levelImage = [[UIImageView alloc]init];
    [self addSubview:self.levelImage];
    
    self.VIPImage = [[UIImageView alloc]init];
    [self addSubview:self.VIPImage];
    
    self.nickNameLabel = [[UILabel alloc]init];
    self.nickNameLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.nickNameLabel];
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    self.timeLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:self.timeLabel];
    
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.font = [UIFont systemFontOfSize:13];
    self.contentLabel.numberOfLines = 0;
    /** UILabel 自动适配需要设置最大宽度，不然在自动计算高度是会有问题 */
    self.contentLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - 20;
    self.contentLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:self.contentLabel];
    
    self.photoView = [[UIView alloc]init];
    [self addSubview:self.photoView];
    
    
    
//    self.nickNameLabel.backgroundColor = [UIColor RandomColor];
//    self.contentLabel.backgroundColor  = [UIColor RandomColor];
    self.photoView.backgroundColor = [UIColor RandomColor];

    
}
-(void)makeConstraints{
    
    [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(10);
        make.top.mas_equalTo(self).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.VIPImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.bottom.mas_equalTo(self.headerImage).with.offset(2);
        make.right.mas_equalTo(self.headerImage).with.offset(2);
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerImage);
        make.left.mas_equalTo(self.headerImage.mas_right).with.offset(10);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.headerImage);
        make.left.mas_equalTo(self.headerImage.mas_right).with.offset(10);
    }];
    
    
    [self.levelImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nickNameLabel.mas_right).with.offset(5);
        make.centerY.mas_equalTo(self.nickNameLabel);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerImage.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.headerImage);
        make.right.lessThanOrEqualTo(self.mas_right).with.offset(-10);
    }];
    
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(self.contentLabel.mas_bottom).with.offset(10);
        make.height.mas_offset(100);
    }];
    
    
}
-(void)setStatus:(XMStatuses *)status{
    _status = status;
    
    NSLog(@"pic_urls.count == %lu",(unsigned long)self.status.pic_urls.count);

    
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:_status.user.profile_image_url]
     ];
    self.nickNameLabel.text = _status.user.name;
    self.timeLabel.text     = _status.created_at;
    self.contentLabel.text  = _status.text;
    
    switch (_status.user.verified_type) {
        case XMUserVerifiedTypeNone:
            //            self.VIPImage.image = [UIImage imageNamed:];
            break;
        case XMUserVerifiedPersonal:
            self.VIPImage.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        case XMUserVerifiedDaren:
            self.VIPImage.image = [UIImage imageNamed:@"avatar_vip"];
            break;
        case XMUserVerifiedOrgMedia:
            break;
        case XMUserVerifiedOrgWebsite:
            self.VIPImage.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        case XMUserVerifiedOrgEnterprice:
            self.VIPImage.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
            
        default:
            break;
    }
    NSString * levelImageName = [NSString stringWithFormat:@"common_icon_membership_level%d",_status.user.mbtype];
    self.levelImage.image = [UIImage imageNamed:levelImageName];
    
    CGFloat photoViewH = 0;
    CGFloat space = 0;
    
    if (self.status.pic_urls.count > 6){
        photoViewH = 240;
        space = 10;
    }else if (self.status.pic_urls.count > 3){
        photoViewH = 160;
        space = 10;
    }else if (self.status.pic_urls.count > 0) {
        photoViewH = 80;
        space = 10;
    }
    
    [self.photoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-space);
        make.top.equalTo(self.contentLabel.mas_bottom).with.offset(space);
        make.height.mas_offset(photoViewH);
    }];
    
    
    [UIView animateWithDuration:0.24 animations:^{
        [self layoutIfNeeded];
    }];

    
//    // 告诉self.view约束需要更新
//    [self setNeedsUpdateConstraints];
//    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
//    [self updateConstraintsIfNeeded];
    
}

#pragma mark - updateViewConstraints
- (void)updateConstraints {
    
//    CGFloat photoViewH = 160;
//    CGFloat space = 10;
//    if (self.status.pic_urls.count == 0) {
//        photoViewH = space = 0;
//    }else if (self.status.pic_urls.count > 3){
//        photoViewH = 80;
//    }
//    [self.photoView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).with.offset(10);
//        make.right.equalTo(self.mas_right).with.offset(-space);
//        make.top.equalTo(self.contentLabel.mas_bottom).with.offset(space);
//        make.height.mas_offset(photoViewH);
//    }];
    
    [super updateConstraints];
}


+ (CGFloat)heightWithModel:(XMStatuses *)status{
    XMStatusCell *cell = [[XMStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XMStatusCell"];
    cell.status = status;
    [cell layoutIfNeeded];
    return CGRectGetMaxY(cell.photoView.frame)+10;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
