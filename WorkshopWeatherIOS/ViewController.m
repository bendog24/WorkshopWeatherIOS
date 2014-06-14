//
//  ViewController.m
//  WorkshopWeatherIOS
//
//  Created by Ben Jakuben on 6/13/14.
//  Copyright (c) 2014 Ben Jakuben. All rights reserved.
//

#import "ViewController.h"
#import <RestKit/RestKit.h>
#import "DataModels.h"
#import "DailyForecastTableViewCell.h"

#define kBASEURL @"https://api.forecast.io"
#define kFORECASTKEY @"49aabc829e12b795569e85bde5933ac3"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self getForecastDataWithLat:36.099869 andLong:-115.171347];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    DailyForecastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    DailyData *dayData = [self.tableData objectAtIndex:indexPath.row];
    
    cell.dayLabel.text = [self getDayName:(int)indexPath.row];
    
    // TODO: Something is wrong with dayData
    cell.summaryLabel.text = dayData.summary;
    cell.highLowLabel.text = [NSString stringWithFormat:@"%.0f / %.0f", dayData.temperatureMax, dayData.temperatureMin];
    
    return cell;
}


#pragma mark - Helper methods

- (void)getForecastDataWithLat:(double)latitude andLong:(double)longitude {
    NSString *path = [NSString stringWithFormat:@"/forecast/%@/%f,%f", kFORECASTKEY, latitude, longitude];
    NSURL *baseURL = [NSURL URLWithString:[kBASEURL stringByAppendingString:path]];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful); // Anything in 2xx
    
    // register mappings
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[self getForecastMapping]
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:path
                                                                                           keyPath:nil
                                                                                       statusCodes:statusCodes];
    // Setup the request
    NSURLRequest *request = [NSURLRequest requestWithURL:baseURL];
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request
                                                                        responseDescriptors:@[responseDescriptor]];
    [operation setCompletionBlockWithSuccess:
        ^(RKObjectRequestOperation *operation, RKMappingResult *result) {
            Forecast *forecast = [result firstObject];
            NSLog(@"Mapped the forecast: %@", forecast);
            [self displayForecast:forecast];
        }
        failure:^(RKObjectRequestOperation *operation, NSError *error) {
            NSLog(@"Failed with error: %@", [error localizedDescription]);
        }];
    
    // Make the call!
    [operation start];
}

- (RKObjectMapping *)getForecastMapping {
    // Setup all object mappings
    RKObjectMapping *forecastMapping = [RKObjectMapping mappingForClass:[Forecast class]];
    [forecastMapping addAttributeMappingsFromArray:@[@"alerts", @"offset", @"longitude", @"timezone", @"latitude"]];
    
    RKObjectMapping *alertsMapping = [RKObjectMapping mappingForClass:[Alerts class]];
    [alertsMapping addAttributeMappingsFromArray:@[@"time", @"title", @"alertsDescription", @"expires", @"uri"]];
    
    RKObjectMapping *currentlyMapping = [RKObjectMapping mappingForClass:[Currently class]];
    [currentlyMapping addAttributeMappingsFromArray:@[@"temperature", @"windSpeed", @"humidity", @"windBearing", @"couldCover",
                                                      @"time", @"dewPoint", @"summary", @"precipIntensity", @"icon", @"visibility",
                                                      @"nearestStormBearing", @"apparentTemperature", @"pressure", @"precipProbability",
                                                      @"nearestStormDistance", @"ozone"]];
    
    RKObjectMapping *dailyMapping = [RKObjectMapping mappingForClass:[Daily class]];
    [dailyMapping addAttributeMappingsFromArray:@[@"summary", @"icon"]];
    
    RKObjectMapping *dailyDataMapping = [RKObjectMapping mappingForClass:[DailyData class]];
    [dailyDataMapping addAttributeMappingsFromArray:@[@"windSpeed", @"humidity", @"windBearing", @"time",
                                                      @"dewPoint", @"summary", @"precipIntensity", @"icon", @"visibility",
                                                      @"pressure", @"precipProbability", @"ozone", @"sunsetTime",
                                                      @"apparentTemperatureMaxTime", @"moonPhase", @"sunriseTime",
                                                      @"temperatureMin", @"apparentTemperatureMinTime", @"temperatureMinTime",
                                                      @"apparentTemperatureMin", @"precipIntensityMax", @"precipIntensityMaxTime",
                                                      @"temperatureMax", @"temperatureMaxTime", @"apparentTemperatureMax"]];
    
    RKObjectMapping *flagsMapping = [RKObjectMapping mappingForClass:[Flags class]];
    [flagsMapping addAttributeMappingsFromArray:@[@"darkskyStations", @"madisStations", @"lampStations", @"units", @"isdStations", @"sources"]];
    
    RKObjectMapping *hourlyMapping = [RKObjectMapping mappingForClass:[Hourly class]];
    [hourlyMapping addAttributeMappingsFromArray:@[@"summary", @"icon", @"data"]];
    
    RKObjectMapping *minutelyMapping = [RKObjectMapping mappingForClass:[Minutely class]];
    [minutelyMapping addAttributeMappingsFromArray:@[@"summary", @"icon", @"data"]];
    
    // Define the relationship mapping for nested objects
    [dailyMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"data"
                                                                                 toKeyPath:@"data"
                                                                               withMapping:dailyDataMapping]];
    
    [forecastMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"hourly"
                                                                                    toKeyPath:@"hourly"
                                                                                  withMapping:hourlyMapping]];

    [forecastMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"daily"
                                                                                    toKeyPath:@"daily"
                                                                                  withMapping:dailyMapping]];
    
    [forecastMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"currently"
                                                                                    toKeyPath:@"currently"
                                                                                  withMapping:currentlyMapping]];
    
    [forecastMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"minutely"
                                                                                    toKeyPath:@"minutely"
                                                                                  withMapping:minutelyMapping]];
    
    [forecastMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"flags"
                                                                                    toKeyPath:@"flags"
                                                                                  withMapping:flagsMapping]];
    return forecastMapping;
}

- (void)displayForecast:(Forecast *)forecast {
    self.currentTemperatureLabel.text = [NSString stringWithFormat:@"%.0f\u00B0", forecast.currently.temperature];
    self.tableData = forecast.daily.data;
    [self.tableView reloadData];
}

- (NSString *)getDayName:(int)index {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = index;
    NSDate *nextDate = [calendar dateByAddingComponents:dayComponent toDate:[NSDate date] options:0];
    NSDateComponents *weekdayComponents =[calendar components:NSWeekdayCalendarUnit fromDate:nextDate];
    
    int day = (int)[weekdayComponents weekday] % 7;
//    if (day == 0) {
//        day = 7; // handle Saturday weirdness
//    }
    
    switch(day) {
        case 0:
            return @"Sun";
        case 1:
            return @"Mon";
        case 2:
            return @"Tue";
        case 3:
            return @"Wed";
        case 4:
            return @"Thu";
        case 5:
            return @"Fri";
        case 6:
            return @"Sat";
    }
    return @"";
}

@end
