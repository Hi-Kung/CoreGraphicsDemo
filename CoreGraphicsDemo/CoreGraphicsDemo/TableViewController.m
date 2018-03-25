//
//  TableViewController.m
//  CoreGraphicsDemo
//
//  Created by HK on 18/3/25.
//  Copyright © 2018年 HK. All rights reserved.
//

#import "TableViewController.h"
#import "CGModel.h"
#import "ViewController.h"

@interface TableViewController ()
@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Demos";
    
    self.data = [NSMutableArray arrayWithCapacity:7];
    NSArray *titles = @[@"CoreGraphics原始方法",@"CoreGraphics封装方法",@"UIKit方法",@"绘制文字",@"笑脸",@"抛物线",@"撒尿运动"];
    for (NSUInteger i = 0; i < titles.count; i++) {
        CGModel *model = [[CGModel alloc] init];
        model.title = titles[i];
        model.type = i;
        [self.data addObject:model];
    }

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    CGModel *model = self.data[indexPath.row];
    cell.textLabel.text = model.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CGModel *model = self.data[indexPath.row];
    ViewController *vc = [[ViewController alloc] init];
    vc.type = model.type;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
