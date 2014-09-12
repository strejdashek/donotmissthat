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
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewMonth;

@property (strong, nonatomic) UIView *backgroundViewForNewEvent;
@property (assign, nonatomic) CGRect selectedCellDefaultFrame;
@property (assign, nonatomic) CGAffineTransform selectedCellDefaultTransform;
@property (strong, nonatomic) UIViewController *currentVC;

//action methods
- (IBAction)newEventBtnTap:(id)sender;

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

#pragma mark - UICollectionView Delegate

//- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    if (cell.selected)
//    {
//        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
//        [UIView transitionWithView:cell
//                          duration:1.0
//                           options:UIViewAnimationOptionTransitionFlipFromLeft
//                        animations:^{
//                            [cell setFrame:self.selectedCellDefaultFrame];
//                            cell.transform = self.selectedCellDefaultTransform;
//                        }
//                        completion:^(BOOL finished) {
//                            self.selectedCellDefaultFrame = CGRectZero;
//                            [collectionView reloadItemsAtIndexPaths:@[indexPath]];
//                        }];
//        return NO;
//    }
//    else
//    {
//        return YES;
//    }
//}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    [cell.superview bringSubviewToFront:cell];
//    self.selectedCellDefaultFrame = cell.frame;
//    self.selectedCellDefaultTransform = cell.transform;
//    
//    [UIView transitionWithView:cell
//                      duration:1.0
//                       options:UIViewAnimationOptionTransitionFlipFromRight
//                    animations:^{
//                        [cell setFrame:collectionView.bounds];
//                        cell.transform = CGAffineTransformMakeRotation(0.0);
//                    }
//                    completion:^(BOOL finished) {}];
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - Action Methods

//- (IBAction)newEventBtnTap:(id)sender
//{
//    //get selected cell
//    CGPoint point = [sender convertPoint:CGPointZero toView:self.collectionViewMonth];
//    NSIndexPath *indexPath = [self.collectionViewMonth indexPathForItemAtPoint:point];
//    UICollectionViewCell *cell = [self.collectionViewMonth cellForItemAtIndexPath:indexPath];
//    
//    //add gray background with tap action
//    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
//    self.backgroundViewForNewEvent = [[UIView alloc] initWithFrame:mainWindow.frame];
//    self.backgroundViewForNewEvent.backgroundColor = [UIColor clearColor];
//    [mainWindow addSubview:self.backgroundViewForNewEvent];
//    UITapGestureRecognizer *tapToPresentCardGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideNewEvent)];
//    [self.backgroundViewForNewEvent addGestureRecognizer:tapToPresentCardGesture];
//    
//    // translate the frame of the cell to the main window
//    CGPoint translatedOrigin = [cell convertPoint:cell.bounds.origin toView:self.backgroundViewForNewEvent];
//    CGRect translatedFrame = CGRectMake(translatedOrigin.x, translatedOrigin.y, cell.frame.size.width, cell.frame.size.height);
//    cell.frame = translatedFrame;
//    
//    [self.backgroundViewForNewEvent addSubview:cell];
//    
//    [CATransaction flush]; //potentionally dangerous
//    
//    [UIView transitionWithView:cell
//                      duration:0.5
//                       options:UIViewAnimationOptionTransitionFlipFromLeft
//                    animations:^{
//                        
//                        [cell setFrame:CGRectMake(185, 200, 400, 350)];
//                        self.backgroundViewForNewEvent.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.45];
//                        
//                        DNMNewEventViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewEventVC"];
//                        [cell addSubview:viewController.view];
//                        [viewController didMoveToParentViewController:self];
//                        self.currentVC = viewController;
//                        
//                    }
//                    completion:^(BOOL finished) {}];
//}

- (IBAction)newEventBtnTap:(id)sender
{
    //get selected cell
    CGPoint point = [sender convertPoint:CGPointZero toView:self.collectionViewMonth];
    NSIndexPath *indexPath = [self.collectionViewMonth indexPathForItemAtPoint:point];
    UICollectionViewCell *cell = [self.collectionViewMonth cellForItemAtIndexPath:indexPath];
    
    //add gray background with tap action
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
    self.backgroundViewForNewEvent = [[UIView alloc] initWithFrame:mainWindow.frame];
    self.backgroundViewForNewEvent.backgroundColor = [UIColor clearColor];
    [mainWindow addSubview:self.backgroundViewForNewEvent];
    UITapGestureRecognizer *tapToPresentCardGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideNewEvent)];
    [self.backgroundViewForNewEvent addGestureRecognizer:tapToPresentCardGesture];
    
    // translate the frame of the cell to the main window
    CGPoint translatedOrigin = [cell convertPoint:cell.bounds.origin toView:self.backgroundViewForNewEvent];
    CGRect translatedFrame = CGRectMake(translatedOrigin.x, translatedOrigin.y, cell.frame.size.width, cell.frame.size.height);
    cell.frame = translatedFrame;
    
    [self.backgroundViewForNewEvent addSubview:cell];
    
    [CATransaction flush]; //potentionally dangerous
    
    [UIView transitionWithView:cell
                      duration:0.7
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        
                        [cell setFrame:CGRectMake(185, 200, 400, 350)];
                        self.backgroundViewForNewEvent.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.45];
                        
                        DNMNewEventViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewEventVC"];
                        [cell addSubview:viewController.view];
                        [viewController didMoveToParentViewController:self];
                        self.currentVC = viewController;
                        
                    }
                    completion:^(BOOL finished) {}];
}

#pragma mark - Public Methods

- (void)hideNewEvent
{
    NSLog(@"Go to hide it");
}

@end
