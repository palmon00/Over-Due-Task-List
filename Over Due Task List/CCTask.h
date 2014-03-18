//
//  CCTask.h
//  Over Due Task List
//
//  Created by Raymond Louie on 3/17/14.
//  Copyright (c) 2014 Raymond Louie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCTask : NSObject

// definitive initializer
-(instancetype)initWithData:(NSDictionary *)data;

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *details;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) BOOL completion;

@end
