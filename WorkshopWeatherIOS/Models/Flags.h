//
//  Flags.h
//
//  Created by Ben Jakuben on 6/13/14
//  Copyright (c) 2014 Treehouse. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Flags : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *darkskyStations;
@property (nonatomic, strong) NSArray *madisStations;
@property (nonatomic, strong) NSArray *lampStations;
@property (nonatomic, strong) NSString *units;
@property (nonatomic, strong) NSArray *isdStations;
@property (nonatomic, strong) NSArray *sources;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
