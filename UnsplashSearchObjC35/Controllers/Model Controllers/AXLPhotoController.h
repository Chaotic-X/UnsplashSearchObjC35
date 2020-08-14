//
//  AXLPhotoController.h
//  UnsplashSearchObjC35
//
//  Created by Alex Lundquist on 8/13/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AXLUnsplash.h"
#import "AXLPhoto.h"


NS_ASSUME_NONNULL_BEGIN

@interface AXLPhotoController : NSObject

+(instancetype)sharedInstance;

-(void)fetchSearchResults:(NSString *)searchTerm completion:(void(^) (NSArray<AXLPhoto *> * _Nullable results, NSError *_Nullable error))completion;

-(void)fetchThumbImage:(AXLPhoto *)photo completion:(void(^) (UIImage * _Nullable))completion;


@end

NS_ASSUME_NONNULL_END
