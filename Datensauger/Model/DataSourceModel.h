//
//  DataSourceModel.h
//  DataSucker
//
//  Created by Frank Regel on 24.01.14.
//  Copyright (c) 2014 Frank Regel. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol DataSourceDelegate;

@interface DataSourceModel : NSObject
#warning Wie macht man das mit delegate?
//Würde ein delegate sind machen und wenn ja, wie?
@property id<DataSourceDelegate> delegate;

-(NSArray*)loadDataFromWanWith:(NSString*)quellURL and:(NSString*)keyForObject;
-(NSMutableArray*) getPicsFromWanWith:(NSString*)stringForKey inPostArray:(NSArray*)thumbNailArray;
@end

@protocol DataSourceDelegate <NSObject>


@optional
- didCallWanData;

@end

