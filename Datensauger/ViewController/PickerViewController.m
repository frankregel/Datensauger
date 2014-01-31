//
//  PickerViewController.m
//  Datensauger
//
//  Created by Frank Regel on 24.01.14.
//  Copyright (c) 2014 Frank Regel. All rights reserved.
//

#import "PickerViewController.h"
#import "DataSourceModel.h"

@interface PickerViewController () //<DataSourceDelegate>
@property NSArray *postArray;
@property NSMutableArray *mutableImageArray;
@property DataSourceModel *dataSource;
@property UIPickerView *picker;

@end

@implementation PickerViewController

- (id) init
{
    self = [super init];
    if (self)
    {
        [self loadPostObjectsFromSource];
        [self loadPicker];
        [self createBackButton];

    }
    return self;
}

#pragma mark - pickerview laden
-(void) loadPicker
{
    UIPickerView *picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 200, 320, 300)];
    picker.backgroundColor = [UIColor greenColor];
    self.view.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:picker];
    [picker setDelegate:self];
}

-(void)createBackButton
{
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(130, 100, 60, 40)];
    [backButton setTitle:@"zurück" forState:UIControlStateNormal];
    backButton.backgroundColor = [UIColor lightGrayColor];
    [backButton addTarget:self action:@selector(backToMainScreen) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

-(void)backToMainScreen
{
    if (_graphicsDelegate)
    {
        [_graphicsDelegate backButtonTouched:self];
    }
}
#pragma mark - delegates implementieren
//delegates
//Anzahl der Rollen
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//Anzahl der Spalten Zellen
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _postArray.count;
}
//Höhe der Zellen
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    //die Höhe der einzelnen Zellen bestimmen.
    return 62;
}
/*
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSDictionary *oneResultDict = [_postArray objectAtIndex:row];
    NSString *rowTitle = [oneResultDict objectForKey:@"title"];
    return rowTitle;
}
*/
//prüfen was auf dem Picker ausgewählt wurde
-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSDictionary *alertDict = [_postArray objectAtIndex:row];
    
    NSString *touchString = [alertDict objectForKey:@"title"];
    
    UIAlertView *touchAlertView = [[UIAlertView alloc] initWithTitle:@"Selection Information"
                                                             message:touchString
                                                            delegate:self
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles: nil];
    [touchAlertView show];
}

//pickerview eine UIView hinzufügen.

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    NSDictionary *oneResultDict = [_postArray objectAtIndex:row];
    

    UIImage *tmpImage = [_mutableImageArray objectAtIndex:row];
    UIImageView *rowImage = [[UIImageView alloc]initWithImage:tmpImage];
    rowImage.frame = CGRectMake(10, 0, 20, 60);
    rowImage.contentMode = UIViewContentModeScaleAspectFit;//positionieren, anpassen etc.

    UIImage *backImage =[UIImage imageNamed:@"test.png"];
    UIImageView *backgroundImage =[[UIImageView alloc]initWithImage:backImage];

    //Text ans Label geben
    UILabel *rowLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 0, 200, 60)];
    rowLabel.text = [oneResultDict objectForKey:@"title"];

    //UIView erstellen und image und Label hinzufügen !!!!UIVIEW Y- Height DARF NICHT ZU HOCH SEIN!!!!
    UIView *rowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    
    //Inhalte adden
    [rowView insertSubview:backgroundImage atIndex:0];
    [rowView insertSubview:rowImage atIndex:1];
    [rowView insertSubview:rowLabel atIndex:2];

    return rowView;
}

#pragma mark - Datenquelle
-(void) loadPostObjectsFromSource
{
    _dataSource = [DataSourceModel new];
    _postArray = [_dataSource loadDataFromWanWith:@"http://www.dealdoktor.de/api/get_top_deals/" and:@"posts"];
    _mutableImageArray = [_dataSource getPicsFromWanWith:@"thumbnail" inPostArray:_postArray];
}

#pragma mark - System
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
