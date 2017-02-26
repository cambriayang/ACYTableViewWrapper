//
//  AnotherDemoTableRow.m
//  ACYTableViewWrapper
//
//  Created by CambriaYang on 19/02/2017.
//  Copyright © 2017 yeio. All rights reserved.
//

#import "AnotherDemoTableRow.h"

NSString *const AnotherDemoTableRowAnimation = @"AnotherDemoTableRowAnimation";

@implementation AnotherDemoTableRow

- (UITableViewCell *)createCellForAutoAdjustedTableViewCell {
    AnotherDemoTableViewCell *cell = [[AnotherDemoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self reuseIdentifier]];
    
    //Or
//    AnotherDemoTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"AnotherDemoTableViewCell" owner:nil options:nil] objectAtIndex:0];
    
    return cell;
}

- (UITableViewCell *)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    AnotherDemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self reuseIdentifier]];
    
    if (cell == nil) {
        cell = (AnotherDemoTableViewCell *)[self createCellForAutoAdjustedTableViewCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (NSString *)reuseIdentifier {
    static NSString *identifier = @"AnotherDemoTableViewCell";
    
    return identifier;
}

- (BOOL)autoAdjustCellHeight {
    return YES;
}

- (void)updateCell:(AnotherDemoTableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    [cell updateText:self.state];
}

@end


@interface AnotherDemoTableViewCell ()

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *labe12;

@end

@implementation AnotherDemoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initView];
    }
    
    return self;
}

- (void)initView {
    self.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *label1 = [[UILabel alloc] init];
    
    [self.contentView addSubview:label1];
    _label1 = label1;
    
    label1.text = @"anotherdemolabel1";
    label1.numberOfLines = 0;
    label1.preferredMaxLayoutWidth = 300.0f;
    label1.backgroundColor = [UIColor darkGrayColor];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10.0f);
        make.leading.equalTo(self.contentView.mas_leading).offset(50.0f);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    
    [self.contentView addSubview:label2];
    _labe12 = label2;
    
    label2.text = @"anotherdemolabel2";
    label2.numberOfLines = 0;
    label2.preferredMaxLayoutWidth = 300.0f;
    label2.backgroundColor = [UIColor darkGrayColor];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(5.0f);
        make.leading.equalTo(self.contentView.mas_leading).offset(35.0f);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10.0f);
    }];
}

- (void)updateText:(ACYTableRowState)state {
    if (state == ACYTableRowStateDefault) {
        _label1.text = @"anotherdemolabel1anotherdemolabel1anotherdemolabel1anotherdemolabel1anotherdemolabel1anotherdemolabel1anotherdemolabel1anotherdemolabel1anotherdemolabel1anotherdemolabel1anotherdemolabel1anotherdemolabel1anotherdemolabel1anotherdemolabel1anotherdemolabel1";
        _labe12.text = @"anotherdemolabel2anotherdemolabel2anotherdemolabel2anotherdemolabel2anotherdemolabel2anotherdemolabel2anotherdemolabel2anotherdemolabel2anotherdemolabel2anotherdemolabel2anotherdemolabel2anotherdemolabel2anotherdemolabel2anotherdemolabel2anotherdemolabel2";
    } else {
        _label1.text = @"anotherdemolabel1";
        _labe12.text = @"anotherdemolabel2";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
