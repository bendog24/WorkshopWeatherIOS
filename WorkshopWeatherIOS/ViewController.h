//
//  ViewController.h
//  WorkshopWeatherIOS
//
//  Created by Ben Jakuben on 6/13/14.
//  Copyright (c) 2014 Ben Jakuben. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"

@interface ViewController : GAITrackedViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *tableData;
@property (strong, nonatomic) IBOutlet UILabel *currentTemperatureLabel;
@property (strong, nonatomic) IBOutlet UIImageView *currentWeatherImage;

@end
