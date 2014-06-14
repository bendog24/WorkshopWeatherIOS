//
//  Alerts.m
//
//  Created by Ben Jakuben on 6/13/14
//  Copyright (c) 2014 Treehouse. All rights reserved.
//

#import "Alerts.h"


NSString *const kAlertsTime = @"time";
NSString *const kAlertsTitle = @"title";
NSString *const kAlertsDescription = @"description";
NSString *const kAlertsExpires = @"expires";
NSString *const kAlertsUri = @"uri";


@interface Alerts ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Alerts

@synthesize time = _time;
@synthesize title = _title;
@synthesize alertsDescription = _alertsDescription;
@synthesize expires = _expires;
@synthesize uri = _uri;


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
            self.time = [[self objectOrNilForKey:kAlertsTime fromDictionary:dict] doubleValue];
            self.title = [self objectOrNilForKey:kAlertsTitle fromDictionary:dict];
            self.alertsDescription = [self objectOrNilForKey:kAlertsDescription fromDictionary:dict];
            self.expires = [[self objectOrNilForKey:kAlertsExpires fromDictionary:dict] doubleValue];
            self.uri = [self objectOrNilForKey:kAlertsUri fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.time] forKey:kAlertsTime];
    [mutableDict setValue:self.title forKey:kAlertsTitle];
    [mutableDict setValue:self.alertsDescription forKey:kAlertsDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.expires] forKey:kAlertsExpires];
    [mutableDict setValue:self.uri forKey:kAlertsUri];

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

    self.time = [aDecoder decodeDoubleForKey:kAlertsTime];
    self.title = [aDecoder decodeObjectForKey:kAlertsTitle];
    self.alertsDescription = [aDecoder decodeObjectForKey:kAlertsDescription];
    self.expires = [aDecoder decodeDoubleForKey:kAlertsExpires];
    self.uri = [aDecoder decodeObjectForKey:kAlertsUri];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_time forKey:kAlertsTime];
    [aCoder encodeObject:_title forKey:kAlertsTitle];
    [aCoder encodeObject:_alertsDescription forKey:kAlertsDescription];
    [aCoder encodeDouble:_expires forKey:kAlertsExpires];
    [aCoder encodeObject:_uri forKey:kAlertsUri];
}

- (id)copyWithZone:(NSZone *)zone
{
    Alerts *copy = [[Alerts alloc] init];
    
    if (copy) {

        copy.time = self.time;
        copy.title = [self.title copyWithZone:zone];
        copy.alertsDescription = [self.alertsDescription copyWithZone:zone];
        copy.expires = self.expires;
        copy.uri = [self.uri copyWithZone:zone];
    }
    
    return copy;
}


@end
