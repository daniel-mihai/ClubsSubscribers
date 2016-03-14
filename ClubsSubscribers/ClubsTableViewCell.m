//
//  ClubsTableViewCell.m
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import "ClubsTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface ClubsTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subscribersLabel;

@end

@implementation ClubsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) configureWithName:(NSString *)name subscribers:(int)subscribers
{
    self.nameLabel.text = name;
    self.subscribersLabel.text = [NSString stringWithFormat:@"%d", subscribers];
}

+ (NSString *)cellIdentifier
{
    return @"clubsCellIdentifier";
}
+ (NSString *)cellNibName
{
    return @"ClubsTableViewCell";
}





@end
