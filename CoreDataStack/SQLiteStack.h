//
//  SQLiteStack.h
//  CoreDataStack
//
//  Created by Alex Zgurskiy on 12.07.16.
//  Copyright © 2016 Alex Zgurskiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSManagedObjectModel;
@class NSManagedObjectContext;

NS_ASSUME_NONNULL_BEGIN

extern NSString * const SQLiteStackDidConfiguredNotification;

@interface SQLiteStack : NSObject

+ (instancetype)defaultStack;
- (void)configureStackWithModelName:(NSString *)modelName
                           inBundle:(NSBundle *)bundle
                       withStoreURL:(NSURL *)storeURL
                     withCompletion:(void(^ _Nullable)(void))completion;

@property (strong, nonatomic, readonly) NSManagedObjectModel *objectModel;
@property (strong, nonatomic, readonly) NSManagedObjectContext *mainContext;

- (NSManagedObjectContext *)privateContext;

@end

NS_ASSUME_NONNULL_END
