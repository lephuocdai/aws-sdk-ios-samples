/*
 * Copyright 2010-2013 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

#import <UIKit/UIKit.h>

#import <AWSRuntime/AWSRuntime.h>
#import <AWSS3/AWSS3.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>

@interface S3TransferManagerUploadViewController : UIViewController <UINavigationControllerDelegate, UIAlertViewDelegate, AmazonServiceRequestDelegate>

@property (nonatomic, strong) S3TransferManager *tm;


- (IBAction)upload:(id)sender;
- (IBAction)record:(id)sender;

- (NSString *)generateTempFile: (NSString *)filename : (long long)approximateFileSize;


- (BOOL)startCameraControllerFromViewController:(UIViewController *)controller usingDelegate:(id)delegate;
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;

@property (weak, nonatomic) IBOutlet UITextField *putObjectTextField;
@property (weak, nonatomic) IBOutlet UITextField *multipartObjectTextField;

@end
