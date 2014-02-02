//
//  DataSourceModel.h
//  DataSucker
//
//  Created by Frank Regel on 24.01.14.
//  Copyright (c) 2014 Frank Regel. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataSourceModel : NSObject

//sharedInstance
+(DataSourceModel*) useDataMethod;

//verfügbare Methoden
-(NSArray*)loadDataFromWanWith:(NSString*)quellURL and:(NSString*)keyForObject;
-(NSMutableArray*) getPicsFromWanWith:(NSString*)stringForKey inPostArray:(NSArray*)thumbNailArray;

@end

