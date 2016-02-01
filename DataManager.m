//
//  DataManager.m
//  Interoperability
//
//  Created by Yohsuke Yamakawa on 1/27/16.
//  Copyright © 2016 DigitalCrafts. All rights reserved.
//

#import "DataManager.h"
#import "Interoperability-Swift.h"

@interface DataManager()

@property (nonatomic, weak) NSManagedObjectContext *context;

@end

@implementation DataManager
- (instancetype)init {
    self = [super init];
    if (self) {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        self.context = delegate.managedObjectContext;
    }
    return self;
}
+ (DataManager *)sharedManager {
    static DataManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [DataManager new];
    });
    return instance;
}
- (ShoppingItem *) createNewItemWithName:(NSString *)name description:(NSString *)desc category:(NSString *)category price:(NSNumber *)number {
    
    ShoppingItem *item = (ShoppingItem *)[NSEntityDescription insertNewObjectForEntityForName:@"ShoppingItem" inManagedObjectContext:self.context];
    
    item.itemName = name;
    item.itemDescription = desc;
    item.category = category;
    item.price = number;
    NSError *error;
    [self.context save:&error];
    if (error != nil) {
        item = nil;
        NSLog(@"Failed to save Shopping Item:%@",
              error.description);
    }
    return item;
}
- (void) getShoppingItemWithName:(NSString *)name completed:(void (^)(ShoppingItem *item, NSError *error))completionBlock {
    NSFetchRequest *request = [[NSFetchRequest
                                alloc]initWithEntityName:@"ShoppingItem"];
    NSPredicate *predicate = [NSPredicate
                              predicateWithFormat:@"itemName CONTAINS %@", name];
    request.predicate = predicate;
    NSError *error;
    NSArray *results = [self.context executeFetchRequest:request
                                                   error:&error];
    if (error != nil) {
        NSLog(@"Failed to fetch Shopping Item:%@",
              error.description);
        if (completionBlock) {
            completionBlock(nil, error);
        }
    }
    else {
        if (results.count > 0 && completionBlock) {
            completionBlock(results[0], nil);
        }
    }
}
- (void) getShoppingListWithCompletionBlock:(void (^)(NSArray
                                                      *items, NSError *error)) completionBlock {
    NSFetchRequest *request = [[NSFetchRequest
                                alloc]initWithEntityName:@"ShoppingItem"];
    NSError *error;
    NSArray *results = [self.context executeFetchRequest:request
                                                   error:&error];
    if (error != nil) {
        NSLog(@"Failed to fetch Shopping Item:%@",
              error.description);
        if (completionBlock) {
            completionBlock(nil, error);
        }
    }
    else {
        if (results.count > 0 && completionBlock) {
            completionBlock(results, nil);
        }
    }
}
@end
