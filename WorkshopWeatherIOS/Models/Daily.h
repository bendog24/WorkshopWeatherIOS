//
//  Daily.h
//
//  Created by Ben Jakuben on 6/13/14
//  Copyright (c) 2014 Treehouse. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Daily : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSArray *data;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
