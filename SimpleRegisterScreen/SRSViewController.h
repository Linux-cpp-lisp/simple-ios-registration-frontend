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

@interface SRSViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *fields;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *fieldValidationLabels;
- (IBAction)submit:(id)sender;
- (IBAction)avatarImageTapped:(id)sender;

@end
