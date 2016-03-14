//
//  SubscribersTableViewCell.m
//  ClubsSubscribers
//
//  Created by Daniel Mihai on 13/03/16.
//  Copyright © 2016 Daniel Mihai. All rights reserved.
//

#import "SubscribersTableViewCell.h"

@interface SubscribersTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *isActiveView;

@end

@implementation SubscribersTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)cellIdentifier
{
    return @"subscribersCellIdentifier";
}
+ (NSString *)cellNibName
{
    return @"SubscribersTableViewCell";
}

- (void) configureWithName:(NSString *)name isActive:(BOOL)isActive
{
    self.nameLabel.text = name;
    if (isActive) {
        self.isActiveView.backgroundColor = [UIColor greenColor];
    }else
    {
        self.isActiveView.backgroundColor = [UIColor redColor];
    }    
}


- (void)configureWithObject:(DMCellDetailsObject *)cellDetailsObject
{
    [self configureWithName:cellDetailsObject.titleKey isActive:[cellDetailsObject.valueKey boolValue]];
}

@end
