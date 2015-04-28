//
//  ExampleNetworkJob.m
//  iOSNetworkStack
//
//  Created by Zach McArtor on 4/27/15.
//  Copyright (c) 2015 HackaZach. All rights reserved.
//

#import "ExampleNetworkJob.h"

@interface ExampleNetworkJob ()

@property (nonatomic, strong) void (^completion)(NSString *ip);

@end

@implementation ExampleNetworkJob


- (instancetype)initWithCompletionHandler:(void (^)(NSString *))completion {
    self = [super init];
    if (self){
        self.completion = completion;
    }
    return self;
}

// Entry Point for NSOperation
- (void)main {

    NSURL *url = [NSURL URLWithString:@"http://jsonip.com"];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
   
    //keep the job around long enough for async network call to return. dispatch_groups are semaphores which block until
    // the amount of enters == leaves
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    
    __block typeof(self) blockSelf = self;
    [[session dataTaskWithURL:url completionHandler:^(NSData *data,
                                                      NSURLResponse *response,
                                                      NSError *inError){
        NSError *error;
        NSDictionary *ipDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        if(blockSelf.completion){
            blockSelf.completion(ipDict[@"ip"]);
        }
    
        dispatch_group_leave(group);
    }] resume];
   
    // wait 20secs for dispatch_group semaphore to open
    dispatch_time_t const NETWORK_TIMEOUT = NSEC_PER_SEC * 20;
    dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, NETWORK_TIMEOUT));
}
@end
