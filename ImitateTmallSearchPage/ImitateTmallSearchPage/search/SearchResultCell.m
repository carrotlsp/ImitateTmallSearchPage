//
//  SearchResultCell.m
//  ImitateTmallSearchPage
//
//  Created by carrot__lsp on 2018/11/15.
//  Copyright © 2018年 carrot.dbd. All rights reserved.
//

#import "SearchResultCell.h"

@interface SearchResultCell ()
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation SearchResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSearchText:(NSString *)searchText {
    _searchText = searchText;
    self.resultLabel.text = searchText;
    
}

@end
