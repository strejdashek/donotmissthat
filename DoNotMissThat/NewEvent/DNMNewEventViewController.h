//
//  DNMNewEventViewController.h
//  DoNotMissThat
//
//  Created by Viktor Kucera on 9/12/14.
//  Copyright (c) 2014 Viktor Kucera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DNMNewEventVCDelegate.h"

@interface DNMNewEventViewController : UIViewController

//delegates
@property (nonatomic, weak) id<DNMNewEventVCDelegate> delegateNewEventVC;

@end
