//
//  ExcelView.m
//  ExcelDemo
//
//  Created by Destiny on 2021/5/27.
//

#import "ExcelView.h"
#import "Excel.h"
#import "ExcelTableCell.h"
#import "ExcelCollectionCell.h"

@interface ExcelView ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic) UIView *topHeaderView;
@property(strong,nonatomic) UICollectionView *topExcelCollectionView;
@property(strong,nonatomic) UITableView *excelTableView;
@property (assign, nonatomic) CGPoint cacheContentOffset;

@end

@implementation ExcelView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (UICollectionView *)topExcelCollectionView{
    if(!_topExcelCollectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGFloat edge = 0.f;
        layout.itemSize = CGSizeMake(rowWidth, rowHeight);
        layout.minimumLineSpacing = edge;
        layout.minimumInteritemSpacing = edge;
        layout.sectionInset = UIEdgeInsetsMake(edge, edge, edge, edge);

        _topExcelCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [_topExcelCollectionView registerClass:[ExcelCollectionCell class] forCellWithReuseIdentifier:@"cell"];
        _topExcelCollectionView.backgroundColor = topHeaderColor;
        _topExcelCollectionView.showsHorizontalScrollIndicator = NO;
        _topExcelCollectionView.delegate = self;
        _topExcelCollectionView.dataSource = self;
    }
    return _topExcelCollectionView;
}

- (UITableView *)excelTableView{
    if(!_excelTableView){
        _excelTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _excelTableView.delegate = self;
        _excelTableView.dataSource = self;
        _excelTableView.backgroundColor = [UIColor whiteColor];
        [self.excelTableView registerClass:[ExcelTableCell class] forCellReuseIdentifier:@"ExcelTableViewCell"];
    }
    return _excelTableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.borderWidth = 0.5;
        
        [self initTopHeaderView];
        [self initExcelTableView];
    }
    return self;
}

//顶部headerView
-(void)initTopHeaderView{
    
    self.topHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, rowHeight)];
    self.topHeaderView.backgroundColor = topHeaderColor;
    [self addSubview:self.topHeaderView];
    
    UILabel *firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, rowWidth, rowHeight)];
    firstLabel.text = @"左上头";
    firstLabel.font = [UIFont systemFontOfSize:12.f];
    firstLabel.textAlignment = NSTextAlignmentCenter;
    firstLabel.layer.borderWidth = 0.5;
    [self.topHeaderView addSubview:firstLabel];
    
    self.topExcelCollectionView.frame = CGRectMake(rowWidth, 0, self.topHeaderView.frame.size.width - rowWidth, rowHeight);
    [self.topHeaderView addSubview:self.topExcelCollectionView];

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ExcelCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.layer.borderWidth = 0.5;
    cell.backgroundColor = [UIColor clearColor];
    cell.excelLabel.text = [NSString stringWithFormat:@"顶部列-%ld",indexPath.row];
    return cell;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.delegate excelNumberOfColumns];
}

-(void)initExcelTableView{
    self.excelTableView.frame = CGRectMake(0, rowHeight, self.frame.size.width, self.frame.size.height);
    [self addSubview:self.excelTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.delegate excelNumberOfRows];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndetifier = @"ExcelTableViewCell";
   
    ExcelTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier forIndexPath:indexPath];
    cell.columnNumber = [self.delegate excelNumberOfColumns];
    cell.row = indexPath.row;
    if([self.delegate excelDataSource].count > indexPath.row){
        NSMutableArray *rowData = [[self.delegate excelDataSource] objectAtIndex:indexPath.row];
        cell.rowData = rowData;
    }
    cell.excelRowCollectionView.delegate = self;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return rowHeight;
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        if (scrollView.contentOffset.y != 0) {
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
        }
        NSLog(@"scroll %f",scrollView.contentOffset.x);
        
        self.topExcelCollectionView.contentOffset = scrollView.contentOffset;
        
        for (ExcelTableCell* cell in self.excelTableView.visibleCells) {
            for (UIView *view in cell.contentView.subviews) {
                if ([view isKindOfClass:[UICollectionView class]]) {
                    UICollectionView *collectionView = (UICollectionView *)view;
                    collectionView.contentOffset = scrollView.contentOffset;
                    self.cacheContentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y);
                }
            }
        }
        
    }else{
        self.topExcelCollectionView.contentOffset = self.cacheContentOffset;
        
        for (ExcelTableCell* cell in self.excelTableView.visibleCells) {
            for (UIView *view in cell.contentView.subviews) {
                if ([view isKindOfClass:[UICollectionView class]]) {
                    UICollectionView *collectionView = (UICollectionView *)view;
                    collectionView.contentOffset = self.cacheContentOffset;
                }
            }
            
        }
    }
    
}

@end
