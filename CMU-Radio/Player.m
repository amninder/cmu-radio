//
//  Player.m
//  CMU-Radio
//
//  Created by Narota, Amninder Singh on 11/8/13.
//  Copyright (c) 2013 Narota, Amninder Singh. All rights reserved.
//

#import "Player.h"
#import <MediaPlayer/MediaPlayer.h>
#import <GoogleMaps/GoogleMaps.h>

@interface Player () <GMSMapViewDelegate>{
    BOOL isPlaying;
}

@end

@implementation Player{
    GMSMapView *mapView_;
}

@synthesize nameText;
@synthesize lat;
@synthesize lng;
@synthesize school;
@synthesize state;
@synthesize schoolLabel;
@synthesize stateLabel;
@synthesize name;
@synthesize url;
@synthesize playButton;
@synthesize player;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    isPlaying = NO;
    
    [nameText setText:name];
    [schoolLabel setText:school];
    [stateLabel setText:state];
    
    [self initPlayer:url];
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    
    @try {
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[lat floatValue]
                                                                longitude:[lng floatValue]
                                                                     zoom:17];
        mapView_.delegate = self;
        mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
        mapView_.myLocationEnabled = YES;
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.tappable = YES;
        marker.position = CLLocationCoordinate2DMake([lat floatValue], [lng floatValue]);
        marker.title = @"Sydney";
        marker.snippet = @"Australia";
        marker.map = mapView_;
    }
    @catch (NSException *exception) {
        NSLog(@"EXCEPTION:\n%@\n\n", exception);
    }
    @finally {
        NSLog(@"Finally");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        NSLog(@"back button clicked");
        if (player) {
            [player pause];
        }
        player  = nil;
    }
}

- (IBAction)playSound:(id)sender {
    if (isPlaying) {
        NSLog(@"Song is playing");
        [playButton setTitle:@"Pause" forState:UIControlStateNormal];
        isPlaying = NO;
        [self playStream];
    }else{
        NSLog(@"Song is not playing");
        [playButton setTitle:@"Play" forState:UIControlStateNormal];
        isPlaying = YES;
        [self pauseStream];
    }
    
}
-(void)initPlayer:(NSString*) audioURL{
    @try {
        player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:url]];
        player.movieSourceType = MPMovieSourceTypeStreaming;
        [player prepareToPlay];
        player.scalingMode = MPMovieScalingModeAspectFit;
        player.fullscreen   = NO;
        player.controlStyle = MPMovieControlStyleFullscreen;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:nil name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
    @finally {
        NSLog(@"finally");
    }
}
-(void)playStream{
    [player play];
}
-(void)pauseStream{
    [player pause];
}
- (IBAction)showMap:(id)sender {
    self.view = mapView_;
    //[self.view bringSubviewToFront:mapView_];
}

-(void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker{
    //[self.view bringSubviewToFront:mapView_];
    [self.view sendSubviewToBack:mapView_];
    NSLog(@"info window tapped");
}
-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker{
    NSLog(@"Marker tapped");
    return YES;
}
@end
