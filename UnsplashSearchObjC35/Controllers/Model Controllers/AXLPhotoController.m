//
//  AXLPhotoController.m
//  UnsplashSearchObjC35
//
//  Created by Alex Lundquist on 8/13/20.
//

#import "AXLPhotoController.h"

//URL I am building - including searchTerm
//https://api.unsplash.com/search/photos?client_id=ZqGLzwM5ForhU4hk76q-_55PDwEZuwsJ5Uq_QDOeIKo&count=10&query=Castle
//static let baseURL = "https://api.unsplash.com/search/photos"
//static let clientID = "ZqGLzwM5ForhU4hk76q-_55PDwEZuwsJ5Uq_QDOeIKo"
static NSString * const baseURL = @"https://api.unsplash.com/search/photos";
static NSString * const clientID = @"ZqGLzwM5ForhU4hk76q-_55PDwEZuwsJ5Uq_QDOeIKo";

@implementation AXLPhotoController

+ (instancetype)sharedInstance
{
    static AXLPhotoController * sharedInstace = nil;
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        sharedInstace = [AXLPhotoController new];
    });
    return sharedInstace;
}

-(void)fetchSearchResults:(NSString *)searchTerm completion:(void(^) (NSArray<AXLPhoto * > * _Nullable photos, NSError *_Nullable error))completion;
{
    NSURL * url = [NSURL URLWithString:baseURL];
    
    NSMutableArray<NSURLQueryItem *> * queryItems = [NSMutableArray new];
    NSURLQueryItem * clientIDQuery = [[NSURLQueryItem alloc] initWithName:@"client_id" value:clientID];
    NSURLQueryItem * photoCountQuery = [[NSURLQueryItem alloc] initWithName:@"count" value:@"10"];
    NSURLQueryItem * searchItemQuery = [[NSURLQueryItem alloc] initWithName:@"query" value:searchTerm];
    [queryItems addObject:clientIDQuery];
    [queryItems addObject:photoCountQuery];
    [queryItems addObject:searchItemQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:true];
    [urlComponents setQueryItems:queryItems];
    
    NSURL * finalURL = [urlComponents URL];
    [[[NSURLSession sharedSession]dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if (error) {
            NSLog(@"There was an errro in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil, error);
            return;
        }
        if (response) {
            NSLog(@"%@", response);
        }
        NSDictionary *topLevelDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSDictionary<NSString *, id> * resultsLevelJSON = topLevelDict[@"results"];
        NSMutableArray * arrayOfPhotos = [NSMutableArray new];
        for (NSMutableDictionary * resultsDictionary in resultsLevelJSON) {
            NSLog(@"dictionary data %@",resultsDictionary);
            AXLPhoto * photo = [[AXLPhoto alloc] initWithDictionary:resultsDictionary];
            [arrayOfPhotos addObject:photo];
        }
        completion(arrayOfPhotos, nil);
    }]resume];
} //End of fetchSearchResults

- (void)fetchThumbImage:(AXLPhoto *)photo completion:(void (^)(UIImage * _Nullable))completion
{
    if ([photo.thumb isKindOfClass:[NSString class]])
    {
    NSURL * imageURL = [NSURL URLWithString:photo.thumb];
    [[[NSURLSession sharedSession]dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"There was an errro in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        if (response) {
            NSLog(@"%@", response);
        }
        if (data) {
            UIImage * image = [UIImage imageWithData:data];
            completion(image);
        }
    }]resume];
    } else {
        UIImage * image = [UIImage imageNamed:@"noimage"];
        completion(image);
    }
} //End of fetchImage
- (void)fetchRegularImage:(AXLPhoto *)photo completion:(void (^)(UIImage * _Nullable))completion
{
    NSURL * imageURL = [NSURL URLWithString:photo.regular];
    [[[NSURLSession sharedSession]dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"There was an errro in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        if (response) {
            NSLog(@"%@", response);
        }
        if (data) {
            UIImage * image = [UIImage imageWithData:data];
            completion(image);
        }
    }]resume];
}

@end
