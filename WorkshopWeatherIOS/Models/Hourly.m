//
//  Hourly.m
//
//  Created by Ben Jakuben on 6/13/14
//  Copyright (c) 2014 Treehouse. All rights reserved.
//

#import "Hourly.h"
#import "DailyData.h"


NSString *const kHourlySummary = @"summary";
NSString *const kHourlyIcon = @"icon";
NSString *const kHourlyData = @"data";


@interface Hourly ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Hourly

@synthesize summary = _summary;
@synthesize icon = _icon;
@synthesize data = _data;


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
            self.summary = [self objectOrNilForKey:kHourlySummary fromDictionary:dict];
            self.icon = [self objectOrNilForKey:kHourlyIcon fromDictionary:dict];
    NSObject *receivedData = [dict objectForKey:kHourlyData];
    NSMutableArray *parsedData = [NSMutableArray array];
    if ([receivedData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedData addObject:[DailyData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedData isKindOfClass:[NSDictionary class]]) {
       [parsedData addObject:[DailyData modelObjectWithDictionary:(NSDictionary *)receivedData]];
    }

    self.data = [NSArray arrayWithArray:parsedData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.summary forKey:kHourlySummary];
    [mutableDict setValue:self.icon forKey:kHourlyIcon];
    NSMutableArray *tempArrayForData = [NSMutableArray array];
    for (NSObject *subArrayObject in self.data) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForData addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForData addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kHourlyData];

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

    self.summary = [aDecoder decodeObjectForKey:kHourlySummary];
    self.icon = [aDecoder decodeObjectForKey:kHourlyIcon];
    self.data = [aDecoder decodeObjectForKey:kHourlyData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_summary forKey:kHourlySummary];
    [aCoder encodeObject:_icon forKey:kHourlyIcon];
    [aCoder encodeObject:_data forKey:kHourlyData];
}

- (id)copyWithZone:(NSZone *)zone
{
    Hourly *copy = [[Hourly alloc] init];
    
    if (copy) {

        copy.summary = [self.summary copyWithZone:zone];
        copy.icon = [self.icon copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
