//
//  NSManagedObjectContext+SaveHelpers.h
//  CoreDataStack
//
//  Created by Alex Zgurskiy on 12.07.16.
//  Copyright © 2016 Alex Zgurskiy. All rights reserved.
//

#import <CoreData/CoreData.h>

typedef void(^ContextSaveCompletion)(NSError *error);

@interface NSManagedObjectContext (SaveHelpers)

- (void)saveContext:(ContextSaveCompletion)completion;
- (void)saveContextToStore:(ContextSaveCompletion)completion;

- (void)saveContextAndWait:(NSError **)error;
- (void)saveContextToStoreAndWait:(NSError **)error;

@end
