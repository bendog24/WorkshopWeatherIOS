//
//  Alerts.h
//
//  Created by Ben Jakuben on 6/13/14
//  Copyright (c) 2014 Treehouse. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Alerts : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double time;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *alertsDescription;
@property (nonatomic, assign) double expires;
@property (nonatomic, strong) NSString *uri;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
