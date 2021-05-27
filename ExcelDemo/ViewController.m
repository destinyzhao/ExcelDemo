//
//  ViewController.m
//  ExcelDemo
//
//  Created by Destiny on 2021/5/27.
//

#import "ViewController.h"
#import "ExcelView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupExcel];
}

- (void)setupExcel
{
    ExcelView *excelView = [[ExcelView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-100)];
    excelView.backgroundColor = [UIColor lightGrayColor];
    excelView.rowNumber = 20;//行
    excelView.columnNumber = 20;//列
    [self.view addSubview:excelView];
}


@end
