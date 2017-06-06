//
//  TagBuilderView.h
//  TidusWWDemo
//
//  Created by Tidus on 17/1/18.
//  Copyright © 2017年 Tidus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagViewModel.h"

typedef void(^confirmDidClickBlock)(TagViewModel *);

/**
 *  用来填标签信息
 */
@interface TagBuilderView : UIView

@property (nonatomic, copy) confirmDidClickBlock confirmBlock;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

+ (instancetype)viewFromNib;

- (void)setInfo:(TagViewModel *)viewModel;

- (void)show;
- (void)hide;
@end
