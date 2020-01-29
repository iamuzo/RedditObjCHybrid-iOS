//
//  MySimpleRedditPostController.h
//  RedditObjC
//
//  Created by Uzo on 1/28/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MySimpleRedditPost;

NS_ASSUME_NONNULL_BEGIN

@interface MySimpleRedditPostController : NSObject


//first add Global Shared Instance
//-(instancetype)sharedInstance;
+ (MySimpleRedditPostController *)sharedInstance;

//Next go get our information
- (void)searchForPostWithSearchTerm:(NSString *)searchTerm
                         completion:(void (^) (NSArray<MySimpleRedditPost *> *posts,
                                               NSError * _Nullable error))completion;

- (void)fetchImageForPost:(MySimpleRedditPost *)post completion:(void (^) (UIImage * _Nullable))completion;
@end

NS_ASSUME_NONNULL_END
