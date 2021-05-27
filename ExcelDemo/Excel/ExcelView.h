//
//  ExcelView.h
//  ExcelDemo
//
//  Created by Destiny on 2021/5/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 协议定义
@protocol ExcelViewDelegate <NSObject>

@required
- (NSInteger)excelNumberOfRows;
- (NSInteger)excelNumberOfColumns;
- (NSMutableArray *)excelDataSource;

@end

@interface ExcelView : UIView

@property(nonatomic,strong) NSDictionary *dataSource;//数据源（具体使用根据你的数据结构来）
@property (nonatomic,weak)  id<ExcelViewDelegate> delegate; ;

@end

NS_ASSUME_NONNULL_END
