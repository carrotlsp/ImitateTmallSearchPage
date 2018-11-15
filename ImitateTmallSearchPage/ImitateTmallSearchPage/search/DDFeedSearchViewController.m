//
//  Created by carrot__lsp on 2018/6/7.
//  Copyright © 2018年 carrot__lsp. All rights reserved.
//

#import "DDFeedSearchViewController.h"
#import "UIView+Extension.h"
#import "DDMySearchBar.h"
#import "DDLocalStore.h"
#import "UIColor+DD.h"
#import "UILabel+HuaZhi.h"
#import "SearchResultCell.h"


@interface DDFeedSearchViewController ()<UISearchBarDelegate, UIScrollViewDelegate>

@property (nonatomic,strong) DDMySearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSString *keyword;


@property (weak, nonatomic) IBOutlet UIView *noDataView;

@property (weak, nonatomic) IBOutlet UIView *tipSearchView;
@property (weak, nonatomic) IBOutlet UIView *tipTopView;
@property (weak, nonatomic) IBOutlet UIView *tipBottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tipTopViewHeight;

//搜索历史
@property (nonatomic, strong) NSMutableArray *historyArray;

@end

@implementation DDFeedSearchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.noDataView.hidden = YES;

    [self setupTopRightButton];
    [self setupTopLeftButton];
    self.isChangeSearchBarFrame = YES;
    self.historyArray = [[DDLocalStore sharedStore] getSearchHistoryArrayFromLocal];
    [self updateHistoryList];
    [self addHotList];
}
- (IBAction)cleanHistoryAction {
    self.historyArray = [NSMutableArray new];
    [[DDLocalStore sharedStore] saveSearchHistoryArrayToLocal:self.historyArray];
    [self updateHistoryList];
}

- (void)updateHistoryList {
    
    for (UIView *view in self.tipTopView.subviews) {
        if (view.tag == 1999) {
            [view removeFromSuperview];
        }
    }
    
    CGSize orgxy=CGSizeMake(10, 50);
    for (int i=0; i<self.historyArray.count; i++) {
        UILabel *historyLabel=[[UILabel alloc] init];
        historyLabel.backgroundColor = [UIColor colorWithHexString:@"F4F4F4"];
        historyLabel.clipsToBounds = YES;
        historyLabel.layer.cornerRadius = 3;
        historyLabel.tag = 1999;
        historyLabel.font = [UIFont systemFontOfSize:15];
        historyLabel.textColor = [UIColor colorWithHexString:@"333333"];
        historyLabel.text=[NSString stringWithFormat:@"   %@   ", self.historyArray[i]];
        orgxy=[historyLabel nextOrgin:orgxy];//适配
        [historyLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        historyLabel.userInteractionEnabled=YES;
        [self.tipTopView addSubview:historyLabel];
    }
    self.tipTopViewHeight.constant = orgxy.height + 40 + 20;

    if (self.historyArray.count == 0) {
        self.tipTopViewHeight.constant = 0;
    }
}

- (void)addHistoryString:(NSString *)historyString {
    
    if ([self.historyArray containsObject:historyString]) {
        [self.historyArray removeObject:historyString];
    }
    [self.historyArray insertObject:historyString atIndex:0];
    [[DDLocalStore sharedStore] saveSearchHistoryArrayToLocal:self.historyArray];
    [self updateHistoryList];
    
}

- (void)addHotList {
    NSArray *hotArray = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    CGSize orgxy=CGSizeMake(10, 50);
    for (int i=0; i<hotArray.count; i++) {
        UILabel *historyLabel=[[UILabel alloc] init];
        historyLabel.backgroundColor = [UIColor colorWithHexString:@"F4F4F4"];
        historyLabel.clipsToBounds = YES;
        historyLabel.layer.cornerRadius = 3;
        historyLabel.font = [UIFont systemFontOfSize:15];
        historyLabel.textColor = [UIColor colorWithHexString:@"333333"];
        historyLabel.text=[NSString stringWithFormat:@"   %@   ",hotArray[i]];
        orgxy=[historyLabel nextOrgin:orgxy];//适配
        [historyLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        historyLabel.userInteractionEnabled=YES;
        [self.tipBottomView addSubview:historyLabel];
    }
    //    [self addtableView:orgxy];
//    self.tipTopViewHeight.constant = orgxy.height + 40 + 20;
    
//    if (hotArray.count == 0) {
//        self.tipBottomView.constant = 0;
//    }
}
#pragma mark - tap
//热门标签点击相应
-(void)tagDidCLick:(UITapGestureRecognizer *)sender
{
    UILabel *label=(UILabel *)sender.view;
    
    NSString *text =  [label.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSLog(@"text===%@",text);
    [self addHistoryString:text];
    self.searchBar.text = text;
    [self searchBarSearchButtonClicked:self.searchBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.searchBar becomeFirstResponder];
}


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBar endEditing:YES];
}




- (DDMySearchBar *)addSearchBarWithFrame:(CGRect)frame {
    
    self.definesPresentationContext = YES;
    
    DDMySearchBar *searchBar = [[DDMySearchBar alloc]initWithFrame:frame];
    searchBar.delegate = self;
    searchBar.placeholder = @"输入关键字";
    [searchBar setShowsCancelButton:NO];
    
    return searchBar;
}



- (void)loadRemoteDataWithKeyword:(NSString *)keyword {
    
    
}
#pragma mark - topLeftButton
- (void)setupTopLeftButton {
    _searchBar = [self addSearchBarWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width -  44 - 40, 32)];
    UIView *wrapView = [[UIView alloc] initWithFrame:_searchBar.frame];
    [wrapView addSubview:_searchBar];
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:wrapView];
    self.navigationItem.leftBarButtonItems = @[item];
}

- (void)topLeftButtonDidClicked {
        [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - topRightButton
- (void)setupTopRightButton {
    UIButton *topRightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [topRightButton setTitle:@"取消" forState: UIControlStateNormal];
    [topRightButton setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [topRightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    topRightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
    topRightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    topRightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    topRightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    topRightButton.frame = CGRectMake(0, 0, 40, 25);
    [topRightButton addTarget:self action:@selector(topRightButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    topRightButton.backgroundColor = [UIColor clearColor];
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:topRightButton];


    self.navigationItem.rightBarButtonItems = @[item];
}

- (void)topRightButtonDidClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - topLeftButton



#pragma mark - searchBar about
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    //    self.isShowResult = YES;
   
    
    [self.searchBar endEditing:YES];
    self.keyword = searchBar.text;
    [self addHistoryString:searchBar.text];
    if (searchBar.text.length > 0) {
        [self.tableView reloadData];
        self.tipSearchView.hidden = YES;
    } else {
        self.tipSearchView.hidden = NO;
    }
};

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.keyword = searchBar.text;
    if (searchBar.text.length > 0) {
        [self.tableView reloadData];
        self.tipSearchView.hidden = YES;
    } else {
        self.tipSearchView.hidden = NO;
    }
}



#pragma mark - tableView about

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"DDFeedSearchCell";
    
    SearchResultCell *cell =  [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [SearchResultCell dd_loadFromXIB];
    }
    
    cell.searchText = self.searchBar.text;
    
    return cell;
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.searchBar endEditing:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
