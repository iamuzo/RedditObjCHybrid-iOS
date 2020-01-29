//
//  MySimpleRedditPostController.m
//  RedditObjC
//
//  Created by Uzo on 1/28/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

#import "MySimpleRedditPostController.h"
#import "MySimpleRedditPost.h"


@implementation MySimpleRedditPostController

// MARK: - Properties
static NSString *const baseURL = @"https://reddit.com";
static NSString *const rComponentString = @"r";
static NSString *const jsonExtension = @"json";

+ (MySimpleRedditPostController *)sharedInstance
{
    static MySimpleRedditPostController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
                  sharedInstance = [MySimpleRedditPostController new];
    });
    return sharedInstance;
}

- (void)searchForPostWithSearchTerm:(NSString *)searchTerm completion:(void (^)(NSArray<MySimpleRedditPost *> *, NSError *))completion
{
    
    NSURL * url = [NSURL URLWithString:baseURL];
    NSURL * rURL = [url URLByAppendingPathComponent:rComponentString];
    NSURL * searchURL = [rURL URLByAppendingPathComponent:searchTerm];
    NSURL * finalURL = [searchURL URLByAppendingPathExtension:jsonExtension];
    NSLog(@"this is the finalURL: %@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL
                                 completionHandler:^(NSData * data,
                                                     NSURLResponse * response,
                                                     NSError * error)
    {
        if (error) {
            NSLog(@"Error fetching reddit post from server: %@", error);
            completion(nil, error);
            return;
        }
        
        if (!data) {
            NSLog(@"Error fetching reddit post DATA using search term: %@", error);
            completion(nil, error);
            return;
        }
    
    NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (!topLevelDictionary || ![topLevelDictionary isKindOfClass:[NSDictionary class]]) {
        NSLog(@"Error with topLevelDictionary: %@", error);
        completion(nil, error);
        return;
    }
    
    NSDictionary *redditDataDictionary = topLevelDictionary[@"data"];
    NSArray *childrenArray = redditDataDictionary[@"children"];
    
    //we need to return an array of Reddit Posts
    NSMutableArray *arrayOfRedditPosts = [NSMutableArray array];
    
    for (NSDictionary *dataDictionary in childrenArray) {
        MySimpleRedditPost *post = [[MySimpleRedditPost alloc] initWithDictionary:dataDictionary];
        [arrayOfRedditPosts addObject:post];
    }
    
//    if (arrayOfRedditPosts.count != 0) {
//        //MySimpleRedditPostController.sharedInstance.posts  = arrayOfRedditPosts
//        //completion(true);
//    } else {
//        //completion(false)
//    }
    
    //if I add the if else above then comment this out 
    completion(arrayOfRedditPosts, nil);
    
    }] resume];
}

- (void)fetchImageForPost:(MySimpleRedditPost *)post completion:(void (^)(UIImage * _Nullable))completion

{
    // if url then fetch
    // else return default image
    NSString *imageURL = post.thumbnail;
    
    
    if ([imageURL  isEqual: @"default"]) {
        //I want to display a default image. For now
        //using a system image but will change later
        //maybe another fetch to unsplash api
        UIImage *image = [UIImage systemImageNamed:@"rays"];
        completion(image);
    } else {
        NSURL *fetchImageURL = [NSURL URLWithString:imageURL];
        NSLog(@"This is the fetchImageURL: %@", fetchImageURL);
        
        [[[NSURLSession sharedSession] dataTaskWithURL:fetchImageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            //handle error
            if (error) {
                
                NSLog(@"Error fetching reddit post from server: %@", error);
                completion(nil); return;
            }
            
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                completion(image);
            } else {
                // this is where you display a default image
                UIImage *image = [UIImage systemImageNamed:@"rays"];
                completion(image);
            }
        }] resume];
    }
}
@end
