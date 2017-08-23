//
//  HLTableView.h
//  HLTableView
//
//  Created by HaoLe on 7/24/17.
//  Copyright © 2017 HaoLe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLTableViewSection.h"
#import "HLTableViewCell.h"


typedef void (^HLTableViewOnSignalBlock)(NSString *name, NSObject *associatedObject);
typedef void (^HLTableViewOnDidSelectItem)(id item, NSIndexPath *indexPath);
typedef void (^HLTableViewOnCellAtIndexPath)(NSIndexPath *indexPath);


@interface HLTableView : UITableView


@property (nonatomic, copy) HLTableViewOnSignalBlock onSignal;
@property (nonatomic, copy) HLTableViewOnDidSelectItem onDidSelectItem;
@property (nonatomic, copy) HLTableViewOnCellAtIndexPath onCellAtIndexPath;
@property (nonatomic, strong) NSMutableArray *source;
@property (nonatomic, assign) NSInteger total;

- (void)registerCell:(Class)cellClass forModel:(Class)modelClass;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

- (void)insertItem:(NSObject *)item atIndex:(NSInteger)index;

- (void)insertItems:(NSArray *)items atIndexSet:(NSIndexSet*)atIndexSet;

- (void)removeItem:(NSObject *)item withAnimation:(UITableViewRowAnimation)animation;

- (void)addItems:(NSArray *)items;

- (void)clear;

- (NSInteger)numberOfItems;


@end
