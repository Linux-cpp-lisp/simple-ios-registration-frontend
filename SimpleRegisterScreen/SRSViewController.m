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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.containerView.layer.borderWidth = 0.8;
    self.containerView.layer.borderColor = [UIColor colorWithWhite:0.6 alpha:1].CGColor;
	// Do any additional setup after loading the view, typically from a nib.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField.tag == self.fields.count - 1) {
        [self submit:self];
    }
    else {
        [[self.fields objectAtIndex:textField.tag + 1] becomeFirstResponder];
    }
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submit:(id)sender {
}

- (IBAction)avatarImageTapped:(id)sender {
}
@end
