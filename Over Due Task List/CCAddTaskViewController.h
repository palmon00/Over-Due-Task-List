//
//  CCAddTaskViewController.h
//  Over Due Task List
//
//  Created by Raymond Louie on 3/17/14.
//  Copyright (c) 2014 Raymond Louie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTask.h"

@protocol CCAddTaskViewControllerDelegate <NSObject>

@required
-(void)didCancel;
-(void)didAddTask:(CCTask *)task;

@end

@interface CCAddTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) id <CCAddTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextView *detailsTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)cancelButtonPressed:(UIButton *)sender;
- (IBAction)addButtonPressed:(UIButton *)sender;

@end
