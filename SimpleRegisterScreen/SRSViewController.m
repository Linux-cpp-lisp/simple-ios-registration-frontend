//
//  SRSViewController.m
//  SimpleRegisterScreen
//
//  Created by A on 9/3/14.
//  Copyright (c) 2014 Toadbytes. All rights reserved.
//

#import "SRSViewController.h"

#import <AFNetworking/AFHTTPRequestOperationManager.h>

@interface SRSViewController ()

@end

@implementation SRSViewController {
    UIImage* avatarImage;
}

#pragma mark UIViewController Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.containerView.layer.borderWidth = 0.8;
    self.containerView.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
    avatarImage = nil;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark IBActions

- (IBAction)submit:(id)sender {
    if([self validate]) {
        NSLog(@"Great!");
    }
}

- (IBAction)avatarImageTapped:(id)sender {
    UINavigationController* pickerNav = [self.storyboard instantiateViewControllerWithIdentifier:@"imagePicker"];
    SRSImagePickerTableViewController* picker = [[pickerNav viewControllers] objectAtIndex:0];
    if(avatarImage == nil) {
        [picker loadView];
        picker.removePhotoCell.userInteractionEnabled = NO;
        picker.removePhotoCell.textLabel.textColor = [UIColor lightGrayColor];
    }
    [picker setCompletionBlock:^(UIImage* image) {
        avatarImage = image;
        if(avatarImage != nil) {
            self.avatarImageView.image = avatarImage;
        }
        else {
            self.avatarImageView.image = [UIImage imageNamed:@"Default Avatar"];
        }
    }];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIPopoverController* popover = [[UIPopoverController alloc] initWithContentViewController:pickerNav];
        [popover presentPopoverFromRect:self.avatarImageView.frame inView:self.avatarImageView.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        [picker setCancelBlock:^{
            [popover dismissPopoverAnimated:YES];
        }];
    }
    else {
        [self presentViewController:pickerNav animated:YES completion:nil];
        [picker setCancelBlock:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}

#pragma mark UITextFieldDelegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField.tag == self.fields.count - 1) {
        [self submit:self];
    }
    else {
        [[self formFieldForTag:textField.tag + 1] becomeFirstResponder];
    }
    return NO;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if(![self validateTextField:textField forRegexp:[[self validationRegexes] objectForKey:[NSNumber numberWithLong:textField.tag]]]) {
        [self showValidationLabelForTag:textField.tag];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if([self validateTextField:textField forRegexp:[[self validationRegexes] objectForKey:[NSNumber numberWithLong:textField.tag]]]) {
        [self hideValidationLabelForTag:textField.tag];
    }
    return YES;
}

#pragma mark Validation

-(UITextField*)formFieldForTag:(long)tag {
    return [self.fields objectAtIndex:[self.fields indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return ((UIView*)obj).tag == tag;
    }]];
}

-(UILabel*)formValidationLabelForTag:(long)tag {
    return [self.fieldValidationLabels objectAtIndex:[self.fieldValidationLabels indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return ((UIView*)obj).tag == tag;
    }]];
}

-(void)showValidationLabelForTag:(long)tag {
    [UIView animateWithDuration:0.1 animations:^{
        [self formValidationLabelForTag:tag].alpha = 1;
    }];
}

-(void)hideValidationLabelForTag:(long)tag {
    [UIView animateWithDuration:0.1 animations:^{
        [self formValidationLabelForTag:tag].alpha = 0;
    }];
}

-(BOOL)validate {
    NSMutableArray* results = [NSMutableArray array];
    for(NSNumber* key in [self validationRegexes]) {
        BOOL valid = [self validateTextField:[self formFieldForTag:key.longValue] forRegexp:[[self validationRegexes] objectForKey:key]];
        if(!valid) {
            [self showValidationLabelForTag:key.longValue];
        }
    }
    return ![results containsObject:@NO];
}

-(NSDictionary*)validationRegexes {
    NSString *emailRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    return @{
             @0 : @"^.{1,30}$",
             @1 : emailRegex,
             @2 : @"^.{6,}$"
             };
}

-(BOOL)validateTextField:(UITextField*)field forRegexp:(NSString*)regexp {
    NSPredicate* test = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", regexp];
    if([test evaluateWithObject:field.text]) {
        return YES;
    }
    else {
        return NO;
    }
}

#pragma mark Sending Request

-(NSDictionary*)JSONFromInput {
    return @{@"username": self.usernameField.text,
             @"email": self.emailField.text,
             @"password": self.passwordField.text};
}

-(void)sendRequest {
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:[NSString stringWithFormat:@"%@register/", SRSUserSeriviceBaseURL]
       parameters:[self JSONFromInput]
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
          }];
}

#pragma mark Other

-(void)clearFields {
    self.usernameField.text = @"";
    self.emailField.text = @"";
    self.passwordField.text = @"";
}
@end
