//
//  MySimpleRedditPost.m
//  RedditObjC
//
//  Created by Uzo on 1/28/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

#import "MySimpleRedditPost.h"

@implementation MySimpleRedditPost

-(instancetype)initWithTitle:(NSString *)title
                         ups:(NSInteger)ups
                commentCount:(NSNumber *)commentCount
{
    self = [super init];
    if (self) {
        _title = [title copy];
        _ups = ups ;
        _commentCount = [commentCount copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    //Get each post from the data key in the dictionary that was passed into the function
    NSDictionary *dataDictionary = dictionary[@"data"];
    
    //When you are insdied the inner-most dataDictionary, which
    //holds the object you want to initialize, that is when you
    //define your properties that come from the JSON
    NSString *title = dataDictionary[@"title"];
    NSInteger ups = [dataDictionary[[MySimpleRedditPost ups]] intValue];
    NSNumber *commentCount = dataDictionary[[MySimpleRedditPost commentCountKey]];
    
    return [self initWithTitle:title ups:ups commentCount:commentCount];
}

// MARK: - Keys
+ (NSString *)ups
{
    return @"ups";
}


+ (NSString *)commentCountKey
{
    return @"num_communts";
}

@end
