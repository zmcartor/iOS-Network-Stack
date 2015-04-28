//
//  TheNetwork.h
//  iOSNetworkStack
//
//  Created by Zach McArtor on 4/27/15.
//  Copyright (c) 2015 HackaZach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TheNetwork : NSObject

// returning an NSOperation allows it to be cancelled if need be
- (NSOperation *)whatsMyIP:(void (^)(NSString *ip))completion;


@end
