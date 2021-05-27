//
//  ExcelView.h
//  ExcelDemo
//
//  Created by Destiny on 2021/5/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExcelView : UIView

@property(nonatomic,assign)NSInteger rowNumber;//行数
@property(nonatomic,assign)NSInteger columnNumber;//列数
@property(nonatomic,strong)NSDictionary *dataSource;//数据源（具体使用根据你的数据结构来）

@end

NS_ASSUME_NONNULL_END
