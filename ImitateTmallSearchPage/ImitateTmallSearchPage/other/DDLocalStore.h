//
//  Created by carrot__lsp on 2018/6/7.
//  Copyright © 2018年 carrot__lsp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDLocalStore : NSObject

+ (DDLocalStore*)sharedStore;


- (void)saveSearchHistoryArrayToLocal:(NSMutableArray *)historyStringArray;
- (NSMutableArray *)getSearchHistoryArrayFromLocal;


@end
