//
//  CCTasksViewController.h
//  Over Due Task List
//
//  Created by Raymond Louie on 3/17/14.
//  Copyright (c) 2014 Raymond Louie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCAddTaskViewController.h"
#import "CCTaskDetailsViewController.h"

@interface CCTasksViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CCAddTaskViewControllerDelegate, CCTaskDetailsViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *taskObjects;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)reorderButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)addTaskButtonPressed:(UIBarButtonItem *)sender;

@end
