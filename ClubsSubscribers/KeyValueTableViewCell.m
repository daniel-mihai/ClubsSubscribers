//
//  KeyValueTableViewCell.m
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import "KeyValueTableViewCell.h"
@interface KeyValueTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *keyLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end

@implementation KeyValueTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void) configureWithKey:(NSString *)key andValue:(NSString *)value
{
    self.keyLabel.text = key;
    self.valueLabel.text = value;
}

+ (NSString *)cellIdentifier
{
    return @"keyValueCellIdentifier";
}
+ (NSString *)cellNibName
{
    return @"KeyValueTableViewCell";
}

- (void)configureWithObject:(DMCellDetailsObject *)cellDetailsObject
{
    [self configureWithKey:cellDetailsObject.titleKey andValue:cellDetailsObject.valueKey];
}


@end
