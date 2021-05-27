//
//  ViewController.m
//  ExcelDemo
//
//  Created by Destiny on 2021/5/27.
//

#import "ViewController.h"
#import "ExcelView.h"
#import "ExcelModel.h"

@interface ViewController ()<ExcelViewDelegate>

@property (strong, nonatomic) NSMutableArray *rowArray;

@end

@implementation ViewController

- (NSMutableArray *)rowArray{
    if(!_rowArray){
        _rowArray = [NSMutableArray array];
    }
    return _rowArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTestData];
    [self setupExcel];
}

- (void)loadTestData{
    for (int i= 0; i< 40; i++) {
        NSMutableArray *columnArray = [NSMutableArray array];
        for (int j = 0; j< 10; j++) {
            ExcelModel *model = [ExcelModel new];
            model.name = [NSString stringWithFormat:@"%d行%d列",i,j];
            [columnArray addObject:model];
        }
        [self.rowArray addObject:columnArray];
    }
}

- (void)setupExcel
{
    ExcelView *excelView = [[ExcelView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-100)];
    excelView.backgroundColor = [UIColor lightGrayColor];
    excelView.delegate = self;
    [self.view addSubview:excelView];
}

- (NSInteger)excelNumberOfRows{
    return self.rowArray.count;
}

- (NSInteger)excelNumberOfColumns{
    NSMutableArray *columnsArray = [self.rowArray objectAtIndex:0];
    return columnsArray.count;
}

- (NSMutableArray *)excelDataSource{
    return self.rowArray;
}


@end
