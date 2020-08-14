//
//  AXLPhoto.m
//  UnsplashSearchObjC35
//
//  Created by Alex Lundquist on 8/13/20.
//

#import "AXLPhoto.h"

@implementation AXLPhoto

- (instancetype)initWithThumb:(NSString *)thumb regular:(NSString *)regluar firstName:(NSString *)firstName lastName:(NSString *)lastName fullDescription:(NSString *)fullDescriptino altDescription:(NSString *)altDescription
{
    self = [super init];
    if (self){
        _thumb = thumb;
        _regular = regluar;
        _firstName = firstName;
        _lastName = lastName;
        _fullDescription = fullDescriptino;
        _altDescription = altDescription;
    }
    return self;
}
@end

@implementation AXLPhoto (JSONCovertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *fullDescription = dictionary[@"description"];
    NSString *altDescription = dictionary[@"alt_description"];
    NSDictionary *urlsDictionary = dictionary[@"urls"];
    NSString *regular = urlsDictionary[@"regular"];
    NSString *thumb = urlsDictionary[@"thumb"];
    NSDictionary *userDictionary = dictionary[@"user"];
    NSString * firstName = userDictionary[@"first_name"];
    NSString * lastName = userDictionary[@"last_name"];
    
    return [self initWithThumb:thumb regular:regular firstName:firstName lastName:lastName fullDescription:fullDescription altDescription:altDescription];
}

@end
