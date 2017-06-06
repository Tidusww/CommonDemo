//
//  TagBuilderView.m
//  TidusWWDemo
//
//  Created by Tidus on 17/1/18.
//  Copyright © 2017年 Tidus. All rights reserved.
//

#import "TagBuilderView.h"
#import "TagModel.h"

@interface TagBuilderView ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField1;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField2;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField3;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField1;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField2;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField3;

@property (strong, nonatomic) TagViewModel *viewModel;
@end

@implementation TagBuilderView

+ (instancetype)viewFromNib
{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                                  owner:self
                                                options:nil];
    TagBuilderView *view = (TagBuilderView *)nibs[0];
    return view;
}

- (void)clearTextField
{
    _nameTextField1.text = @"";
    _valueTextField1.text = @"";
    _nameTextField2.text = @"";
    _valueTextField2.text = @"";
    _nameTextField3.text = @"";
    _valueTextField3.text = @"";
}

- (void)setInfo:(TagViewModel *)viewModel
{
    [self clearTextField];
    self.viewModel = viewModel;
    for (NSInteger i=0; i<viewModel.tagModels.count; i++) {
        TagModel *tagModel = viewModel.tagModels[i];
        if(i == 0){
            _nameTextField1.text = tagModel.name;
            _valueTextField1.text = tagModel.value;
        }
        if(i == 1){
            _nameTextField2.text = tagModel.name;
            _valueTextField2.text = tagModel.value;
        }
        if(i == 2){
            _nameTextField3.text = tagModel.name;
            _valueTextField3.text = tagModel.value;
        }
    }
}

- (IBAction)cancelDidClick:(id)sender {
    [self hide];
}

- (IBAction)confirmDidClick:(id)sender {
    [self.viewModel.tagModels removeAllObjects];
    if(_nameTextField1.text.length != 0 || _valueTextField1.text.length != 0){
        TagModel *model = [[TagModel alloc] initWithName:_nameTextField1.text value:_valueTextField1.text];
        [self.viewModel.tagModels addObject:model];
    }
    if(_nameTextField2.text.length != 0 || _valueTextField2.text.length != 0){
        TagModel *model = [[TagModel alloc] initWithName:_nameTextField2.text value:_valueTextField2.text];
        [self.viewModel.tagModels addObject:model];
    }
    if(_nameTextField3.text.length != 0 || _valueTextField3.text.length != 0){
        TagModel *model = [[TagModel alloc] initWithName:_nameTextField3.text value:_valueTextField3.text];
        [self.viewModel.tagModels addObject:model];
    }
    [self.viewModel synchronizeAngle];
    if(self.confirmBlock){
        self.confirmBlock(self.viewModel);
    }
}

- (void)show
{
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)hide
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

@end
