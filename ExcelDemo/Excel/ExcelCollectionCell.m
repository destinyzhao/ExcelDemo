//
//  ExcelCollectionCell.m
//  ExcelDemo
//
//  Created by Destiny on 2021/5/27.
//

#import "ExcelCollectionCell.h"

@implementation ExcelCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.excelLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.excelLabel.text = @"单元格";
        self.excelLabel.font = [UIFont systemFontOfSize:12.f];
        self.excelLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.excelLabel];
        
    }
    
    return self;

}

@end
