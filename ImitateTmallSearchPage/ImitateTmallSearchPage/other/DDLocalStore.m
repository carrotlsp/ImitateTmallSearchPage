//
//  Created by carrot__lsp on 2018/6/7.
//  Copyright © 2018年 carrot__lsp. All rights reserved.
//

#import "DDLocalStore.h"

//Setting 是用于保存持久数据的
@interface DDLocalStore (){

}
@end

@implementation DDLocalStore



+ (DDLocalStore*)sharedStore {
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[DDLocalStore alloc] init];
    });
    return _sharedObject;
}



- (void)saveSearchHistoryArrayToLocal:(NSArray *)historyStringArray {
    [[NSUserDefaults standardUserDefaults] setObject:historyStringArray forKey:@"historyStringArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSMutableArray *)getSearchHistoryArrayFromLocal{
    NSArray *historyStringArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"historyStringArray"];
    historyStringArray = [NSMutableArray arrayWithArray:historyStringArray];
    return historyStringArray;
}



@end
