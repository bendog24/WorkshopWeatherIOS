//
//  Forecast.m
//
//  Created by Ben Jakuben on 6/13/14
//  Copyright (c) 2014 Treehouse. All rights reserved.
//

#import "Forecast.h"
#import "Alerts.h"
#import "Hourly.h"
#import "Daily.h"
#import "Currently.h"
#import "Minutely.h"
#import "Flags.h"


NSString *const kForecastAlerts = @"alerts";
NSString *const kForecastOffset = @"offset";
NSString *const kForecastLongitude = @"longitude";
NSString *const kForecastHourly = @"hourly";
NSString *const kForecastDaily = @"daily";
NSString *const kForecastTimezone = @"timezone";
NSString *const kForecastLatitude = @"latitude";
NSString *const kForecastCurrently = @"currently";
NSString *const kForecastMinutely = @"minutely";
NSString *const kForecastFlags = @"flags";


@interface Forecast ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Forecast

@synthesize alerts = _alerts;
@synthesize offset = _offset;
@synthesize longitude = _longitude;
@synthesize hourly = _hourly;
@synthesize daily = _daily;
@synthesize timezone = _timezone;
@synthesize latitude = _latitude;
@synthesize currently = _currently;
@synthesize minutely = _minutely;
@synthesize flags = _flags;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedAlerts = [dict objectForKey:kForecastAlerts];
    NSMutableArray *parsedAlerts = [NSMutableArray array];
    if ([receivedAlerts isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedAlerts) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedAlerts addObject:[Alerts modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedAlerts isKindOfClass:[NSDictionary class]]) {
       [parsedAlerts addObject:[Alerts modelObjectWithDictionary:(NSDictionary *)receivedAlerts]];
    }

    self.alerts = [NSArray arrayWithArray:parsedAlerts];
            self.offset = [[self objectOrNilForKey:kForecastOffset fromDictionary:dict] doubleValue];
            self.longitude = [[self objectOrNilForKey:kForecastLongitude fromDictionary:dict] doubleValue];
            self.hourly = [Hourly modelObjectWithDictionary:[dict objectForKey:kForecastHourly]];
            self.daily = [Daily modelObjectWithDictionary:[dict objectForKey:kForecastDaily]];
            self.timezone = [self objectOrNilForKey:kForecastTimezone fromDictionary:dict];
            self.latitude = [[self objectOrNilForKey:kForecastLatitude fromDictionary:dict] doubleValue];
            self.currently = [Currently modelObjectWithDictionary:[dict objectForKey:kForecastCurrently]];
            self.minutely = [Minutely modelObjectWithDictionary:[dict objectForKey:kForecastMinutely]];
            self.flags = [Flags modelObjectWithDictionary:[dict objectForKey:kForecastFlags]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForAlerts = [NSMutableArray array];
    for (NSObject *subArrayObject in self.alerts) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForAlerts addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForAlerts addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForAlerts] forKey:kForecastAlerts];
    [mutableDict setValue:[NSNumber numberWithDouble:self.offset] forKey:kForecastOffset];
    [mutableDict setValue:[NSNumber numberWithDouble:self.longitude] forKey:kForecastLongitude];
    [mutableDict setValue:[self.hourly dictionaryRepresentation] forKey:kForecastHourly];
    [mutableDict setValue:[self.daily dictionaryRepresentation] forKey:kForecastDaily];
    [mutableDict setValue:self.timezone forKey:kForecastTimezone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.latitude] forKey:kForecastLatitude];
    [mutableDict setValue:[self.currently dictionaryRepresentation] forKey:kForecastCurrently];
    [mutableDict setValue:[self.minutely dictionaryRepresentation] forKey:kForecastMinutely];
    [mutableDict setValue:[self.flags dictionaryRepresentation] forKey:kForecastFlags];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.alerts = [aDecoder decodeObjectForKey:kForecastAlerts];
    self.offset = [aDecoder decodeDoubleForKey:kForecastOffset];
    self.longitude = [aDecoder decodeDoubleForKey:kForecastLongitude];
    self.hourly = [aDecoder decodeObjectForKey:kForecastHourly];
    self.daily = [aDecoder decodeObjectForKey:kForecastDaily];
    self.timezone = [aDecoder decodeObjectForKey:kForecastTimezone];
    self.latitude = [aDecoder decodeDoubleForKey:kForecastLatitude];
    self.currently = [aDecoder decodeObjectForKey:kForecastCurrently];
    self.minutely = [aDecoder decodeObjectForKey:kForecastMinutely];
    self.flags = [aDecoder decodeObjectForKey:kForecastFlags];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_alerts forKey:kForecastAlerts];
    [aCoder encodeDouble:_offset forKey:kForecastOffset];
    [aCoder encodeDouble:_longitude forKey:kForecastLongitude];
    [aCoder encodeObject:_hourly forKey:kForecastHourly];
    [aCoder encodeObject:_daily forKey:kForecastDaily];
    [aCoder encodeObject:_timezone forKey:kForecastTimezone];
    [aCoder encodeDouble:_latitude forKey:kForecastLatitude];
    [aCoder encodeObject:_currently forKey:kForecastCurrently];
    [aCoder encodeObject:_minutely forKey:kForecastMinutely];
    [aCoder encodeObject:_flags forKey:kForecastFlags];
}

- (id)copyWithZone:(NSZone *)zone
{
    Forecast *copy = [[Forecast alloc] init];
    
    if (copy) {

        copy.alerts = [self.alerts copyWithZone:zone];
        copy.offset = self.offset;
        copy.longitude = self.longitude;
        copy.hourly = [self.hourly copyWithZone:zone];
        copy.daily = [self.daily copyWithZone:zone];
        copy.timezone = [self.timezone copyWithZone:zone];
        copy.latitude = self.latitude;
        copy.currently = [self.currently copyWithZone:zone];
        copy.minutely = [self.minutely copyWithZone:zone];
        copy.flags = [self.flags copyWithZone:zone];
    }
    
    return copy;
}


@end
