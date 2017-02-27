//
//  ACYTableSection.m
//  ACYTableViewWrapper
//
//  Created by CambriaYang on 16/9/18.
//  Copyright © 2016年 yeio. All rights reserved.
//

#import "ACYTableSection.h"

#import "ACYTableRow.h"

@interface ACYTableSection ()

@property(nonatomic, strong) id content;
@property(nonatomic, assign) ACYTableSectionContentType contentType;
@property (nonatomic, copy, nullable) NSString *title;

@end

@implementation ACYTableSection

#pragma mark --- Life Cycle

- (instancetype)init {
    return [self initWithTitle:@""];
}

+ (ACYTableSection *)sectionWithTitle:(NSString *)title {
    return [[ACYTableSection alloc] initWithTitle:title];
}

+ (ACYTableSection *)sectionWithImage:(UIImage *)image {
    return [[ACYTableSection alloc] initWithImage:image];
}

+ (ACYTableSection *)sectionWithCustomView:(UIView *)view {
    return [[ACYTableSection alloc] initWithCustomView:view];
}

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    
    if (self) {
        [self commonInit];
        self.content = title;
        self.contentType = ACYTableSectionContentTypeTitle;
        self.headerHeight = title.length == 0 ? CGFLOAT_MIN : 32.0;
        self.title = title;
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        self.content = image;
        self.contentType = ACYTableSectionContentTypeImage;
        self.headerHeight = image.size.height;
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCustomView:(UIView *)customView {
    self = [super init];
    if (self) {
        UITableViewHeaderFooterView *headerView = [[UITableViewHeaderFooterView alloc] init];
        
        customView.frame = headerView.contentView.frame;
        
        [headerView.contentView addSubview:customView];
        
        self.content = headerView;
        self.contentType = ACYTableSectionContentTypeCustomView;
        self.headerHeight = CGRectGetHeight(customView.frame);
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.headerHeight = CGFLOAT_MIN;
    self.footerHeight = CGFLOAT_MIN;
}

#pragma mark --- Header & Footer
- (UITableViewHeaderFooterView *)viewForTableView:(UITableView *)tableView {
    UITableViewHeaderFooterView *view = nil;
    
    if (self.content) {
        if (self.contentType == ACYTableSectionContentTypeCustomView) {
            return self.content;
        }
        
        NSString *reuseIdentifier = @"";
        
        if (self.contentType == ACYTableSectionContentTypeTitle) {
            reuseIdentifier = @"ACYTableSectionTitleIdentifier";
        }
        else if (self.contentType == ACYTableSectionContentTypeImage) {
            reuseIdentifier = @"ACYTableSectionImageIdentifier";
        }
        
        view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
        if (view == nil) {
            view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:reuseIdentifier];
        }
        
        view.textLabel.text = self.content;
    }
    
    return view;
}

- (UITableViewHeaderFooterView *)viewForHeaderInTableView:(UITableView *)tableView section:(NSInteger)section {
    UITableViewHeaderFooterView *view = [self viewForTableView:tableView];
    
    if (self.sectionClickEvent) {
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSection:)];
        
        [view addGestureRecognizer:ges];
    }
    
    return view;
}

- (UITableViewHeaderFooterView *)viewForFooterInTableView:(UITableView *)tableView section:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    
}

- (CGFloat)heightForHeaderInTableView:(UITableView *)tableView inSection:(NSInteger)section {
    return self.headerHeight;
}

- (CGFloat)heightForFooterInTableView:(UITableView *)tableView inSection:(NSInteger)section {
    return self.footerHeight;
}

#pragma mark --- Row Event
- (NSArray *)allRows {
    return [self children];
}

- (void)setAllRows:(NSArray <__kindof ACYNode *> *)rows {
    [self setChildren:rows];
}

- (void)addRow:(ACYTableRow *)item {
    [self addChild:item];
}

- (void)addChild:(ACYTableRow *)node {
    if ([node isKindOfClass:[ACYTableRow class]]) {
        [node rowWillAddToSection:self];
    }
    
    [super addChild:node];
    
    if ([node isKindOfClass:[ACYTableRow class]]) {
        [node rowDidAddToSection:self];
    }
}

- (void)addRowsFromArray:(NSArray <__kindof ACYNode *> *)array {
    [self addChildFromArray:array];
}

- (ACYTableRow *)rowAtIndex:(NSUInteger)index {
    return [self.children objectOrNilAtIndex:index];
}

- (NSUInteger)section {
    return [self nodeIndex];
}

- (CGFloat)height {
    return self.headerHeight;
}

- (void)setHeight:(CGFloat)height {
    self.headerHeight = height;
}

- (void)loadDataIfneeded {
    
}

#pragma mark --- Gesture
- (void)tapSection:(UITapGestureRecognizer *)ges {
    self.sectionClickEvent(self);
}

@end
