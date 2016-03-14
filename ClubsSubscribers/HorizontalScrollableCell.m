//
//  HorizontalScrollableCell.m
//  Events 3.0
//
//  Created by Daniel on 20/11/15.
//  Copyright © 2015 World Economic Forum. All rights reserved.
//

#import "HorizontalScrollableCell.h"
#import "Utils.h"
#import "DMSubscriber.h"
#define kMainBlueColor 0x5699fd
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green: ((float)((rgbValue & 0xFF00) >> 8))/255.0  blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define TAG_IDIOT_VIEW_TO_REMOVE_IF_EXIST 564 //this actualy is a safe net and will not be used in practice
@implementation HorizontalScrollableCell

+ (NSString *)cellIdentifier
{
   return   @"horizontalScrollableCellIdentifier";
}

+ (NSString *)cellNibName {
    return NSStringFromClass([self class]);
}

- (void)configureWithObject:(DMCellDetailsObject *)cellDetailsObject
{
    NSArray *tagsArray = [cellDetailsObject.titleKey componentsSeparatedByString:TAGS_SEPARATOR];
    [self configureWithWithTagsArray:tagsArray];
}

- (void )configureWithWithTagsArray:(NSArray *)topicsArray
{
    //this will not happen in practice, but in theory mah have a chance to happen. So it's better to be safe
    UIView *existingContainerIFAny = [self.containerScrollView viewWithTag:TAG_IDIOT_VIEW_TO_REMOVE_IF_EXIST];
    if (existingContainerIFAny && [existingContainerIFAny superview]) {
        [existingContainerIFAny removeFromSuperview];
    }
    
    NSMutableArray *buttonsArrayInOrder = [[NSMutableArray alloc] init];
    
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1700, self.containerScrollView.frame.size.height)];
    containerView.tag = TAG_IDIOT_VIEW_TO_REMOVE_IF_EXIST;
    containerView.backgroundColor = [UIColor clearColor];
    
    int padddingHoriz = 5;
    int startingWidth = 10;
    int paddingY = 10;
    int leftRightButtonPadding = 10;
    
    UIFont *fontUsed = [UIFont fontWithName:@"AvenirNext-Medium" size:14];
    
    
    for (int i = 0; i < [topicsArray count]; i++) {
        
        startingWidth += padddingHoriz;
        
        NSString *aTopic =   [topicsArray objectAtIndex:i];
        
        UILabel *aLabel = [[UILabel alloc] init];
        aLabel.textAlignment = NSTextAlignmentCenter;
        aLabel.font = fontUsed;
        
        CGSize textSize = [self sizeForLabel:aLabel text:aTopic font:fontUsed color:UIColorFromRGB(kMainBlueColor)];
        int widthForButton = textSize.width + 2* leftRightButtonPadding;
        
        [aLabel setFrame:CGRectMake(startingWidth, paddingY, widthForButton, 24)];
        
        aLabel.layer.borderWidth = 1.0f;
        aLabel.layer.borderColor = UIColorFromRGB(kMainBlueColor).CGColor;
        aLabel.layer.cornerRadius = 4.0f;
        aLabel.layer.masksToBounds = YES;
        [buttonsArrayInOrder addObject:aLabel];
        
        [containerView addSubview:aLabel];
        
        startingWidth += widthForButton;
        
    }
    
    startingWidth+= 15;
    
    [containerView setFrame:CGRectMake(0, 0, startingWidth, self.containerScrollView.frame.size.height)];
    
    
    [self.containerScrollView addSubview:containerView];
    [self .containerScrollView setContentSize:CGSizeMake(containerView.frame.size.width, containerView.frame.size.height)];
    
}

-(CGSize)sizeForLabel:(UILabel *)theLabel text:(NSString *)theText font:(UIFont*)font color:(UIColor *)theColor
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:theText attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:theColor}];
    
    [theLabel setAttributedText:attributedText];
    CGSize labelSize = [theLabel sizeThatFits:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    return labelSize;
}



@end
