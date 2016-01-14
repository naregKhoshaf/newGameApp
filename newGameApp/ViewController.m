//
//  ViewController.m
//  newGameApp
//
//  Created by Nareg Khoshafian on 1/12/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//


#import "ViewController.h"



@implementation ViewController

CGPoint emptySpot;

CGPoint tapCen;
CGPoint left;
CGPoint right;
CGPoint top;
CGPoint bottom;

bool leftIsempty, rightIsEmpty, topIsEmpty, bottomeIsEmpty;
int width = 192;
int height = 192;

int puzzleSize = 4;


// 1. This method extracted from viewDidLoad
- (void)puzzleSetup {
    int xLocation = 96;
    int yLocation = 96;

    for(int v = 0; v<puzzleSize; v++)
    {
        for(int h=0; h<puzzleSize; h++){
            UIImageView *myImgView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, width, height)];
            // Each UIImage view is a single image
            // alloc allocates a chunk of memory to hold the object, and returns the pointer.
            // Creates a rectangel with a width and height.
            CGPoint curCenter = CGPointMake(xLocation, yLocation);
            // This will be the cordinates of the image.
            [_allCenters addObject: [NSValue valueWithCGPoint:curCenter] ];
            
            myImgView.center = curCenter;
            // center is the position of the image
            myImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"Mona_Lisa_%02i.jpeg", h+v*4]];
            myImgView.userInteractionEnabled = YES;
            [_allImgViews addObject:myImgView];
            [self.view addSubview:myImgView];
            xLocation +=width;
        }
        xLocation = width/2;
        yLocation += height;
    }
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.allImgViews = [NSMutableArray new];
    self.allCenters = [NSMutableArray new];
    
    [self puzzleSetup];
    
    [[_allImgViews objectAtIndex:0] removeFromSuperview];
    [_allImgViews removeObjectAtIndex:0];
    // we have an array with all 15 imageviews and another array with all 16 centers/locations
    
//    [self randomizeBlocks];
    [self reverseBlocks];
}



//- (void) randomizeBlocks {
//    NSMutableArray* centerCopy = [_allCenters mutableCopy];
//    int randLocInt; // 0---15
//    CGPoint randLoc;
//    
//    for (UIView* any in _allImgViews)
//    {
//        randLocInt = arc4random() % centerCopy.count; // 0---15
//        randLoc = [[centerCopy objectAtIndex:randLocInt] CGPointValue];
//        
//        any.center = randLoc;
//        [centerCopy removeObjectAtIndex:randLocInt];
//    }
//    emptySpot = [[centerCopy objectAtIndex:0] CGPointValue];
//}



// To Do: Need to reverse the images instead of Randomize them.
- (void) reverseBlocks {
    NSMutableArray *centerCopy = [_allCenters mutableCopy];
    int reverseLocInt;
    CGPoint reverseLoc;
    
    for (UIView *any in _allImgViews)
    {
        reverseLocInt = arc4random() % centerCopy.count;
        reverseLoc = [[centerCopy objectAtIndex:reverseLocInt] CGPointValue];
        
        any.center = reverseLoc;
        [centerCopy removeObjectAtIndex:reverseLocInt];
    }
    emptySpot = [[centerCopy objectAtIndex:0] CGPointValue];
}




-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch* myTouch = [[touches allObjects] objectAtIndex:0];
    if (myTouch.view != self.view)
    {
        tapCen = myTouch.view.center;
        
        left = CGPointMake(tapCen.x-width, tapCen.y);
        right = CGPointMake(tapCen.x+width, tapCen.y);
        top = CGPointMake(tapCen.x, tapCen.y+height);
        bottom = CGPointMake(tapCen.x, tapCen.y-height);
        
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