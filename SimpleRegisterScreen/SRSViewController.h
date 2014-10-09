//
//  SRSViewController.h
//  SimpleRegisterScreen
//
//  Created by A on 9/3/14.
//  Copyright (c) 2014 Toadbytes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRSImagePickerTableViewController.h"

#define SRSUserSeriviceBaseURL @"http://ec2-54-164-170-108.compute-1.amazonaws.com/users/"
#define SRSMessageBarColorError [UIColor colorWithRed:255/255.0f green:102/255.0f blue:102/255.0f alpha:1.0f]
#define SRSMessageBarColorSuccess [UIColor colorWithRed:0/255.0f green:127/255.0f blue:0/255.0f alpha:1.0f]

@interface SRSViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageContainerHeightConstraint;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *fields;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *fieldValidationLabels;
- (IBAction)submit:(id)sender;
- (IBAction)avatarImageTapped:(id)sender;

@end
