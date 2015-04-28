//
//  TheNetwork.m
//  iOSNetworkStack
//
//  Created by Zach McArtor on 4/27/15.
//  Copyright (c) 2015 HackaZach. All rights reserved.
//

#import "TheNetwork.h"
#import "ExampleNetworkJob.h";

@interface TheNetwork ()

@property (nonatomic, strong) NSOperationQueue *foregroundQueue;
@property (nonatomic, strong) NSOperationQueue *backgroundQueue;

@end

@implementation TheNetwork

- (instancetype)init {
    self = [super init];
    if (self){
        
        // Two queues to separate long running background ops from faster foreground ops
        self.foregroundQueue = [[NSOperationQueue alloc] init];
        [self.foregroundQueue setSuspended:NO];
        
        self.backgroundQueue = [[NSOperationQueue alloc] init];
        [self.backgroundQueue setSuspended:NO];
       
        // These values can be whatever makes sense to your application
        [self.foregroundQueue setMaxConcurrentOperationCount:4];
        [self.backgroundQueue setMaxConcurrentOperationCount:2];
    }
    return self;
}

- (void)haltNetwork {
    [self.foregroundQueue setSuspended:YES];
    [self.backgroundQueue setSuspended:YES];
}

- (void) resumeNetwork {
    [self.foregroundQueue setSuspended:NO];
    [self.backgroundQueue setSuspended:NO];
}

- (void)scheduleOperation:(NSOperation *)operation withPriority:(NSOperationQueuePriority)priority {
    NSOperationQueue *queue = (priority == NSOperationQueuePriorityVeryLow || priority == NSOperationQueuePriorityLow || priority == NSOperationQueuePriorityNormal ) ? self.backgroundQueue : self.foregroundQueue;
    operation.queuePriority = priority;
    [queue addOperation:operation];
}

#pragma mark - network jobs

- (NSOperation *)whatsMyIP:(void (^)(NSString *))completion {
    ExampleNetworkJob *job = [[ExampleNetworkJob alloc] initWithCompletionHandler:completion];
    [self scheduleOperation:job withPriority:NSOperationQueuePriorityVeryHigh];
    return job;
}

@end
