//
//  ExcelTableCell.h
//  ExcelDemo
//
//  Created by Destiny on 2021/5/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExcelTableCell : UITableViewCell

@property(nonatomic,assign) NSInteger row;
@property(nonatomic,assign) NSInteger columnNumber;
@property(nonatomic,strong) UILabel *leftHeaderLabel;
@property(nonatomic,strong) NSMutableArray *rowData;
@property(strong,nonatomic) UICollectionView *excelRowCollectionView;

@end

NS_ASSUME_NONNULL_END
