//
//  DataSourceModel.m
//  DataSucker
//
//  Created by Frank Regel on 24.01.14.
//  Copyright (c) 2014 Frank Regel. All rights reserved.
//

#import "DataSourceModel.h"

@interface DataSourceModel()
@property NSArray *postArray;
@property NSMutableArray *mutableImageArray;


@end

@implementation DataSourceModel

-(NSArray*)loadDataFromWanWith:(NSString*)quellURL and:(NSString*)keyForObject
{
        //URL benennen
        NSURL *tmpUrl = [NSURL URLWithString:quellURL];
        //NSData die Daten der Quelle übergeben
        NSData *quellData = [NSData dataWithContentsOfURL:tmpUrl];
        //NSData in ein Dictionary umwandeln
        NSDictionary *dictionaryJSON = [NSJSONSerialization JSONObjectWithData:quellData
                                                                   options:NSJSONReadingAllowFragments
                                                                     error:nil];
        //ERgebnisse ins Array schreiben
        _postArray = [dictionaryJSON objectForKey:keyForObject];
    
    
        return _postArray;
}

-(NSMutableArray*) getPicsFromWanWith:(NSString*)stringForKey inPostArray:(NSArray*)thumbNailArray
{
    _mutableImageArray = [NSMutableArray new];
    
    for (NSDictionary *tmpDict in thumbNailArray)
    {
        NSString *thumbnailString =[tmpDict objectForKey:stringForKey];
        NSURL *thumbnailURL =[NSURL URLWithString:thumbnailString];
        NSData *tmpImageData = [NSData dataWithContentsOfURL:thumbnailURL];
        UIImage *tmpImage = [UIImage imageWithData:tmpImageData];
        [_mutableImageArray addObject:tmpImage];
        
    }
    return _mutableImageArray;
}

@end
