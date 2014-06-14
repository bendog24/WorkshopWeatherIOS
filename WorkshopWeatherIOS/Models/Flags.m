//
//  Flags.m
//
//  Created by Ben Jakuben on 6/13/14
//  Copyright (c) 2014 Treehouse. All rights reserved.
//

#import "Flags.h"


NSString *const kFlagsDarkskyStations = @"darksky-stations";
NSString *const kFlagsMadisStations = @"madis-stations";
NSString *const kFlagsLampStations = @"lamp-stations";
NSString *const kFlagsUnits = @"units";
NSString *const kFlagsIsdStations = @"isd-stations";
NSString *const kFlagsSources = @"sources";


@interface Flags ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Flags

@synthesize darkskyStations = _darkskyStations;
@synthesize madisStations = _madisStations;
@synthesize lampStations = _lampStations;
@synthesize units = _units;
@synthesize isdStations = _isdStations;
@synthesize sources = _sources;


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
            self.darkskyStations = [self objectOrNilForKey:kFlagsDarkskyStations fromDictionary:dict];
            self.madisStations = [self objectOrNilForKey:kFlagsMadisStations fromDictionary:dict];
            self.lampStations = [self objectOrNilForKey:kFlagsLampStations fromDictionary:dict];
            self.units = [self objectOrNilForKey:kFlagsUnits fromDictionary:dict];
            self.isdStations = [self objectOrNilForKey:kFlagsIsdStations fromDictionary:dict];
            self.sources = [self objectOrNilForKey:kFlagsSources fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForDarkskyStations = [NSMutableArray array];
    for (NSObject *subArrayObject in self.darkskyStations) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForDarkskyStations addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForDarkskyStations addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForDarkskyStations] forKey:kFlagsDarkskyStations];
    NSMutableArray *tempArrayForMadisStations = [NSMutableArray array];
    for (NSObject *subArrayObject in self.madisStations) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForMadisStations addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForMadisStations addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMadisStations] forKey:kFlagsMadisStations];
    NSMutableArray *tempArrayForLampStations = [NSMutableArray array];
    for (NSObject *subArrayObject in self.lampStations) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForLampStations addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForLampStations addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForLampStations] forKey:kFlagsLampStations];
    [mutableDict setValue:self.units forKey:kFlagsUnits];
    NSMutableArray *tempArrayForIsdStations = [NSMutableArray array];
    for (NSObject *subArrayObject in self.isdStations) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForIsdStations addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForIsdStations addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForIsdStations] forKey:kFlagsIsdStations];
    NSMutableArray *tempArrayForSources = [NSMutableArray array];
    for (NSObject *subArrayObject in self.sources) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSources addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSources addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSources] forKey:kFlagsSources];

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

    self.darkskyStations = [aDecoder decodeObjectForKey:kFlagsDarkskyStations];
    self.madisStations = [aDecoder decodeObjectForKey:kFlagsMadisStations];
    self.lampStations = [aDecoder decodeObjectForKey:kFlagsLampStations];
    self.units = [aDecoder decodeObjectForKey:kFlagsUnits];
    self.isdStations = [aDecoder decodeObjectForKey:kFlagsIsdStations];
    self.sources = [aDecoder decodeObjectForKey:kFlagsSources];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_darkskyStations forKey:kFlagsDarkskyStations];
    [aCoder encodeObject:_madisStations forKey:kFlagsMadisStations];
    [aCoder encodeObject:_lampStations forKey:kFlagsLampStations];
    [aCoder encodeObject:_units forKey:kFlagsUnits];
    [aCoder encodeObject:_isdStations forKey:kFlagsIsdStations];
    [aCoder encodeObject:_sources forKey:kFlagsSources];
}

- (id)copyWithZone:(NSZone *)zone
{
    Flags *copy = [[Flags alloc] init];
    
    if (copy) {

        copy.darkskyStations = [self.darkskyStations copyWithZone:zone];
        copy.madisStations = [self.madisStations copyWithZone:zone];
        copy.lampStations = [self.lampStations copyWithZone:zone];
        copy.units = [self.units copyWithZone:zone];
        copy.isdStations = [self.isdStations copyWithZone:zone];
        copy.sources = [self.sources copyWithZone:zone];
    }
    
    return copy;
}


@end
