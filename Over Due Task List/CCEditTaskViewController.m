//
//  CCEditTaskViewController.m
//  Over Due Task List
//
//  Created by Raymond Louie on 3/17/14.
//  Copyright (c) 2014 Raymond Louie. All rights reserved.
//

#import "CCEditTaskViewController.h"

@interface CCEditTaskViewController ()

@end

@implementation CCEditTaskViewController

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
    
    // initialize with the task data
    self.nameTextField.text = self.task.title;
    self.detailsTextView.text = self.task.details;
    [self.datePicker setDate:self.task.date animated:YES];
    
    // set self as delegates for text input
    self.nameTextField.delegate = self;
    self.detailsTextView.delegate = self;
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

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender
{
    // save data in fields to task
    self.task.title = self.nameTextField.text;
    self.task.details = self.detailsTextView.text;
    self.task.date = self.datePicker.date;
    [self.delegate didSave];
}

#pragma mark - UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    // close keyboard on return
    if ([text isEqualToString:@"\n"]) {
        [self.detailsTextView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.nameTextField resignFirstResponder];
    return YES;
}

@end
