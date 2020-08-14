//
//  AXLUnsplash.h
//  UnsplashSearchObjC35
//
//  Created by Alex Lundquist on 8/13/20.
//

#import <Foundation/Foundation.h>
#import "AXLPhoto.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXLUnsplash : NSObject

@property (nonatomic, copy, readonly)NSArray<AXLPhoto *> * results;

- (instancetype) initWithResults:(NSArray<AXLPhoto *> *)results;

@end

@interface AXLUnsplash (JSONConvertable)

- (instancetype) initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
