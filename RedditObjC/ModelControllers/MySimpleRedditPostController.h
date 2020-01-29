//
//  MySimpleRedditPostController.h
//  RedditObjC
//
//  Created by Uzo on 1/28/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MySimpleRedditPost;

NS_ASSUME_NONNULL_BEGIN

@interface MySimpleRedditPostController : NSObject


//first add Global Shared Instance
+ (MySimpleRedditPostController *)sharedInstance;

//Next go get our information
- (void)searchForPostWithSearchTerm:(NSString *)searchTerm
                         completion:(void (^) (NSArray<MySimpleRedditPost *> *posts, NSError * _Nullable error))completion;
@end

NS_ASSUME_NONNULL_END
