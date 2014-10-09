//
//  SRSImagePickerTableViewController.h
//  
//
//  Created by A on 10/8/14.
//
//

#import <UIKit/UIKit.h>

@interface SRSImagePickerTableViewController : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableViewCell *removePhotoCell;
-(void)setCompletionBlock:(void(^)(UIImage*))block;
-(void)setCancelBlock:(void(^)())block;
@end
