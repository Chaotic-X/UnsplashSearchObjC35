//
//  AXLPhoto.h
//  UnsplashSearchObjC35
//
//  Created by Alex Lundquist on 8/13/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXLPhoto : NSObject

@property (nonatomic, copy, readonly)NSString * thumb;
@property (nonatomic, copy, readonly)NSString * regular;
@property (nonatomic, copy, readonly)NSString * firstName;
@property (nonatomic, copy, readonly)NSString * lastName;
@property (nonatomic, copy, readonly)NSString * fullDescription;
@property (nonatomic, copy, readonly)NSString * altDescription;

- (instancetype) initWithThumb:(NSString *)thumb
                       regular:(NSString *)regluar
                     firstName:(NSString *)firstName
                      lastName:(NSString *)lastName
               fullDescription:(NSString *)fullDescriptino
                altDescription:(NSString *)altDescription;
@end

@interface AXLPhoto (JSONCovertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end
NS_ASSUME_NONNULL_END
