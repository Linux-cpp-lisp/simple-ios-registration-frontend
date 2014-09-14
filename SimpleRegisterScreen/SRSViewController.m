//
//  SRSViewController.m
//  SimpleRegisterScreen
//
//  Created by A on 9/3/14.
//  Copyright (c) 2014 Toadbytes. All rights reserved.
//

#import "SRSViewController.h"

@interface SRSViewController ()

@end

@implementation SRSViewController

#pragma mark UIViewController Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.containerView.layer.borderWidth = 0.8;
    self.containerView.layer.borderColor = [UIColor colorWithWhite:0.6 alpha:1].CGColor;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark IBActions

- (IBAction)submit:(id)sender {
    if([self validate]) {
        NSLog(@"Great!");
    }
}

- (IBAction)avatarImageTapped:(id)sender {
}

#pragma mark UITextFieldDelegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField.tag == self.fields.count - 1) {
        [self submit:self];
    }
    else {
        [[self.fields objectAtIndex:textField.tag + 1] becomeFirstResponder];
    }
    return NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.backgroundColor = [UIColor clearColor];
}

#pragma mark Validation

-(BOOL)validate {
    NSString *emailRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    return [self validateTextField:self.usernameField forRegexp:@"^.+$"]
            & [self validateTextField:self.emailField forRegexp:emailRegex]
            & [self validateTextField:self.passwordField forRegexp:@"^.+$"];
}

-(BOOL)validateTextField:(UITextField*)field forRegexp:(NSString*)regexp {
    NSPredicate* test = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", regexp];
    if([test evaluateWithObject:field.text]) {
        return YES;
    }
    else {
        field.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
        return NO;
    }
}

#pragma mark Sending Request

-(void)sendRequest {
    
}
@end
