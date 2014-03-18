//
//  CCTaskDetailsViewController.h
//  Over Due Task List
//
//  Created by Raymond Louie on 3/17/14.
//  Copyright (c) 2014 Raymond Louie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTask.h"
#import "CCEditTaskViewController.h"

@protocol CCTaskDetailsViewControllerDelegate <NSObject>

@required

-(void)didSave;

@end

@interface CCTaskDetailsViewController : UIViewController <CCEditTaskViewControllerDelegate>

@property (weak, nonatomic) id <CCTaskDetailsViewControllerDelegate> delegate;

@property (strong, nonatomic) CCTask *task;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailsLabel;

- (IBAction)editButtonPressed:(UIBarButtonItem *)sender;

@end
