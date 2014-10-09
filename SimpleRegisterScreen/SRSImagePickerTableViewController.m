//
//  SRSImagePickerTableViewController.m
//  
//
//  Created by A on 10/8/14.
//
//

#import "SRSImagePickerTableViewController.h"

@interface SRSImagePickerTableViewController ()

@end

@implementation SRSImagePickerTableViewController {
    void (^completionBlock)(UIImage*);
    void (^cancelBlock)();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch ([indexPath indexAtPosition:1]) {
        case 0:
            //Take Photo
            [self selectImageWithPickerControllerForSource:UIImagePickerControllerSourceTypeCamera];
            break;
        case 1:
            //Choose Photo
            [self selectImageWithPickerControllerForSource:UIImagePickerControllerSourceTypePhotoLibrary];
            break;
        case 2:
            //Remove Photo
            if(completionBlock) {
                completionBlock(nil);
                if(cancelBlock) {
                    cancelBlock();
                }
            }
            break;
        case 3:
            //Cancel
            if(cancelBlock != nil) {
                cancelBlock();
            }
            break;
        default:
            break;
    }
}

-(void)selectImageWithPickerControllerForSource:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = sourceType;
    picker.allowsEditing = YES;
    [picker setModalInPopover:YES];
    picker.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self.navigationController setModalInPopover:YES];
    [self.navigationController presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if(cancelBlock) {
        cancelBlock();
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if(completionBlock) {
        completionBlock([info objectForKey:UIImagePickerControllerEditedImage]);
        if(cancelBlock) {
            cancelBlock();
        }
    }
}

-(void)setCompletionBlock:(void (^)(UIImage *))block {
    completionBlock = block;
}

-(void)setCancelBlock:(void (^)())block {
    cancelBlock = block;
}

-(CGSize)preferredContentSize {
    return CGSizeMake(300, 176);
}
@end
