//
//  AXLUnsplash.m
//  UnsplashSearchObjC35
//
//  Created by Alex Lundquist on 8/13/20.
//

#import "AXLUnsplash.h"
#import "AXLPhoto.h"
@implementation AXLUnsplash

- (instancetype)initWithResults:(NSArray<AXLPhoto * > *)results
{
    self = [super init];
    if (self){
        _results = results;
    }
    return self;
}

@end

@implementation AXLUnsplash (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSArray * results = dictionary[@"results"];
    return [self initWithResults:results];
}

@end
