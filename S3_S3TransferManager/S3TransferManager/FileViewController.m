//
//  FileViewController.m
//  S3TransferManager
//
//  Created by レー フックダイ on 12/8/13.
//
//

#import "FileViewController.h"

@interface FileViewController ()

@end

@implementation FileViewController

@synthesize fileLabel;
@synthesize fileName;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    fileLabel.text = fileName;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
