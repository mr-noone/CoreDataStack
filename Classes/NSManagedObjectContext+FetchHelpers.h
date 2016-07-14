//
//  NSManagedObjectContext+FetchHelpers.h
//  CoreDataStack
//
//  Created by Alex Zgurskiy on 12.07.16.
//  Copyright © 2016 Alex Zgurskiy. All rights reserved.
//

#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSManagedObjectContext (FetchHelpers)

- (NSArray *)fetchObjectsWithEntityName:(NSString *)entityName
                    withSortDescriptors:(NSArray * _Nullable)sortDescriptors
                          withPredicate:(NSPredicate * _Nullable)predicate
                             fetchError:(NSError ** _Nullable)error;

- (NSUInteger)fetchObjectsCountWithEntityName:(NSString *)entityName
                          withSortDescriptors:(NSArray * _Nullable)sortDescriptors
                                withPredicate:(NSPredicate * _Nullable)predicate
                                   fetchError:(NSError ** _Nullable)error;

@end

NS_ASSUME_NONNULL_END
