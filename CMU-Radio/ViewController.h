//
//  ViewController.h
//  CMU-Radio
//
//  Created by Narota, Amninder Singh on 11/4/13.
//  Copyright (c) 2013 Narota, Amninder Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end
