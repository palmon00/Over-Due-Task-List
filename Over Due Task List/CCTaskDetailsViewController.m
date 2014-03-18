//
//  CCTaskDetailsViewController.m
//  Over Due Task List
//
//  Created by Raymond Louie on 3/17/14.
//  Copyright (c) 2014 Raymond Louie. All rights reserved.
//

#import "CCTaskDetailsViewController.h"

@interface CCTaskDetailsViewController ()

@end

@implementation CCTaskDetailsViewController

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

    // initialize labels
    [self updateLabels];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([sender isKindOfClass:[UIBarButtonItem class]] && [segue.destinationViewController isKindOfClass:[CCEditTaskViewController class]])
    {
        CCEditTaskViewController *editTaskVC = segue.destinationViewController;
        editTaskVC.task = self.task;
        editTaskVC.delegate = self;
    }
}

- (IBAction)editButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toEditTask" sender:sender];
}

#pragma mark - CCEditTaskViewControlerDelegate

-(void)didSave
{
    NSLog(@"didSave CCEditTaskVC");
    [self updateLabels];
    NSLog(@"Pop Nav");
    [[self navigationController] popViewControllerAnimated:YES];
    NSLog(@"Nav Popped");
    [self.delegate didSave];
    NSLog(@"Delegate called");
}

#pragma mark - Helper Methods
-(void)updateLabels
{
    self.nameLabel.text = self.task.title;
    self.detailsLabel.text = self.task.details;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy MM dd"];
    self.dateLabel.text = [formatter stringFromDate:self.task.date];
}

@end
