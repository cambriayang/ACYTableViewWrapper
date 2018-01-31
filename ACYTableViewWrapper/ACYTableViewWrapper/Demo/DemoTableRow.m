//
//  MyTableRow.m
//  ACYTableViewWrapper
//
//  Created by yeyang on 2017/2/17.
//  Copyright © 2017年 yeio. All rights reserved.
//

#import "DemoTableRow.h"

@implementation DemoTableRow

- (UITableViewCell *)createCellForAutoAdjustedTableViewCell {
    DemoTableViewCell *cell = [[DemoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self reuseIdentifier]];
    
    //Or
//    DemoTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"DemoTableViewCell" owner:nil options:nil] objectAtIndex:0];
    
    return cell;
}

- (UITableViewCell *)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    DemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self reuseIdentifier]];
    
    if (cell == nil) {
        cell = (DemoTableViewCell *)[self createCellForAutoAdjustedTableViewCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (NSString *)reuseIdentifier {
    static NSString *identifier = @"DemoTableViewCell";
    
    return identifier;
}

- (BOOL)autoAdjustCellHeight {
    return YES;
}

//- (CGFloat)cellHeight {
//    return 200.0;
//}

- (void)updateCell:(DemoTableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
}

@end


@implementation DemoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initView];
    }
    
    return self;
}

- (void)initView {    
    UILabel *label1 = [[UILabel alloc] init];
    
    [self.contentView addSubview:label1];
    
    label1.text = @"demolabel1";
    label1.numberOfLines = 0;
    label1.preferredMaxLayoutWidth = 200.0f;
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10.0f);
        make.leading.equalTo(self.contentView.mas_leading).offset(35.0f);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    
    [self.contentView addSubview:label2];
    
    label2.numberOfLines = 0;
    label2.preferredMaxLayoutWidth = 200.0f;
    
    label2.text = @"demolabel2";
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(5.0f);
        make.leading.equalTo(self.contentView.mas_leading).offset(50.0f);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10.0f);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
