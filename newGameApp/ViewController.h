//
//  ViewController.h
//  newGameApp
//
//  Created by Nareg Khoshafian on 1/12/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
//Added
@property (nonatomic, strong) NSMutableArray *allImgViews;
// Array of all the images that I need to access in order to reverse and eliminate one image for the puzzle. 
@property (nonatomic, strong) NSMutableArray *allCenters;
//

@end

