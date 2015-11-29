//
//  HRPCreateProfile.m
//  harpy
//
//  Created by Kiara Robles on 11/19/15.
//  Copyright © 2015 teamFloppyDisk. All rights reserved.
//

#import "HRPCreateProfile.h"
#import "HRPParseNetworkService.h"
#import "UIViewController+PresentViewController.h"

@interface HRPSignupVC () <UIImagePickerControllerDelegate>

@property (nonatomic) UITextField *passwordNew;
@property (nonatomic) UITextField *passwordConfirm;
@property (nonatomic) UIButton *signup;
@property (nonatomic) BOOL spotifyPremium;
@property (strong, nonatomic) HRPParseNetworkService *parseService;
@property (strong, nonatomic) UIViewController *spotifySignupRedirect ;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;

@end

@implementation HRPSignupVC

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupInputView];
    [self.navigationController setNavigationBarHidden:YES]; // Carrys over from other VC's
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidEndEditingNotification object:self.passwordConfirm];
    
    self.parseService = [HRPParseNetworkService sharedService];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Custom Accessors

- (void)setupInputView
{
    
    UIImage * buttonImage = [UIImage imageNamed:@"addPhoto"];
    [self.imageButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    int fieldHeight = 30;
    
    self.email = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 300, fieldHeight)];
    self.email.text = self.emailString;
    self.email.textAlignment = NSTextAlignmentCenter;
    self.email.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
    self.email.adjustsFontSizeToFitWidth = YES;
    self.email.keyboardType = UIKeyboardTypeEmailAddress;
    self.email.returnKeyType = UIReturnKeyNext;
    self.email.delegate = self;
    [self.inputView addSubview:self.email];
    
    self.passwordNew = [[UITextField alloc] initWithFrame:CGRectMake(0, 40, 300, fieldHeight)];
    self.passwordNew.placeholder = @"Password";
    self.passwordNew.textAlignment = NSTextAlignmentCenter;
    self.passwordNew.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
    self.passwordNew.adjustsFontSizeToFitWidth = YES;
    self.passwordNew.keyboardType = UIKeyboardTypeEmailAddress; // Should change
    self.passwordNew.returnKeyType = UIReturnKeyNext;
    self.passwordNew.delegate = self;
    self.passwordNew.secureTextEntry = YES;
    [self.inputView addSubview:self.passwordNew];
    
    self.passwordConfirm = [[UITextField alloc] initWithFrame:CGRectMake(0, 80, 300, fieldHeight)];
    self.passwordConfirm.placeholder = @"Password";
    self.passwordConfirm.textAlignment = NSTextAlignmentCenter;
    self.passwordConfirm.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
    self.passwordConfirm.adjustsFontSizeToFitWidth = YES;
    self.passwordConfirm.keyboardType = UIKeyboardTypeEmailAddress; // Should change
    self.passwordConfirm.returnKeyType = UIReturnKeyGo;
    self.passwordConfirm.delegate = self;
    self.passwordConfirm.secureTextEntry = YES;
    [self.inputView addSubview:self.passwordConfirm];
    
    self.signup = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.signup.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
    [self.signup addTarget:self action:@selector(signupButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.signup setFrame:CGRectMake(40, 120, 215, 40)];
    [self.signup setTitle:@"Signup" forState:UIControlStateNormal];
    [self.signup setExclusiveTouch:YES];
    [self.inputView addSubview:self.signup];
}

#pragma mark - Action Methods

-(void)signupButtonClicked:(UIButton *)sender
{
//    NSLog(@"CLICKED: signup button");
//    BOOL valid = [self isTextFieldValid:self.passwordConfirm];
//    
//    if ([self.passwordNew.text isEqual:self.passwordConfirm.text] && valid == YES)
//    {
//        NSLog(@"PASSWORDS: match and are valid.");
//        NSData *selectedImage = UIImageJPEGRepresentation(self.userImage, 1);
//        
//        // Create an instance of PFUser
//        PFUser *user = [PFUser new];
//        
//        // Initializing the properties of PFUser
//        user.username = self.userNameNew.text;
//        user.password = self.passwordConfirm.text;
//        user.email = self.email.text;
//        
//        // Check if the user selected an image
//        if (selectedImage != nil) {
//            
//            // Connvert image to a PFFile
//            PFFile *imageFile = [PFFile fileWithName:@"image" data:selectedImage];
//            user[@"userAvatar"] = imageFile;
//            
//            //call the signup method
//            [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//                
//                // Message displayed if signup was successful
//                NSString *userMessage = @"Registration was successful";
//                
//                if (!succeeded){
//                    // Message displayed if signup was unsuccessful
//                    userMessage = error.localizedDescription;
//                    
//                }
//                // Display alert
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:userMessage preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction *okayButton = [UIAlertAction actionWithTitle:@"Okay"
//                                                                     style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                                                                         if(succeeded){
//                                                                             // Dismiss Controller if signup was successful
//                                                                             [self dismissViewControllerAnimated:YES completion:nil];
//                                                                             
//                                                                         }
//                                                                         
//                                                                     }];
//                [alert addAction:okayButton];
//                [self presentViewController:alert
//                                   animated:YES
//                                 completion:nil];
//            }];
//        }
//    }

}
- (void)setImage:(UIImage *)image withCompletion:(void(^)())completion
{
    PFUser *currentUser = [PFUser currentUser];
    NSData *data = UIImagePNGRepresentation(image);
    PFFile *imageFile = [PFFile fileWithName:@"image.png" data:data];
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            currentUser[@"userAvatar"] = imageFile;
        }
        completion();
    }];
}

- (IBAction)onSelectProfileImageButtonTapped:(UIButton *)sender
{
    UIImagePickerController *pickerController = [UIImagePickerController new];
    pickerController.delegate = self;
    pickerController.allowsEditing = YES;
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:pickerController animated:YES completion:nil];
}

#pragma mark - UIImagePicker Delegate Methods

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    self.userImage = [info objectForKey:UIImagePickerControllerEditedImage];
    self.profileImage.image = self.userImage;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // If user sets an image remove the placeholder
    if (self.profileImage)
    {
        [self.imageButton setBackgroundImage:nil forState:UIControlStateNormal];
        self.profileImage.alpha = 1;
    }
}

#pragma mark - Overrides

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
-(void)textFieldTextDidChange:(NSNotification *)notification
{
    UITextField *textField = (UITextField *)notification.object;
    
    if (textField == self.passwordConfirm)
    {
        textField.tag = 3;
    }
    
    NSLog(@"textField.tag: %ld", (long)textField.tag);
    NSLog(@"textField.text: %@", textField.text);

}




@end
