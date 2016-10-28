//
//  ListTableViewController.m
//  TestForPerformSelector
//
//  Created by dvt04 on 16/10/28.
//  Copyright © 2016年 suma. All rights reserved.
//

#import "ListTableViewController.h"
#import "ViewController.h"

@interface ListTableViewController ()

@end

@implementation ListTableViewController
{
    NSArray *_arrDataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLayoutAndInitData];
}

- (void)setupLayoutAndInitData {
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    _arrDataSource = @[@"performSelectorAfterDelay",@"performSelectorInBackground",@"performSelectorOnMainThread",@"performSelectorWithObject",@"performSelectorOnThread"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrDataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[_arrDataSource objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(delayMethod:)]) {
        switch (indexPath.row) {
            case 0:
            {
                // selector方法被添加到了队列最后，等调用此方法的函数执行完之后才执行selector方法
                [self performSelector:@selector(delayMethod:) withObject:nil afterDelay:1];
                break;
            }
            case 1:
            {
                // 直接在后台线程执行
                [self performSelectorInBackground:@selector(delayMethod:) withObject:nil];
                break;
            }
            case 2:
            {
                // 在主线程执行。当waitUntilDone参数为YES时，等selector方法执行完再执行后面的方法；为NO时，同afterDelay一样，等调用此方法的函数执行完之后，才执行方法
                [self performSelectorOnMainThread:@selector(delayMethod:) withObject:nil waitUntilDone:YES];
                break;
            }
            case 3:
            {
                [self performSelector:@selector(delayMethod:) withObject:nil];
//                // 执行延时方法
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
//                    if ([self respondsToSelector:@selector(delayMethod)]) {
//                        [self performSelector:@selector(delayMethod) withObject:nil];
//                    }
//                });
                break;
            }
            case 4:
            {
                [self performSelector:@selector(delayMethod:) onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES modes:@[NSRunLoopCommonModes]];
                break;
            }
            default:
                break;
        }
        [self testForPerformSelector];
    }
}

#pragma mark - CustomMethod
- (void)testForPerformSelector {
    NSString *curTime = [self getCurrentTime];
    NSLog(@"%@ 方法%s 开始", curTime, __FUNCTION__);
    sleep(5);
    NSLog(@"%@ 方法%s 结束", curTime, __FUNCTION__);
}

- (void)delayMethod:(id)obj {
    NSString *curTime = [self getCurrentTime];
    NSLog(@"%@ 方法%s 执行延迟方法", curTime,__FUNCTION__);
}

- (NSString *)getCurrentTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    NSString *strTime = [dateFormatter stringFromDate:[NSDate date]];
    return strTime;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
