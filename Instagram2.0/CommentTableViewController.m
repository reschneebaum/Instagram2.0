//
//  CommentTableViewController.m
//  Instagram2.0
//
//  Created by Rachel Schneebaum on 8/14/15.
//  Copyright (c) 2015 Rachel Schneebaum. All rights reserved.
//

#import "CommentTableViewController.h"
#import "CommentCell.h"
#import "EnterCommentCell.h"

@implementation CommentTableViewController

-(void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UITableView data source methods
#pragma mark -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.photos.count) {
        EnterCommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:@"CommentCellID"];
        return commentCell;
    } else {
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EnterCommentCellID"];
        return cell;
    }
}

@end