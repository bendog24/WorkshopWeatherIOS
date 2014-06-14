//
//  Forecast.h
//
//  Created by Ben Jakuben on 6/13/14
//  Copyright (c) 2014 Treehouse. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Hourly, Daily, Currently, Minutely, Flags;

@interface Forecast : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *alerts;
@property (nonatomic, assign) double offset;
@property (nonatomic, assign) double longitude;
@property (nonatomic, strong) Hourly *hourly;
@property (nonatomic, strong) Daily *daily;
@property (nonatomic, strong) NSString *timezone;
@property (nonatomic, assign) double latitude;
@property (nonatomic, strong) Currently *currently;
@property (nonatomic, strong) Minutely *minutely;
@property (nonatomic, strong) Flags *flags;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
