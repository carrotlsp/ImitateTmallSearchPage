//
//  Created by carrot__lsp on 2018/6/7.
//  Copyright © 2018年 carrot__lsp. All rights reserved.
//

#import "DDMySearchBar.h"
#import "UIView+Extension.h"
#import "UIColor+DD.h"

@interface DDMySearchBar ()

/** dd */

@property(nonatomic,assign) BOOL isChangeFrame;//是否要改变searchBar的frame
@end

@implementation DDMySearchBar


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //一下代码为修改placeholder字体的颜色和大小
    UITextField * searchField = [self valueForKey:@"_searchField"];
//    [searchField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    [searchField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
    for (UIView *subView in self.subviews[0].subviews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            //移除UISearchBarBackground
            [subView removeFromSuperview];
        }
        if ([subView isKindOfClass:[UITextField class]]) {
            CGFloat height = self.bounds.size.height;
            CGFloat width = self.bounds.size.width;
            
            if (_isChangeFrame) {
                //说明contentInset已经被赋值
                // 根据contentInset改变UISearchBarTextField的布局
                subView.frame = CGRectMake(_contentInset.left, _contentInset.top, width - 2 * _contentInset.left, height - 2 * _contentInset.top);
            } else {
                // contentSet未被赋值
//                 设置UISearchBar中UISearchBarTextField的默认边距
                CGFloat top = (height - 28.0) / 2.0;
                CGFloat bottom = top;
                CGFloat left = 8.0;
                CGFloat right = left;
                _contentInset = UIEdgeInsetsMake(top, left, bottom, right);
            }
        }
    }

    UIImageView* backgroundView = [self subViewOfClassName:@"_UISearchBarSearchFieldBackgroundView"];
    backgroundView.layer.cornerRadius = 18;
    backgroundView.clipsToBounds = YES;
    backgroundView.backgroundColor = [UIColor colorWithHexString:@"F2F3F5"];
    [backgroundView setImage:[UIImage new]];
}

#pragma mark - set method
- (void)setContentInset:(UIEdgeInsets)contentInset {
    
    _contentInset.top = contentInset.top;
    _contentInset.bottom = contentInset.bottom;
    _contentInset.left = contentInset.left;
    _contentInset.right = contentInset.right;
    
    self.isChangeFrame = YES;
    [self layoutSubviews];
}

- (void)setIsChangeFrame:(BOOL)isChangeFrame {
    
    if (_isChangeFrame != isChangeFrame) {
        
        _isChangeFrame = isChangeFrame;
    }
}



@end
