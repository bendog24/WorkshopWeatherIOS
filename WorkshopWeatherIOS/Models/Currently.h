//
//  Currently.h
//
//  Created by Ben Jakuben on 6/13/14
//  Copyright (c) 2014 Treehouse. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Currently : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double temperature;
@property (nonatomic, assign) double windSpeed;
@property (nonatomic, assign) double humidity;
@property (nonatomic, assign) double windBearing;
@property (nonatomic, assign) double cloudCover;
@property (nonatomic, assign) double time;
@property (nonatomic, assign) double dewPoint;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, assign) double precipIntensity;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, assign) double visibility;
@property (nonatomic, assign) double nearestStormBearing;
@property (nonatomic, assign) double apparentTemperature;
@property (nonatomic, assign) double pressure;
@property (nonatomic, assign) double precipProbability;
@property (nonatomic, assign) double nearestStormDistance;
@property (nonatomic, assign) double ozone;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
