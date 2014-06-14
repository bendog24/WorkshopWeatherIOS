//
//  Minutely.m
//
//  Created by Ben Jakuben on 6/13/14
//  Copyright (c) 2014 Treehouse. All rights reserved.
//

#import "Minutely.h"
#import "DailyData.h"


NSString *const kMinutelySummary = @"summary";
NSString *const kMinutelyIcon = @"icon";
NSString *const kMinutelyData = @"data";


@interface Minutely ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Minutely

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
            self.summary = [self objectOrNilForKey:kMinutelySummary fromDictionary:dict];
            self.icon = [self objectOrNilForKey:kMinutelyIcon fromDictionary:dict];
    NSObject *receivedData = [dict objectForKey:kMinutelyData];
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
    [mutableDict setValue:self.summary forKey:kMinutelySummary];
    [mutableDict setValue:self.icon forKey:kMinutelyIcon];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kMinutelyData];

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

    self.summary = [aDecoder decodeObjectForKey:kMinutelySummary];
    self.icon = [aDecoder decodeObjectForKey:kMinutelyIcon];
    self.data = [aDecoder decodeObjectForKey:kMinutelyData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_summary forKey:kMinutelySummary];
    [aCoder encodeObject:_icon forKey:kMinutelyIcon];
    [aCoder encodeObject:_data forKey:kMinutelyData];
}

- (id)copyWithZone:(NSZone *)zone
{
    Minutely *copy = [[Minutely alloc] init];
    
    if (copy) {

        copy.summary = [self.summary copyWithZone:zone];
        copy.icon = [self.icon copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
