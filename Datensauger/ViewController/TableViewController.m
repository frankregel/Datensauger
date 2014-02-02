//
//  TableViewController.m
//  DataSucker
//
//  Created by Frank Regel on 23.01.14.
//  Copyright (c) 2014 Frank Regel. All rights reserved.
//

#import "TableViewController.h"
#import "DataSourceModel.h"

@interface TableViewController ()
@property NSArray *postArray;
@property NSMutableArray *mutableImageArray;
//@property DataSourceModel *dataSource;

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.view.backgroundColor = [UIColor whiteColor];
        
        [self loadPostObjectsFromSource];
        [self createBackButton];
        // Custom initialization
    }
    return self;
}

-(void) createBackButton
{
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(130, 400, 60, 40)];
    backButton.backgroundColor = [UIColor lightGrayColor];
    [backButton setTitle:@"Zurück" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backToMainScreen) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [self.view bringSubviewToFront:backButton];
}



-(void)backToMainScreen
{
    if (_graphicsDelegate)
    {
        [_graphicsDelegate tableBackButtonTouched:self];
#warning passiert nix....
        NSLog(@"table back touched");
    }
}

#pragma mark - Datenquelle
-(void) loadPostObjectsFromSource
{
    _postArray = [[DataSourceModel useDataMethod]loadDataFromWanWith:@"http://www.dealdoktor.de/api/get_top_deals/" and:@"posts"];
    _mutableImageArray = [[DataSourceModel useDataMethod]getPicsFromWanWith:@"thumbnail" inPostArray:_postArray];
    
    /*
    _dataSource = [DataSourceModel new];
    _postArray = [_dataSource loadDataFromWanWith:@"http://www.dealdoktor.de/api/get_top_deals/" and:@"posts"];
    _mutableImageArray = [_dataSource getPicsFromWanWith:@"thumbnail" inPostArray:_postArray];
     */
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //Sektionen sind die Gruppierungsüberschriften
    
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _postArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    
    // Configure the cell...
    NSDictionary *oneResultDict = [_postArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [oneResultDict objectForKey:@"title"];
                            
    UIImage *tmpImage = [_mutableImageArray objectAtIndex:indexPath.row];
    cell.imageView.image = tmpImage;
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *alertDict = [_postArray objectAtIndex:indexPath.row];
    
    NSString *touchString = [alertDict objectForKey:@"title"];
                             
    UIAlertView *touchAlertView = [[UIAlertView alloc] initWithTitle:@"Touch Information"
                                                             message:touchString
                                                            delegate:self
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles: nil];
        [touchAlertView show];
}

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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
