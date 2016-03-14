//
//  TitleTextTableViewCell.m
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import "TitleTextTableViewCell.h"

@interface TitleTextTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *boldTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *normalTextLabel;
@end

@implementation TitleTextTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithTitle:(NSString *)title andText:(NSString *)text
{
    self.boldTitleLabel.text = title;
    self.normalTextLabel.text = text;
}

+ (NSString *)cellIdentifier
{
    return @"titleTextCellIdentifier";
}
+ (NSString *)cellNibName
{
    return @"TitleTextTableViewCell";
}

- (void)configureWithObject:(DMCellDetailsObject *)cellDetailsObject
{
    [self configureWithTitle:cellDetailsObject.titleKey andText:cellDetailsObject.valueKey];
}



@end
