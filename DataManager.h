//
//  DataManager.h
//  Interoperability
//
//  Created by Yohsuke Yamakawa on 1/27/16.
//  Copyright © 2016 DigitalCrafts. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShoppingItem;
@interface DataManager : NSObject

+ (DataManager *)sharedManager;
- (ShoppingItem *) createNewItemWithName:(NSString *)name description:(NSString *)desc category:(NSString *)category price: (NSNumber *)number;

- (void) getShoppingItemWithName:(NSString *)name completed:(void (^)(ShoppingItem *item, NSError *error))completionBlock;

- (void) getShoppingListWithCompletionBlock:(void (^)(NSArray *items, NSError *error)) completionBlock;

@end