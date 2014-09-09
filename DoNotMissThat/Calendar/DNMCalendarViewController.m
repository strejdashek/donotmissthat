//
//  DNMCalendarViewController.m
//  DoNotMissIt
//
//  Created by Viktor Kucera on 9/5/14.
//  Copyright (c) 2014 Viktor Kucera. All rights reserved.
//

#import "DNMCalendarViewController.h"

@interface DNMCalendarViewController ()

//private properties
@property (nonatomic, assign) BOOL isToday;

@end

@implementation DNMCalendarViewController

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
    
    [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"item_seleted.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"item_unselected.png"]];
    
    
    //make statusbar white
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5 || indexPath.row == 12 || indexPath.row == 19 || indexPath.row == 26 || indexPath.row == 33 || (indexPath.row + 1) % 7 == 0)
    {
        NSLog(@"%d",indexPath.row);
        NSLog(@"---------------------");
        
        DNMWeekendCollectionViewCell *cell = (DNMWeekendCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"WeekendCell" forIndexPath:indexPath];
        return cell;
    }
    else
    {
        int r = arc4random_uniform(74);
        
        if (r % 3 != 0)
        {
            DNMNoEventCollectionViewCell *cell = (DNMNoEventCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"NoEventCell" forIndexPath:indexPath];
            return cell;
        }
        else
        {
            DNMEventCollectionViewCell *cell = (DNMEventCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"EventCell" forIndexPath:indexPath];
            return cell;
        }
    }
}


@end
