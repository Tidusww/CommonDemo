//
//  TagViewModel.m
//  TidusWWDemo
//
//  Created by Tidus on 17/1/18.
//  Copyright © 2017年 Tidus. All rights reserved.
//

#import "TagViewModel.h"
static NSInteger const maxStyle = 4;
static NSDictionary *styleDict;

@implementation TagViewModel

- (instancetype)initWithArray:(NSMutableArray<TagModel *> *)tagModels coordinate:(CGPoint)coordinate
{
    if(self=[self init]){
        if(!tagModels){
            tagModels = [NSMutableArray<TagModel *> array];
        }
        self.tagModels = tagModels.mutableCopy;
        self.coordinate = coordinate;
        self.style = TagViewStyleSquareRight;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    
    //样式
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"TagViewStyle" ofType:@"plist"];
        styleDict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        
    });
    return self;
}

#pragma mark - 判断当前style
//根据标签数量进行判断
- (void)resetStyle
{
    NSInteger count = _tagModels.count;
    if(count == 0){
        NSLog(@"_tagModels.count = 0");
        return;
    }
    
    //根据标签条数拿出对应的样式数据
    NSDictionary *countStyleDict = styleDict[[NSString stringWithFormat:@"%@", @(count)]];
    if(!countStyleDict){
        NSLog(@"styleDict not found");
        return;
    }
    
    //allKeys为所有TagViewStyle
    NSArray *allKeys = [countStyleDict allKeys];
    //遍历TagViewStyle
    for(NSInteger i=0; i<allKeys.count; i++){
        NSString *styleStr = allKeys[i];
        //以此为key拿出对应style的角度
        NSArray *styleArray = countStyleDict[styleStr];
        if(styleArray.count == 0){
            //没有角度数据
            continue;
        }
        //无论有多少条标签，这里都只判断了第一条标签的角度
        //可以考虑改为验证所有标签的角度来判断数据的合法性
        NSNumber *angleNumber = (NSNumber*)styleArray[0];
        if(_tagModels[0].angle == [angleNumber floatValue]){
            _style = [styleStr integerValue];
            NSLog(@"_style reset:%@", @(_style));
            return;
        }
    }
}


#pragma mark - 切换当前style
- (void)styleToggle
{
    //切换
    _style = (_style+1)%maxStyle;
    
    [self synchronizeAngle];
}

#pragma mark - 根据当前style更新角度
- (void)synchronizeAngle
{
    NSInteger count = _tagModels.count;
    if(count == 0){
        NSLog(@"_tagModels.count = 0");
        return;
    }
    
    //根据标签条数拿出对应的样式数据
    NSDictionary *countStyleDict = styleDict[[NSString stringWithFormat:@"%@", @(count)]];
    if(!countStyleDict){
        NSLog(@"styleDict not found");
        return;
    }
    
    //根据样式拿出角度数据数组
    NSArray *styleArray = countStyleDict[[NSString stringWithFormat:@"%@", @(_style)]];
    if(styleArray.count < _tagModels.count){
        NSLog(@"styleArray doesn't long enough");
        return;
    }
    
    //更新角度
    for(NSInteger i=0; i<_tagModels.count; i++){
        NSNumber *angleNumber = (NSNumber*)styleArray[i];
        _tagModels[i].angle = [angleNumber floatValue];
    }
}

#pragma mark - setter
- (void)setStyle:(TagViewStyle)style
{
    _style = style;
    [self synchronizeAngle];
}

@end
