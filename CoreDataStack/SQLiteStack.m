//
//  SQLiteStack.m
//  CoreDataStack
//
//  Created by Alex Zgurskiy on 12.07.16.
//  Copyright © 2016 Alex Zgurskiy. All rights reserved.
//

#import "SQLiteStack.h"
#import <CoreData/CoreData.h>
#import <macros_blocks/macros_blocks.h>

static NSString * const SQLiteStackModelNotFound = @"Could not find a model with this name.";
static NSString * const SQLiteStackStoreURLIsNotFolder = @"Store URL should be a folder.";
static NSString * const SQLiteStackStoreURLNotExist = @"Store URL not exist";
static NSString * const SQLiteStackIsNotConfigured = @"Database stack is not configured";

NSString * const SQLiteStackDidConfiguredNotification = @"SQLiteStackDidConfiguredNotification";

@interface SQLiteStack ()

@property (strong, nonatomic) NSManagedObjectModel *objectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *storeCoordinator;

@property (strong, nonatomic) NSManagedObjectContext *writeContext;
@property (strong, nonatomic) NSManagedObjectContext *mainContext;

@property (assign, nonatomic) BOOL isConfigured;

@end

@implementation SQLiteStack

#pragma mark Instance shared methods

+ (instancetype)defaultStack {
    static SQLiteStack *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super alloc] init];
    });
    return instance;
}

#pragma mark Configure methods

- (void)configureStackWithModelName:(NSString *)modelName
                           inBundle:(NSBundle *)bundle
                       withStoreURL:(NSURL *)storeURL
                     withCompletion:(void (^ _Nullable)(void))completion {
    
    BOOL isDirectory;
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:storeURL.relativePath isDirectory:&isDirectory];
    BOOL modelExists = [bundle URLForResource:modelName withExtension:@"momd"] != nil;
    
    NSAssert(modelExists == YES, SQLiteStackModelNotFound);
    NSAssert(fileExists == YES, SQLiteStackStoreURLNotExist);
    NSAssert(isDirectory == YES, SQLiteStackStoreURLIsNotFolder);
    
    NSURL *modelURL = [bundle URLForResource:modelName withExtension:@"momd"];
    self.objectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @(YES),
                              NSInferMappingModelAutomaticallyOption: @(YES)};
    
    NSURL *storeFileURL = storeURL;
    storeFileURL = [storeFileURL URLByAppendingPathComponent:modelName];
    storeFileURL = [storeFileURL URLByAppendingPathExtension:@"sqlite"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error;
        
        self.storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.objectModel];
        [self.storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeFileURL options:options error:&error];
        
        self.isConfigured = error == nil;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSAssert(error == nil, @"%@", error);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:SQLiteStackDidConfiguredNotification object:self];
            safe_block(completion);
        });
    });
}

#pragma mark Getter methods

- (NSManagedObjectContext *)writeContext {
    NSAssert(self.isConfigured == YES, SQLiteStackIsNotConfigured);
    
    if (_writeContext == nil) {
        _writeContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        _writeContext.persistentStoreCoordinator = self.storeCoordinator;
    }
    return _writeContext;
}

- (NSManagedObjectContext *)mainContext {
    NSAssert(self.isConfigured == YES, SQLiteStackIsNotConfigured);
    
    if (_mainContext == nil) {
        _mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _mainContext.parentContext = self.writeContext;
    }
    return _mainContext;
}

- (NSManagedObjectContext *)privateContext {
    NSAssert(self.isConfigured == YES, SQLiteStackIsNotConfigured);
    
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.parentContext = self.mainContext;
    return context;
}

@end
