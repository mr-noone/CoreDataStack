//
//  NSManagedObjectContext+FetchHelpers.m
//  CoreDataStack
//
//  Created by Alex Zgurskiy on 12.07.16.
//  Copyright © 2016 Alex Zgurskiy. All rights reserved.
//

#import "NSManagedObjectContext+FetchHelpers.h"

@implementation NSManagedObjectContext (FetchHelpers)

- (NSArray *)fetchObjectsWithEntityName:(NSString *)entityName
                    withSortDescriptors:(NSArray *)sortDescriptors
                          withPredicate:(NSPredicate *)predicate
                             fetchError:(NSError **)error {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    fetchRequest.sortDescriptors = sortDescriptors;
    fetchRequest.predicate = predicate;
    return [self executeFetchRequest:fetchRequest error:error];
}

- (NSUInteger)fetchObjectsCountWithEntityName:(NSString *)entityName
                          withSortDescriptors:(NSArray *)sortDescriptors
                                withPredicate:(NSPredicate *)predicate
                                   fetchError:(NSError **)error {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entityName];
    fetchRequest.resultType = NSCountResultType;
    fetchRequest.sortDescriptors = sortDescriptors;
    fetchRequest.predicate = predicate;
    return [self countForFetchRequest:fetchRequest error:error];
}

@end
