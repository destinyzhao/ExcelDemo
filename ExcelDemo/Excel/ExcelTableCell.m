//
//  ExcelTableCell.m
//  ExcelDemo
//
//  Created by Destiny on 2021/5/27.
//

#import "ExcelTableCell.h"
#import "Excel.h"
#import "ExcelCollectionCell.h"
#import "ExcelModel.h"

@interface ExcelTableCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation ExcelTableCell

- (UICollectionView *)excelRowCollectionView{
    if(!_excelRowCollectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat edge = 0.f;
        layout.itemSize = CGSizeMake(rowWidth, rowHeight);
        layout.minimumLineSpacing = edge;
        layout.minimumInteritemSpacing = edge;
        layout.sectionInset = UIEdgeInsetsMake(edge, edge, edge, edge);

        _excelRowCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
            [_excelRowCollectionView registerClass:[ExcelCollectionCell class] forCellWithReuseIdentifier:@"cell"];
        _excelRowCollectionView.backgroundColor = [UIColor orangeColor];
        _excelRowCollectionView.showsHorizontalScrollIndicator = NO;
        _excelRowCollectionView.delegate = self;
        _excelRowCollectionView.dataSource = self;
    }
    return _excelRowCollectionView;;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.leftHeaderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, rowWidth, rowHeight)];
        self.leftHeaderLabel.font = [UIFont systemFontOfSize:12.f];
        self.leftHeaderLabel.textAlignment = NSTextAlignmentCenter;
        self.leftHeaderLabel.layer.borderWidth = 0.5;
        self.leftHeaderLabel.layer.borderColor = [UIColor blackColor].CGColor;
        self.leftHeaderLabel.backgroundColor = leftHeaderColor;
        [self.contentView addSubview:self.leftHeaderLabel];
        
        self.excelRowCollectionView.frame = CGRectMake(rowWidth, 0, self.contentView.frame.size.width - rowWidth, rowHeight);
        [self.contentView addSubview:self.excelRowCollectionView];
    }
    return self;
}

- (void)setRow:(NSInteger)row{
    _row = row;
    self.leftHeaderLabel.text = [NSString stringWithFormat:@"左头row-%ld",self.row];
    [self.excelRowCollectionView reloadData];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.leftHeaderLabel.frame = CGRectMake(0, 0, rowWidth, rowHeight);
    self.excelRowCollectionView.frame = CGRectMake(rowWidth, 0, self.contentView.frame.size.width - rowWidth, rowHeight);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ExcelCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.layer.borderWidth = 0.5;
    cell.layer.borderColor = [UIColor blackColor].CGColor;
    cell.backgroundColor = [UIColor whiteColor];
    //表格类型（可以根据index.row去dataSource数据修改值）
    if(self.rowData.count > indexPath.row){
        ExcelModel *model = [self.rowData objectAtIndex:indexPath.row];
        cell.excelLabel.text = model.name;
    }
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.columnNumber;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
