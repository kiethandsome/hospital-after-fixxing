//
//  HLTableView.m
//  HLTableView
//
//  Created by HaoLe on 7/24/17.
//  Copyright © 2017 HaoLe. All rights reserved.
//

#import "HLTableView.h"

@interface HLTableView()<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) HLTableViewSection *defaultSection;
@property (nonatomic, strong) NSMutableDictionary *mapping;


@end


@implementation HLTableView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.dataSource = self;
    self.delegate = self;
    _defaultSection = [HLTableViewSection new];
    _source = [[NSMutableArray alloc] initWithObjects:_defaultSection, nil];
    _mapping = [NSMutableDictionary new];
}

- (void)registerCell:(Class)cellClass forModel:(Class)modelClass {
    if ([cellClass isSubclassOfClass:[HLTableViewCell class]]) {
        NSString *reuseIdentifier = [(id)cellClass reuseIdentifier];
        id cell = [self dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (cell == nil) {
            _mapping[NSStringFromClass(modelClass)] = cellClass;
            UINib *nib = [(id)cellClass nib];
            if (nib != nil) {
                [self registerNib:nib forCellReuseIdentifier:reuseIdentifier];
            } else {
                [self registerClass:cellClass forCellReuseIdentifier:reuseIdentifier];
            }
        }
    }
}

- (id)itemAtIndexPath:(NSIndexPath*)indexPath {
    return [_source[indexPath.section] items][indexPath.row];
}

- (void)insertItem:(NSObject*)item atIndex:(NSInteger)index {
    [_defaultSection.items insertObject:item atIndex:index];
    [self reloadData];
}

- (void)insertItems:(NSArray*)items atIndexSet:(NSIndexSet*)atIndexSet {
    [_defaultSection.items insertObjects:items atIndexes:atIndexSet];
    [self reloadData];
}

- (void)removeItem:(NSObject*)item withAnimation:(UITableViewRowAnimation)animation {
    if ([_defaultSection.items containsObject:item]) {
        NSUInteger index = [_defaultSection.items indexOfObject:item];
        [_defaultSection.items removeObjectAtIndex:index];
        [self deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:animation];
    }
}

- (void)addItems:(NSArray*)items {
    [_defaultSection.items addObjectsFromArray:items];
    [self reloadData];
}

- (void)clear {
    for (HLTableViewSection *section in _source) {
        [section clear];
    }
    [self reloadData];
}

- (NSInteger)numberOfItems {
    return _defaultSection.items.count;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _source.count;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_source[section] headerTitle];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [_source[section] headerHeight];
}

- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [_source[section] footerTitle];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [_source[section] footerHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_source[section] items].count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = [_source[indexPath.section] items][indexPath.row];
    id cellClass = _mapping[NSStringFromClass([model class])];
    NSString *reuseIdentifier = [cellClass reuseIdentifier];
    
    if (reuseIdentifier != nil) {
        HLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        [cell configureCell:model];
        if (_onCellAtIndexPath) {
            _onCellAtIndexPath(indexPath);
        }
        return cell;
    }
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = [_source[indexPath.section] items][indexPath.row];
    if (_onDidSelectItem) {
        _onDidSelectItem(model, indexPath);
    }
}


@end
