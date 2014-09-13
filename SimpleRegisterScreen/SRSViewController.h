//
//  SRSViewController.h
//  SimpleRegisterScreen
//
//  Created by A on 9/3/14.
//  Copyright (c) 2014 Toadbytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRSViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *fields;
- (IBAction)submit:(id)sender;
- (IBAction)avatarImageTapped:(id)sender;

@end
