//
//  CCEditTaskViewController.h
//  Over Due Task List
//
//  Created by Raymond Louie on 3/17/14.
//  Copyright (c) 2014 Raymond Louie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTask.h"

@protocol CCEditTaskViewControllerDelegate <NSObject>

@required

-(void)didSave;

@end

@interface CCEditTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) id <CCEditTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) CCTask *task;

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextView *detailsTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender;

@end
