//
//  DailyForecastTableViewCell.h
//  WorkshopWeatherIOS
//
//  Created by Ben Jakuben on 6/13/14.
//  Copyright (c) 2014 Ben Jakuben. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyForecastTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *dayLabel;
@property (strong, nonatomic) IBOutlet UILabel *summaryLabel;
@property (strong, nonatomic) IBOutlet UILabel *highLowLabel;

@end
