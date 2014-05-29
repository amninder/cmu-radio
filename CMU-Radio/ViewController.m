//
//  ViewController.m
//  CMU-Radio
//
//  Created by Narota, Amninder Singh on 11/4/13.
//  Copyright (c) 2013 Narota, Amninder Singh. All rights reserved.
//https://itunes.apple.com/us/rss/topfreeapplications/limit=300/json

#import "ViewController.h"
#import "Player.h"

@interface ViewController (){
    NSMutableData *webData;
    NSURLConnection *connection;
    NSMutableArray *name_array;
    NSMutableArray *url_array;
    NSMutableArray *lat_array;
    NSMutableArray *lng_array;
    NSMutableArray *school_array;
    NSMutableArray *state_array;
    NSDictionary *radioStations;
    
    NSString *name_for_segue;
    NSString *url_for_segue;
    NSString *lat_for_segue;
    NSString *lng_for_segue;
    NSString *school_for_segue;
    NSString *state_for_segue;
    
    NSMutableDictionary *url_for_station;
}

@end

@implementation ViewController
@synthesize myTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //myTableView = [[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [[self myTableView]setDelegate:self];
    [[self myTableView]setDataSource:self];
    name_array      = [[NSMutableArray alloc]init];
    url_array       = [[NSMutableArray alloc]init];
    lat_array       = [[NSMutableArray alloc]init];
    lng_array       = [[NSMutableArray alloc]init];
    school_array    = [[NSMutableArray alloc]init];
    state_array     = [[NSMutableArray alloc]init];
    
    name_array      = [[NSMutableArray alloc]init];
    url_array       = [[NSMutableArray alloc]init];
    lat_array       = [[NSMutableArray alloc]init];
    lng_array       = [[NSMutableArray alloc]init];
    school_array    = [[NSMutableArray alloc]init];
    state_array     = [[NSMutableArray alloc]init];
    
    NSURL *url  = [NSURL URLWithString:@"http://0.0.0.0:5000/stations/?format=json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if(connection){
        webData = [[NSMutableData alloc]init];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [webData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [webData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"connection fail with error");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSArray *allDataArray = [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
    for (radioStations in allDataArray){
        NSString *name = [radioStations objectForKey:@"name"];
        [name_array addObject:name];
        [url_array addObject:[radioStations objectForKey:@"url"]];
        [lat_array addObject:[radioStations objectForKey:@"lat"]];
        [lng_array addObject:[radioStations objectForKey:@"lng"]];
        [school_array addObject:[radioStations objectForKey:@"school"]];
        [state_array addObject:[radioStations objectForKey:@"state"]];
    }
    [[self myTableView]reloadData];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [name_array count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [name_array objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [school_array objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    name_for_segue      = [name_array objectAtIndex:indexPath.item];
    url_for_segue       = [url_array objectAtIndex:indexPath.item];
    lat_for_segue       = [lat_array objectAtIndex:indexPath.item];
    lng_for_segue       = [lng_array objectAtIndex:indexPath.item];
    school_for_segue    = [school_array objectAtIndex:indexPath.item];
    state_for_segue     = [state_array objectAtIndex:indexPath.item];
    NSLog(@"you selected radiostation from %@", state_for_segue);
    @try {
        [self performSegueWithIdentifier:@"goToPlayer" sender:self];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
    @finally {
        NSLog(@"finally");
    }
}

-(void)prcessForTableView:(NSMutableArray *)items{
    
}

//SEGUE stuff goes down here
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"goToPlayer"]) {
        NSLog(@"segue fired");
        Player *player  = [segue destinationViewController];
        player.name     = name_for_segue;
        player.url      = url_for_segue;
        player.lat      = lat_for_segue;
        player.lng      = lng_for_segue;
        player.school   = school_for_segue;
        player.state    = state_for_segue;
    }
}

@end
