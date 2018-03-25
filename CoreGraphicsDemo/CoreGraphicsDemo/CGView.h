//
//  CGView.h
//  CoreGraphicsDemo
//
//  Created by HK on 18/3/21.
//  Copyright © 2018年 HK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CGViewType) {
    CGViewTypeOrigin,
    CGViewTypeCoreGpaphics,
    CGViewTypeUIKit,
    CGViewTypeText,
    CGViewTypeSmileFace,
    CGViewTypeParabola,
    CGViewTypePee
};

@interface CGView : UIView
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) CGFloat xSpeed;
@property (nonatomic, assign) CGViewType type;

-(instancetype)initWithFrame:(CGRect)frame type:(CGViewType)type;

@end
