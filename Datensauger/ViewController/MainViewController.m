//
//  MainViewController.m
//  DataSucker
//
//  Created by Frank Regel on 23.01.14.
//  Copyright (c) 2014 Frank Regel. All rights reserved.
//

#import "MainViewController.h"
#import "TableViewController.h"
#import "PickerViewController.h"
#import "GraphicsProtocol.h"

@interface MainViewController ()<GraphicsProtocol>
@property TableViewController *tableViewController;
@property PickerViewController *pickerViewController;
@property UIButton *startButton;
@property UIButton *pickerStartButton;
@end

@implementation MainViewController

//delegate Methode
-(void)backButtonTouched:(UIViewController *)viewController
{
    NSLog(@"back button touched");
    [viewController.view removeFromSuperview];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.view.backgroundColor = [UIColor yellowColor];
        
        _tableViewController = [TableViewController new];
        
        [self createStartButtonWithXPosition:20 andyPosition:300];
        [self createPIckerButtonWithXPosition:240 andyPosition:300];
        

        // Custom initialization
    }
    return self;
}

#pragma mark - button
-(void) createStartButtonWithXPosition:(float)xPosition andyPosition:(float)yPosition
{
    _startButton = [[UIButton alloc] initWithFrame:CGRectMake(xPosition, yPosition, 60, 30)];
    [_startButton setTitle:@"Table" forState:UIControlStateNormal];
    [_startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_startButton setBackgroundColor:[UIColor grayColor]];
    [_startButton addTarget:self action:@selector(startButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startButton];
}

-(void) startButtonTouched
{
    
    [self.view addSubview:_tableViewController.view];
    
    NSLog(@"touched");
}

-(void) createPIckerButtonWithXPosition:(float)xPosition andyPosition:(float)yPosition
{
    _pickerStartButton = [[UIButton alloc] initWithFrame:CGRectMake(xPosition, yPosition, 60, 30)];
    [_pickerStartButton setTitle:@"Picker" forState:UIControlStateNormal];
    [_pickerStartButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_pickerStartButton setBackgroundColor:[UIColor grayColor]];
    [_pickerStartButton addTarget:self action:@selector(pickerButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_pickerStartButton];
}

-(void) pickerButtonTouched
{
#warning wie bringe ich die mainview aus dem sichtbaren Bereich oder unload?
    _pickerViewController = [PickerViewController new];
    _pickerViewController.graphicsDelegate = self;
    [self.view addSubview:_pickerViewController.view];
    
}

#pragma mark - system
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
