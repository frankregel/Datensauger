//
//  TableViewController.h
//  DataSucker
//
//  Created by Frank Regel on 23.01.14.
//  Copyright (c) 2014 Frank Regel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphicsProtocol.h"

@interface TableViewController : UITableViewController
@property id <GraphicsProtocol> graphicsDelegate;
@end
