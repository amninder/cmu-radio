//
//  Player.h
//  CMU-Radio
//
//  Created by Narota, Amninder Singh on 11/8/13.
//  Copyright (c) 2013 Narota, Amninder Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface Player : UIViewController{
    UIButton *playButton;
}
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) NSString *name;
@property (weak, nonatomic) NSString *url;
@property (weak, nonatomic) NSString *lat;
@property (weak, nonatomic) NSString *lng;
@property (weak, nonatomic) NSString *school;
@property (weak, nonatomic) NSString *state;
@property (weak, nonatomic) NSMutableDictionary *station;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (nonatomic, strong)MPMoviePlayerController *player;
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@end
