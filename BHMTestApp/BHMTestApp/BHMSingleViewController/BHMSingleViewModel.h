//
//  BHMSingleViewModel.h
//  BHMTestApp
//
//  Created by Rostislav on 10/10/18.
//  Copyright © 2018 Ross. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BHMSingleViewModel : NSObject

@property NSMutableDictionary *contentInfo;
@property NSMutableArray<UITextField *> *fildsArray;

- (instancetype)initWithContactInfo:(NSDictionary *)contentInfo;
- (NSArray<NSString *> *)placeholders;
- (NSString *)randomStringWithLength:(int)len;
- (void)addTextField:(UITextField *)textField;

@end

NS_ASSUME_NONNULL_END
