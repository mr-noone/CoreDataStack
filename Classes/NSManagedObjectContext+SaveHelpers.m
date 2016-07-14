//
//  NSManagedObjectContext+SaveHelpers.m
//  CoreDataStack
//
//  Created by Alex Zgurskiy on 12.07.16.
//  Copyright © 2016 Alex Zgurskiy. All rights reserved.
//

#import "NSManagedObjectContext+SaveHelpers.h"
#import <macros_blocks/macros_blocks.h>

@implementation NSManagedObjectContext (SaveHelpers)

- (void)saveContext:(ContextSaveCompletion)completion {
    [self performBlock:^{
        if (self.hasChanges == NO) {
            main_queue_block(completion, nil);
            return;
        }
        
        NSError *error;
        [self save:&error];
        main_queue_block(completion, error);
    }];
}

- (void)saveContextToStore:(ContextSaveCompletion)completion {
    [self performBlock:^{
        if (self.hasChanges == NO) {
            main_queue_block(completion, nil);
            return;
        }
        
        NSError *error;
        [self save:&error];
        
        if (self.parentContext != nil && error == nil)
            [self.parentContext saveContext:completion];
        else
            main_queue_block(completion, error);
    }];
}

- (void)saveContextAndWait:(NSError **)error {
    __block NSError *saveError;
    
    [self performBlockAndWait:^{
        if (self.hasChanges == NO) {
            saveError = nil;
            return;
        }
        
        [self save:&saveError];
    }];
    
    if (error != nil)
        *error = saveError;
}

- (void)saveContextToStoreAndWait:(NSError **)error {
    __block NSError *saveError;
    
    [self performBlockAndWait:^{
        if (self.hasChanges == NO) {
            saveError = nil;
            return;
        }
        
        [self save:&saveError];
        
        if (self.parentContext != nil && saveError == nil)
            [self.parentContext saveContextToStoreAndWait:&saveError];
    }];
    
    if (error != nil)
        *error = saveError;
}

@end
