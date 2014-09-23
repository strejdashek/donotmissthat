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
@property (strong, nonatomic) UICollectionViewCell *selectedCell;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@property (assign, nonatomic) CGRect selectedCellDefaultFrame;
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

#pragma mark - DNMNewEventVC Delegate

- (void)didSelectCancelBtn:(DNMNewEventViewController *)newEventViewController
{
    NSLog(@"Cancel");
}

- (void)didSelectDoneBtn:(DNMNewEventViewController *)newEventViewController
{
    NSLog(@"Done");
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - Action Methods

- (IBAction)newEventBtnTap:(id)sender
{
    //get selected cell
    CGPoint point = [sender convertPoint:CGPointZero toView:self.collectionViewMonth];
    NSIndexPath *indexPath = [self.collectionViewMonth indexPathForItemAtPoint:point];
    self.selectedCell = [self.collectionViewMonth cellForItemAtIndexPath:indexPath];
    self.selectedIndexPath = indexPath;
    
    //add gray background with tap action
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
    self.backgroundViewForNewEvent = [[UIView alloc] initWithFrame:mainWindow.frame];
    self.backgroundViewForNewEvent.backgroundColor = [UIColor clearColor];
    [mainWindow addSubview:self.backgroundViewForNewEvent];
    UITapGestureRecognizer *tapToPresentCardGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideNewEvent)];
    [self.backgroundViewForNewEvent addGestureRecognizer:tapToPresentCardGesture];
    
    // translate the frame of the cell to the main window
    self.selectedCellDefaultFrame = self.selectedCell.frame;
    CGPoint translatedOrigin = [self.selectedCell convertPoint:self.selectedCell.bounds.origin toView:self.backgroundViewForNewEvent];
    CGRect translatedFrame = CGRectMake(translatedOrigin.x, translatedOrigin.y, self.selectedCell.frame.size.width, self.selectedCell.frame.size.height);
    self.selectedCell.frame = translatedFrame;
    
    [self.backgroundViewForNewEvent addSubview:self.selectedCell];
    
    [CATransaction flush]; //potentionally dangerous
    
    [UIView transitionWithView:self.selectedCell
                      duration:0.7
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        
                        [self.selectedCell setFrame:CGRectMake(185, 200, 400, 350)];
                        self.backgroundViewForNewEvent.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.45];
                        
                        //add new view into cell
                        DNMNewEventViewController *viewController = [[UIStoryboard storyboardWithName:@"NewEvent" bundle:nil] instantiateViewControllerWithIdentifier:@"NewEventVC"];
                        [self.selectedCell addSubview:viewController.view];
                        [viewController.view setTag:1];
                        [viewController didMoveToParentViewController:self];
                        self.currentVC = viewController;
                        [viewController setDelegateNewEventVC:self];
                    }
                    completion:^(BOOL finished) {}];
}

#pragma mark - Public Methods

- (void)hideNewEvent
{
    //move selected cell behind background into collection view
    [self.selectedCell removeFromSuperview];
    CGPoint translatedOrigin = [self.selectedCell convertPoint:self.selectedCell.bounds.origin toView:self.collectionViewMonth];
    CGRect translatedFrame = CGRectMake(translatedOrigin.x, translatedOrigin.y, self.selectedCell.frame.size.width, self.selectedCell.frame.size.height);
    self.selectedCell.frame = translatedFrame;
    [self.collectionViewMonth addSubview:self.selectedCell];
    
    [CATransaction flush]; //potentionally dangerous
    
    // flip the contentView back from right to left
    [UIView transitionWithView:self.selectedCell
                      duration:0.7
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        
                        self.backgroundViewForNewEvent.backgroundColor = [UIColor clearColor];
                        
                        //original frame + view/vc cleanup
                        self.selectedCell.frame = self.selectedCellDefaultFrame;
                        for (UIView *subview in self.selectedCell.subviews)
                        {
                            if (subview.tag == 1)
                                [subview removeFromSuperview];
                        }
                        [self.currentVC removeFromParentViewController];
                        
                    } completion:^(BOOL finished) {
                        
                        // remove the modalView along with its tapGesture and set it to nil
                        [self.backgroundViewForNewEvent removeFromSuperview];
                        self.backgroundViewForNewEvent = nil;
                        
                        [self.collectionViewMonth reloadItemsAtIndexPaths:@[self.selectedIndexPath]];
                         self.selectedIndexPath = nil;
        
                    }];
}

@end
