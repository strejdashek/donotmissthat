//
//  DNMNewEventVCDelegate.h
//  DoNotMissThat
//
//  Created by Viktor Kucera on 9/14/14.
//  Copyright (c) 2014 Viktor Kucera. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DNMNewEventViewController;

@protocol DNMNewEventVCDelegate <NSObject>

- (void)didSelectCancelBtn:(DNMNewEventViewController *)newEventViewController;
- (void)didSelectDoneBtn:(DNMNewEventViewController *)newEventViewController;

@end
