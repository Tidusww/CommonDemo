//
//  TagViewModel.h
//  TidusWWDemo
//
//  Created by Tidus on 17/1/18.
//  Copyright © 2017年 Tidus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TagModel.h"

//样式
typedef NS_ENUM(NSUInteger, TagViewStyle) {
    TagViewStyleSquareRight,
    TagViewStyleSquareLeft,
    TagViewStyleObliqueRight,
    TagViewStyleObliqueLeft

};

@interface TagViewModel : NSObject

//文本数组
@property (nonatomic, strong) NSMutableArray<TagModel *> *tagModels;
//标签相对于父视图坐标系中的相对坐标，例如（0.5, 0.5）即代表位于父视图中心
@property (nonatomic, assign) CGPoint coordinate;
//样式
@property (nonatomic, assign) TagViewStyle style;
//顺序标志
@property (nonatomic, assign) NSUInteger index;

//初始化
- (instancetype)initWithArray:(NSArray<TagModel *> *)tagModels coordinate:(CGPoint)coordinate;

//样式相关
- (void)resetStyle;
- (void)styleToggle;
- (void)synchronizeAngle;

@end
