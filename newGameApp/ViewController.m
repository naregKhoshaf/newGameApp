//
//  ViewController.m
//  newGameApp
//
//  Created by Nareg Khoshafian on 1/12/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//


#import "ViewController.h"



@implementation ViewController

NSMutableArray *allImgViews;
NSMutableArray *allCenters;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    allImgViews = [NSMutableArray new];
    allCenters = [NSMutableArray new];
    
    int xLocation = 96;
    int yLocation = 96;
    
    for(int v = 0; v<4; v++)
    {
        for(int h=0; h<4; h++){
            UIImageView *myImgView = [[UIImageView alloc] initWithFrame: CGRectMake(50, 234, 192, 192)];
            
            CGPoint curCenter = CGPointMake(xLocation, yLocation);
            [allCenters addObject: [NSValue valueWithCGPoint:curCenter] ];
            
            myImgView.center = curCenter;
            myImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"Mona_Lisa_%02i.jpeg", h+v*4]];
            myImgView.userInteractionEnabled = YES;
            [allImgViews addObject:myImgView];
            [self.view addSubview:myImgView];
            xLocation +=192;
        }
        xLocation = 96;
        yLocation += 192;
    }
    
    [[allImgViews objectAtIndex:0] removeFromSuperview];
    [allImgViews removeObjectAtIndex:0];
    // we have an array with all 15 imageviews and another array with all 16 centers/locations
    
    [self randomizedBlocks];
}

CGPoint emptySpot;

- (void) randomizedBlocks {
    NSMutableArray* centerCopy = [allCenters mutableCopy];
    int randLocInt; // 0---15
    CGPoint randLoc;
    
    for (UIView* any in allImgViews)
    {
        randLocInt = arc4random() % centerCopy.count; // 0---15
        randLoc = [[centerCopy objectAtIndex:randLocInt] CGPointValue];
        
        any.center = randLoc;
        [centerCopy removeObjectAtIndex:randLocInt];
    }
    emptySpot = [[centerCopy objectAtIndex:0] CGPointValue];
}

// To Do: Need to reverse the images instead of Randomize them.
- (void) reverseBlocks {
    NSMutableArray* centerCopy = [allCenters mutableCopy];
    int reverseLocInt; // 0---15
    CGPoint reverseLoc;
    
    for (UIView* any in allImgViews)
    {
        reverseLocInt = arc4random() % centerCopy.count; // 0---15
        reverseLoc = [[centerCopy objectAtIndex:reverseLocInt] CGPointValue];
        
        any.center = reverseLoc;
        [centerCopy removeObjectAtIndex:reverseLocInt];
    }
    emptySpot = [[centerCopy objectAtIndex:0] CGPointValue];
}




CGPoint tapCen;
CGPoint left;
CGPoint right;
CGPoint top;
CGPoint bottom;

bool leftIsempty, rightIsEmpty, topIsEmpty, bottomeIsEmpty;


-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch* myTouch = [[touches allObjects] objectAtIndex:0];
    if (myTouch.view != self.view)
    {
        tapCen = myTouch.view.center;
        
        left = CGPointMake(tapCen.x-192, tapCen.y);
        right = CGPointMake(tapCen.x+192, tapCen.y);
        top = CGPointMake(tapCen.x, tapCen.y+192);
        bottom = CGPointMake(tapCen.x, tapCen.y-192);
        
        if([[NSValue valueWithCGPoint:left] isEqual:[NSValue valueWithCGPoint:emptySpot]]) leftIsempty = true;
        if([[NSValue valueWithCGPoint:right] isEqual:[NSValue valueWithCGPoint:emptySpot]]) rightIsEmpty = true;
        if([[NSValue valueWithCGPoint:top] isEqual:[NSValue valueWithCGPoint:emptySpot]]) topIsEmpty = true;
        if([[NSValue valueWithCGPoint:bottom] isEqual:[NSValue valueWithCGPoint:emptySpot]]) bottomeIsEmpty = true;
        
        if(leftIsempty || rightIsEmpty || bottomeIsEmpty || topIsEmpty)
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:.3];
            myTouch.view.center = emptySpot;
            [UIView commitAnimations];
            emptySpot = tapCen;
            leftIsempty = false; rightIsEmpty = false; bottomeIsEmpty = false; topIsEmpty = false;
        }
        
        
    }
    
}

@end