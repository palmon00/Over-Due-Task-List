//
//  CCTask.m
//  Over Due Task List
//
//  Created by Raymond Louie on 3/17/14.
//  Copyright (c) 2014 Raymond Louie. All rights reserved.
//

#import "CCTask.h"

@implementation CCTask

-(instancetype)init
{
    self = [self initWithData:@{}];
    return self;
}

-(instancetype)initWithData:(NSDictionary *)data
{
    self = [super init];
    
    if (self) {
        self.title = data[TITLE];
        self.details = data[DETAILS];
        self.date = data[DATE];
        self.completion = [data[COMPLETION] boolValue];
    }
    
    return self;
}

@end
