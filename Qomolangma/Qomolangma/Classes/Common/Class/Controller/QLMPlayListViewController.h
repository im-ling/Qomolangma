//
//  QLMPlayListViewController.h
//  Qomolangma
//
//  Created by NowOrNever on 16/03/2017.
//  Copyright © 2017 Focus. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import ""
@interface QLMPlayListViewController : UIViewController

@property (nonatomic, assign) BOOL playFlag;

+ (instancetype)sharedPlayListViewController;

@end