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

#import "S3TransferManagerDownloadViewController.h"
#import "Constants.h"

@interface S3TransferManagerDownloadViewController ()

@property (nonatomic, strong) S3TransferOperation *downloadFileOperation;
@property (nonatomic) double totalBytesWritten;
@property (nonatomic) long long expectedTotalBytes;
@property (nonatomic) NSString * filePath;

@end

@implementation S3TransferManagerDownloadViewController{
    NSMutableArray *fileList;
    AmazonS3Client *s3Client;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    fileList = [[NSMutableArray alloc] init];
    
    // List files from S3 Bucket: specify bucket name
    [self s3DirectoryListing:@"s3-transfer-manager-bucket-akiajzsqloxceevdoepa"];
}


#pragma mark - AmazonServiceRequestDelegate

-(void)request:(AmazonServiceRequest *)request didReceiveResponse:(NSURLResponse *)response {
}

- (void)request:(AmazonServiceRequest *)request didReceiveData:(NSData *)data {
}

-(void)request:(AmazonServiceRequest *)request didCompleteWithResponse:(AmazonServiceResponse *)response {
}

-(void)request:(AmazonServiceRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError called: %@", error);
}

-(void)request:(AmazonServiceRequest *)request didFailWithServiceException:(NSException *)exception {
    NSLog(@"didFailWithServiceException called: %@", exception);
}

-(void) s3DirectoryListing: (NSString *) bucketName {
    
    // Init connection with S3Client
    s3Client = [[AmazonS3Client alloc] initWithAccessKey:ACCESS_KEY_ID withSecretKey:SECRET_KEY];
    
    @try {
        // Get file list
        S3ListObjectsRequest *req = [[S3ListObjectsRequest alloc] initWithName:bucketName];
        S3ListObjectsResponse *res = [s3Client listObjects:req];
        NSMutableArray* objectSummaries = res.listObjectsResult.objectSummaries;
        
        // Add each filename to fileList
        for (int x = 0; x < [objectSummaries count]; x++) {
            [fileList addObject:[objectSummaries objectAtIndex:x]];
            NSLog(@"%@", [fileList lastObject]);
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Cannot list S3 %@",exception);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [fileList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *fileListIdentifier = @"fileListIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:fileListIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:fileListIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[fileList objectAtIndex:indexPath.row]];
    return cell;
}
@end
