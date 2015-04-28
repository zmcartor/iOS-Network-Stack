//
//  ExampleNetworkJob.h
//  iOSNetworkStack
//
//  Created by Zach McArtor on 4/27/15.
//  Copyright (c) 2015 HackaZach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExampleNetworkJob : NSOperation

- (instancetype)initWithCompletionHandler:(void(^)(NSString * ip))completion;


@end
