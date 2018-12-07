//
//  BRWindowViewController.m
//  BalaenicepsRexDemo
//
//  Created by 毕博洋 on 2018/12/5.
//  Copyright © 2018 毕博洋. All rights reserved.
//

#import "BRWindowViewController.h"
#import "BalaenicepsRexManager.h"
#import "UIView+BRLayout.h"
#import "BRNavView.h"
#import "BRPluginCell.h"

@interface BRWindowViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *BRCollectionView;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@end

@implementation BRWindowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];

    [self setupCollectionView];
    
}

- (void)setupCollectionView {
    
    BRNavView *navView = [[BRNavView alloc]init];
    navView.frame = CGRectMake(0, 0, BRScreenWidth, 100);
    
    __weak __typeof(self)weakSelf = self;
    navView.backBlock = ^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (strongSelf.backBlock) {
            strongSelf.backBlock();
            [strongSelf dismissViewControllerAnimated:YES completion:nil];
        }
    };
    
    [self.view addSubview:navView];
        
    self.sourceArray = [BalaenicepsRexManager shareBalaenicepsRex].allPluginArray;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 20.0f;
    flowLayout.minimumInteritemSpacing = 5.0f;
    
    _BRCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0.0f, 100, self.view.width, self.view.height - 100) collectionViewLayout:flowLayout];
    _BRCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_BRCollectionView];
    
    [_BRCollectionView registerClass:[BRPluginCell class] forCellWithReuseIdentifier:@"BRPluginCell"];
    
    _BRCollectionView.delegate = self;
    _BRCollectionView.dataSource = self;
    
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BRPluginCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BRPluginCell" forIndexPath:indexPath];
    
    if (!cell){
        cell = [[BRPluginCell alloc]init];
    }
    cell.backgroundColor = [UIColor redColor];
    NSDictionary *data= _sourceArray[indexPath.row];
    NSArray *pluginArray = [data objectForKey:@"pluginDescArray"];
    [cell setTitleWith:pluginArray[0]];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.width / 4, 60.0f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.view.width, 40.0f);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(self.view.width, 10.0f);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _sourceArray.count;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //再跳转到新的设置页面
//    NSDictionary *data= _dataArray[indexPath.section];
//    NSArray *pluginArray = [data objectForKey:@"pluginArray"];
//    NSDictionary *itemInfo = pluginArray[indexPath.row];
//    NSString *pluginName = itemInfo[@"pluginName"];
//
//    if(pluginName)
//    {
//
//        NSLog(@">>>>>%@",pluginName);
//
//        Class pluginClass = NSClassFromString(pluginName);
//
//        NSLog(@">>>>>%@",pluginClass);
//
//        id<DoraemonPluginProtocol> plugin = [[pluginClass alloc] init];
//
//        NSLog(@">>>>>%@",plugin);
//
//        [plugin pluginDidLoad];
//    }
}








- (NSMutableArray *)sourceArray {
    if (!_sourceArray)
    {
        _sourceArray = [NSMutableArray array];
    }
    return _sourceArray;
}




@end
