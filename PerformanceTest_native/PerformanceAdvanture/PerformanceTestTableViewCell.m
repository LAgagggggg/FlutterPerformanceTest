//
//  PerformanceTestTableViewCell.m
//  PerformanceAdvanture
//
//  Created by LAgagggggg on 2018/10/9.
//  Copyright © 2018 nil. All rights reserved.
//

#import "PerformanceTestTableViewCell.h"
#import <Masonry.h>

@interface PerformanceTestTableViewCell()

@property (strong,nonatomic) UIImageView * avatarImageView;
@property (strong,nonatomic) UIImageView * dataImageView1;
@property (strong,nonatomic) UIImageView * dataImageView2;
@property (strong,nonatomic) UILabel * label;

@end

@implementation PerformanceTestTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        //Rasterize
//        self.contentView.layer.shouldRasterize=YES;
//        self.contentView.layer.rasterizationScale=[UIScreen mainScreen].scale;
        //alpha
        self.backgroundColor=[UIColor colorWithRed:(1-0.3)*255/255.0 green:(1-0.3)*255/255.0 blue:(1-0.3)*255/255.0 alpha:1];
//        self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        //native set cornerRadius
        self.layer.cornerRadius=10.f;
        //native set shadows
        self.layer.shadowColor=[UIColor colorWithRed:94/255.0 green:169/255.0 blue:234/255.0 alpha:1].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 6);
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowRadius = 8;
        self.avatarImageView=({
            UIImageView * avatarImageView=[[UIImageView alloc]init];
            [self.contentView addSubview:avatarImageView];
            [avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView.mas_left).with.offset(8);
                make.top.equalTo(self.contentView.mas_top).with.offset(8);
                make.width.mas_equalTo(40);
                make.height.mas_equalTo(40);
            }];
            avatarImageView.contentMode=UIViewContentModeScaleAspectFit;
            avatarImageView;
        });
        self.label=({
            UILabel * label=[[UILabel alloc]init];
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.avatarImageView.mas_right).with.offset(15);
                make.centerY.equalTo(self.avatarImageView.mas_centerY);
            }];
            label.textColor=[UIColor colorWithRed:2/255.0 green:80/255.0 blue:80/255.0 alpha:1];
            label;
        });
        self.dataImageView1=({
            UIImageView * dataImageView=[[UIImageView alloc]init];
            [self.contentView addSubview:dataImageView];
            [dataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.avatarImageView.mas_right).with.offset(15);
                make.top.equalTo(self.label.mas_bottom).with.offset(8);
                make.width.mas_equalTo(75);
                make.height.mas_equalTo(45);
            }];
            dataImageView.contentMode=UIViewContentModeScaleAspectFit;
            dataImageView;
        });
        self.dataImageView2=({
            UIImageView * dataImageView=[[UIImageView alloc]init];
            [self.contentView addSubview:dataImageView];
            [dataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.dataImageView1.mas_right).with.offset(15);
                make.centerY.equalTo(self.dataImageView1);
                make.width.mas_equalTo(75);
                make.height.mas_equalTo(45);
            }];
            dataImageView.contentMode=UIViewContentModeScaleAspectFit;
            dataImageView;
        });
//        native set image's cornerRadius&clip
//        self.avatarImageView.layer.cornerRadius=20.0;
//        self.avatarImageView.layer.masksToBounds=YES;
//        self.dataImageView1.layer.cornerRadius=10.f;
//        self.dataImageView1.layer.masksToBounds=YES;
//        self.dataImageView2.layer.cornerRadius=10.f;
//        self.dataImageView2.layer.masksToBounds=YES;
    }
    return self;
}

- (void)layoutSubviews{//using shadowPath to get rid of off-screen render cause by shadows
    [super layoutSubviews];
    self.layer.shadowPath=[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:10.f].CGPath;
}

- (void)setFrame:(CGRect)frame{
    float screenAdaptRatio=[UIScreen mainScreen].bounds.size.width/375.0;
    frame.origin.x+=15*screenAdaptRatio;
    frame.size.width-=2*15*screenAdaptRatio;
    frame.origin.y+=15;
    frame.size.height-=15;
    [super setFrame:frame];
}

- (void)setItem:(PerformanceTestItem *)item{
    _item=item;
    self.label.text=item.text;
//    //draw Image with roundRect asyncly
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage * image1=[self imageWithRoundRect:item.dataImage1 cornerRadius:20];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.dataImageView1 setImage:image1];
        });
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage * image2=[self imageWithRoundRect:item.dataImage2 cornerRadius:20];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.dataImageView2 setImage:image2];
        });
    });

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage * avatarImage=[self imageWithRoundRect:item.avatarImage cornerRadius:item.avatarImage.size.width/2];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.avatarImageView setImage:avatarImage];
        });
    });
//    [self.dataImageView1 setImage:item.dataImage1];
//    [self.dataImageView2 setImage:item.dataImage2];
//    [self.avatarImageView setImage:item.avatarImage];
}

- (UIImage *)imageWithRoundRect:(UIImage *)image cornerRadius:(CGFloat)radius{
    UIImage * roundRectImage;
    UIGraphicsBeginImageContextWithOptions(image.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context=UIGraphicsGetCurrentContext();
    if (context) {
        CGRect rect=CGRectMake(0, 0, image.size.width, image.size.height);
        CGContextAddPath(context, [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
        CGContextClip(context);
        [image drawInRect:rect];
        CGContextDrawPath(context, kCGPathFillStroke);
        roundRectImage=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return roundRectImage;
}

@end
