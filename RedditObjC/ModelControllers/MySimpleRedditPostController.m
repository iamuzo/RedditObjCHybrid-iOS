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
- (NSURL *)baseURL
{
    return [NSURL URLWithString:@"https://reddit.com/r/"];
}

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
    NSURL *searchURL = [self baseURL];
    searchURL = [searchURL URLByAppendingPathComponent:searchTerm];
    searchURL = [searchURL URLByAppendingPathExtension:@"json"];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:searchURL
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
    
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]]) {
        NSLog(@"Error with jsonDictionary: %@", error);
        completion(nil, error);
        return;
    }
    
    NSDictionary *redditPostDictionaries = jsonDictionary[@"data"];
    NSArray *childrenArray = redditPostDictionaries[@"children"];
    
    //we need to return an array of Reddit Posts
    NSMutableArray *arrayOfRedditPosts = [NSMutableArray array];
    
    for (NSDictionary *dataDictionary in childrenArray) {
        MySimpleRedditPost *post = [[MySimpleRedditPost alloc] initWithDictionary:dataDictionary];
        [arrayOfRedditPosts addObject:post];
    }
    completion(arrayOfRedditPosts, nil);
    
    }] resume];
}
@end
