//
//  MySimpleRedditPost.h
//  RedditObjC
//
//  Created by Uzo on 1/28/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MySimpleRedditPost : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, readonly) NSInteger ups;
@property (nonatomic, readonly) NSNumber *commentCount;
@property (nonatomic, readonly) NSString *thumbnail;
/// NSInterger is good for Mathematical operations (use primitives)
/// if just getting information that is integer, use NSNumber

- (instancetype)initWithTitle:(NSString *)title
                           ups:(NSInteger)ups
                    thumbnail:(NSString *)thumbnail
                 commentCount:(NSNumber *)commentCount;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END
