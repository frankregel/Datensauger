//
//  PickerViewController.h
//  DataSucker
//
//  Created by Frank Regel on 24.01.14.
//  Copyright (c) 2014 Frank Regel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphicsProtocol.h"

@interface PickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property id <GraphicsProtocol> graphicsDelegate;

@end
