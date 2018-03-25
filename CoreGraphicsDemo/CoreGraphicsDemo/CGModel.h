//
//  CGModel.h
//  CoreGraphicsDemo
//
//  Created by HK on 18/3/25.
//  Copyright © 2018年 HK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGView.h"

@interface CGModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGViewType type;

@end
