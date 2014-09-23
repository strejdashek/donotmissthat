//
//  DNMNewEventViewController.m
//  DoNotMissThat
//
//  Created by Viktor Kucera on 9/12/14.
//  Copyright (c) 2014 Viktor Kucera. All rights reserved.
//

#import "DNMNewEventViewController.h"

@interface DNMNewEventViewController ()

//action methods
- (IBAction)cancelBtnTap:(id)sender;
- (IBAction)doneBtnTap:(id)sender;

@end

@implementation DNMNewEventViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Methods

- (IBAction)cancelBtnTap:(id)sender
{
    [self.delegateNewEventVC didSelectCancelBtn:self];
}

- (IBAction)doneBtnTap:(id)sender
{
    [self.delegateNewEventVC didSelectDoneBtn:self];
}

@end
