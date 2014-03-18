//
//  CCTasksViewController.m
//  Over Due Task List
//
//  Created by Raymond Louie on 3/17/14.
//  Copyright (c) 2014 Raymond Louie. All rights reserved.
//

#import "CCTasksViewController.h"
#import "CCTaskDetailsViewController.h"

@interface CCTasksViewController ()

@end

@implementation CCTasksViewController

#pragma mark - Lazy Instantiations

- (NSMutableArray *)taskObjects
{
    if (!_taskObjects) {
        _taskObjects = [[NSMutableArray alloc] init];
    }
    return _taskObjects;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // load task objects
    [self loadTaskObjects];
    
    // set self as tableView delegate and data source
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UIBarButtonItem class]] && [segue.destinationViewController isKindOfClass:[CCAddTaskViewController class]]) {
        // set delegate to self
        CCAddTaskViewController *addTaskVC = segue.destinationViewController;
        addTaskVC.delegate = self;
    }
    
    if ([sender isKindOfClass:[NSIndexPath class]] && [segue.destinationViewController isKindOfClass:[CCTaskDetailsViewController class]])
    {
        // pass task to Task Details VC
        NSIndexPath *path = sender;
        CCTaskDetailsViewController *taskDetailsVC = segue.destinationViewController;
        taskDetailsVC.task = self.taskObjects[path.row];
        taskDetailsVC.delegate = self;
    }
}

- (IBAction)reorderButtonPressed:(UIBarButtonItem *)sender {
    // toggle editing mode
    if (self.tableView.editing) [self.tableView setEditing:NO animated:YES]; else [self.tableView setEditing:YES animated:YES];
}

- (IBAction)addTaskButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toAddTask" sender:sender];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // one section
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // one row per task
    return [self.taskObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // dequeue a cell
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // label is task title
    CCTask *task = self.taskObjects[indexPath.row];
    cell.textLabel.text = task.title;
    
    // label is date due
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy MM dd"];
    cell.detailTextLabel.text = [formatter stringFromDate:task.date];
    
    // color cell yellow if date is greater than today, red otherwise
    if ([self isDateGreaterThanDate:task.date and:[NSDate date]]) cell.backgroundColor = [UIColor yellowColor];
    else cell.backgroundColor = [UIColor redColor];
    
    // completed tasks are green
    if (task.completion) {
        cell.backgroundColor = [UIColor greenColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // delete task from taskObjects
    CCTask *task = self.taskObjects[indexPath.row];
    [self.taskObjects removeObject:task];
    
    // overwrite savedTasks
    [self saveTaskObjects];
    
    // can now delete cells
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    [tableView reloadData];
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // move objects in taskObjects
    CCTask *task = self.taskObjects[sourceIndexPath.row];
    [self.taskObjects removeObjectAtIndex:sourceIndexPath.row];
    [self.taskObjects insertObject:task atIndex:destinationIndexPath.row];
    
    // overwrite savedTasks
    [self saveTaskObjects];
    
    // update tableView
    [tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // all rows are editable
    return YES;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // all rows are movable
    return YES;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // update completion of selected task
    CCTask *task = self.taskObjects[indexPath.row];
    task.completion = !task.completion;
    
    // save taskObjects
    [self saveTaskObjects];
    
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toTaskDetails" sender:indexPath];
}

#pragma mark - CCAddTaskViewControllerDelegate

-(void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didAddTask:(CCTask *)task
{
    // add task to taskObjects
    [self.taskObjects addObject:task];
    
    // save to NSUserDefaults
    [self saveTaskObjects];
    
    // dismiss add VC
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // update table view
    [self.tableView reloadData];
}

#pragma mark - CCTaskDetailsViewController

-(void)didSave
{    
    // save to NSUserDefaults
    [self saveTaskObjects];
    
    // update table view
    [self.tableView reloadData];
}

#pragma mark - Helper Methods
- (NSDictionary *)taskObjectAsAPropertyList:(CCTask *)taskObject
{
    // need to ensure no nils get returned
    NSDictionary *propertyList = @{TITLE:taskObject.title ? taskObject.title : @"",
                                   DETAILS:taskObject.details ? taskObject.details : @"",
                                   DATE:taskObject.date ? taskObject.date : [[NSDate alloc] init],
                                   COMPLETION:@(taskObject.completion)};
    return propertyList;
}

- (CCTask *)propertyListAsTaskObject:(NSDictionary *)dictionary
{
    return [[CCTask alloc] initWithData:dictionary];
}

- (BOOL)isDateGreaterThanDate:(NSDate *)date and:(NSDate *)toDate
{
    NSTimeInterval timeInterval = [date timeIntervalSinceReferenceDate];
    NSTimeInterval toTimeInterval = [toDate timeIntervalSinceReferenceDate];
    return (timeInterval > toTimeInterval);
}

//- (void)updateCompletionOfTask:(CCTask *)task forIndexPath:(NSIndexPath *)indexPath
//{
//    // remove task from savedTasks
//    NSMutableArray *savedTasks = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASKS] mutableCopy];
//    int taskIndex = [savedTasks indexOfObject:[self taskObjectAsAPropertyList:task]];
//    [savedTasks removeObject:[self taskObjectAsAPropertyList:task]];
//    
//    // update task completion
//    task.completion = !task.completion;
//    
//    // resave task
//    [savedTasks insertObject:[self taskObjectAsAPropertyList:task] atIndex:taskIndex];
//    [[NSUserDefaults standardUserDefaults] setObject:savedTasks forKey:TASKS];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}

- (void)saveTaskObjects
{
    // generate array of dictionaries
    NSMutableArray *objectsAsPropertyLists = [[NSMutableArray alloc] init];
    for (CCTask *task in self.taskObjects) {
        [objectsAsPropertyLists addObject:[self taskObjectAsAPropertyList:task]];
    }
    
    // save array to NSUserDefaults
    [[NSUserDefaults standardUserDefaults] setObject:objectsAsPropertyLists forKey:TASKS];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)loadTaskObjects
{
    // read saved tasks
    NSArray *savedTasks = [[NSUserDefaults standardUserDefaults] arrayForKey:TASKS];
    
    // ensure initialized tasks
    if (!savedTasks) {
        savedTasks = [[NSArray alloc] init];
    }
    
    // load tasks into taskObjects
    for (NSDictionary *dictionary in savedTasks) {
        [self.taskObjects addObject:[self propertyListAsTaskObject:dictionary]];
    }
}

@end