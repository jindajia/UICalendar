//
//  CalendarViewController.m
//  UiCalendar
//
//  Created by 贾金达 on 2020/7/17.
//  Copyright © 2020 jiajinda. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property UICollectionView *collectionViewCalendar;
@property UITableView *tableViewCalendar;
@end

@implementation CalendarViewController
- (void)viewDidLoad;{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    self.title = @"日历";
    [self createCallendarCollectionView];
    self.navigationItem.title = @"2020年7月";
    
}

-(void)createCallendarCollectionView{
    NSLog(@"This is feature1");
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //flowLayout的属性minimumLineSpacing  minimumInteritemSpacing  itemSize
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 0.5;
    //flowLayout.itemSize = CGSizeMake((self.view.frame.size.width-10)/2, (self.view.frame.size.height-10)/2);
    CGRect cg_size = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+100);
    self.collectionViewCalendar = [[UICollectionView alloc] initWithFrame:cg_size collectionViewLayout:flowLayout];
    //使用CollectionView之前需要进行注册！！！
    [self.collectionViewCalendar registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"calendarCollectionView"];
    //使用CollectionView之前需要进行注册！！！
    self.collectionViewCalendar.delegate = self;
    self.collectionViewCalendar.dataSource = self;
    self.collectionViewCalendar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionViewCalendar];
}
#pragma UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 36;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell *cell = [self.collectionViewCalendar dequeueReusableCellWithReuseIdentifier:@"calendarCollectionView" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    if(indexPath.item == 0){
        UILabel *label = [[UILabel alloc] init];
        label.text = @"   日      一      二      三       四      五      六";
        label.font = [UIFont boldSystemFontOfSize:23];
        label.backgroundColor = [UIColor whiteColor];
        label.tintColor = [UIColor blackColor];
        label.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
        [cell addSubview:label];
    }
    //如果是休息日
    if(indexPath.item>=4&&indexPath.item<=34&&(indexPath.item%7 == 0||indexPath.item%7 == 1)){
        NSInteger day = indexPath.item-3;
        NSString *dayString;
        //判断日期是个位数还是双位数
        if(indexPath.item<=12){
            dayString = [NSString stringWithFormat:@" %ld",day];
        }
        else{
            dayString = [NSString stringWithFormat:@"%ld",day];
        }
       
        UILabel *label = [[UILabel alloc] init];
        label.text = dayString;
        label.font = [UIFont systemFontOfSize:25];
        label.textColor = [UIColor redColor];
        label.frame = CGRectMake(15, 0, (self.view.frame.size.width-5)/7, (self.view.frame.size.width-5)/7);
        [cell addSubview:label];
        
        UILabel *label2 = [[UILabel alloc] init];
        label2.text = @"休";
        label2.font = [UIFont systemFontOfSize:15];
        label2.textColor = [UIColor blackColor];
        label2.frame = CGRectMake(22, 35, 90, 30);
        [cell addSubview:label2];
    }
    //如果不是休息日
    else if(indexPath.item>=4&&indexPath.item<=34){
        NSInteger day = indexPath.item-3;
        NSString *dayString;
        if(indexPath.item<=12){
            dayString = [NSString stringWithFormat:@" %ld",(long)day];
        }
        else{
            dayString = dayString = [NSString stringWithFormat:@"%ld",(long)day];
        }
        UILabel *label = [[UILabel alloc] init];
        label.text = dayString;
        label.font = [UIFont systemFontOfSize:25];
        label.tintColor = [UIColor blackColor];
        label.frame = CGRectMake(15, 0, (self.view.frame.size.width-5)/7, (self.view.frame.size.width-5)/7);
        [cell addSubview:label];
        UILabel *label2 = [[UILabel alloc] init];
        label2.text = @" 班";
        label2.font = [UIFont systemFontOfSize:15];
        label2.textColor = [UIColor blackColor];
        label2.frame = CGRectMake(18, 35, 90, 30);
        [cell addSubview:label2];
    }
    else{
        //cell.backgroundColor = [UIColor blueColor];
    }
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.item == 0){
        return CGSizeMake(self.view.frame.size.width, 40);
    }
    else if(indexPath.item<=34){
        return CGSizeMake((self.view.frame.size.width-5)/7, (self.view.frame.size.width-5)/7+4);
    }
    else{
        return CGSizeMake(self.view.frame.size.width, 400);
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%ld",indexPath.item);
    NSLog(@"%f",self.view.frame.size.width);
    NSLog(@"%f",self.view.frame.size.height);
    UIViewController *nextView = [[UIViewController alloc] init];
    nextView.view.backgroundColor = [UIColor whiteColor];
    UILabel *nextPageLabe = [[UILabel alloc] init];
    nextPageLabe.font = [UIFont systemFontOfSize:25];
    nextPageLabe.text = [NSString stringWithFormat:@"7月%ld日",indexPath.item-3];
    nextPageLabe.frame = CGRectMake(100, 100, 500, 100);
    [nextView.view addSubview:nextPageLabe];
    [self.navigationController pushViewController:nextView animated:YES];
}
#pragma UICollectionViewDelegate
@end
