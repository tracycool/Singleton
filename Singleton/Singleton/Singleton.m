//
//  Singleton.m
//  OnePass
//
//  Created by Tina on 15/6/18.
//  Copyright (c) 2015年 Elite. All rights reserved.
//

#import "Singleton.h"

static NSMutableDictionary *classNameToSharedInstanceMapping;

@interface Singleton () <NSCopying>

@end

@implementation Singleton

+ (id)sharedInstance {
    static NSString *anObj = @"anObj";
    
    id instance = nil;
    
    @synchronized(anObj) {
        if (classNameToSharedInstanceMapping == nil) {
            classNameToSharedInstanceMapping = [NSMutableDictionary dictionary];
        }
    
        NSString *className = NSStringFromClass(self);
        instance = classNameToSharedInstanceMapping[className];
        if (instance == nil) {
            instance = [[super allocWithZone:NULL] initPrivately];
            classNameToSharedInstanceMapping[className] = instance;
            [instance sharedInstanceInitializer];
        }
    }
    
    return instance;
}

- (id)init {
    return [self.class sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [self sharedInstance];
}

#pragma mark - Private
- (id)initPrivately {
    self = [super init];
    return self;
}

#pragma mark - Override point
- (void)sharedInstanceInitializer {
    //
}

@end
