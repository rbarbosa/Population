//
//  CHCountryTableViewCell.m
//  Population
//
//  Created by Rui Pedro Barbosa on 04/04/15.
//  Copyright (c) 2015 Rui Barbosa. All rights reserved.
//

#import "CHCountryTableViewCell.h"

#import "CHCountry.h"


@interface CHCountryTableViewCell ()

@property (nonatomic, strong) UILabel *countryNameLabel;
@property (nonatomic, strong) UILabel *countryPopulationLabel;
@property (nonatomic, strong) UILabel *countryRankLabel;
@property (nonatomic, strong) UIImageView *countryFlagImageView;

@property (nonatomic, strong) NSArray *views;
@property (nonatomic, strong) NSDictionary *viewsDictionary;

@end



@implementation CHCountryTableViewCell


#pragma mark - Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.countryNameLabel = [self getCountryNameLabel];
        self.countryPopulationLabel = [self getCoutryPopulationLabel];
        self.countryRankLabel = [self getCountryRankLabel];
        self.countryFlagImageView = [self getCountryImageView];
        
        [self createArrayWithViews];
        [self addViewsToCell];
        
        [self removeAutoConstraints];

        [self createViewsDictionary];
        
        [self cellAutolayout];
    }
    
    return self;
}



#pragma mark - set up cell with country

- (void)setUpWithCountry:(CHCountry *)country
{
    NSLog(@"COuntry: %@", country);
    self.countryNameLabel.text = country.name;
    
    // Test
    self.countryPopulationLabel.text = @"123,456,789";
    self.countryRankLabel.text = @"10";
    self.countryFlagImageView.image = [UIImage imageNamed:@"Apple-icon"];

}



#pragma mark - Set up labels and image view

- (UILabel *)getCountryNameLabel
{
    UILabel *nameLabel = [[UILabel alloc] init];
    
    nameLabel.font            = [UIFont fontWithName:@"HelveticaNeue" size:25.0f];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor       = [UIColor darkGrayColor];
    nameLabel.textAlignment   = NSTextAlignmentLeft;
    
    return nameLabel;
}


- (UILabel *)getCoutryPopulationLabel
{
    UILabel *populationLabel = [[UILabel alloc] init];
    
    populationLabel.font            = [UIFont fontWithName:@"HelveticaNeue-Medium" size:20.0f];
    populationLabel.backgroundColor = [UIColor clearColor];
    populationLabel.textColor       = [UIColor grayColor];
    populationLabel.textAlignment   = NSTextAlignmentLeft;
    
    return populationLabel;
}


- (UILabel *)getCountryRankLabel
{
    UILabel *rankLabel = [[UILabel alloc] init];
    
    rankLabel.font            = [UIFont systemFontOfSize:25.0f];
    rankLabel.backgroundColor = [UIColor clearColor];
    rankLabel.textColor       = [UIColor blackColor];
    rankLabel.textAlignment   = NSTextAlignmentLeft;
    
    return rankLabel;
}


- (UIImageView *)getCountryImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.clipsToBounds = YES;
    
    return imageView;
}



#pragma mark - Views array

- (void)createArrayWithViews
{
    self.views = @[self.countryNameLabel,
                   self.countryPopulationLabel,
                   self.countryRankLabel,
                   self.countryFlagImageView];
}



#pragma mark - Add views

- (void)addViewsToCell
{
    for (UIView *view in self.views) {
        [self.contentView addSubview:view];
    }
}



#pragma mark - Remove constraints

- (void)removeAutoConstraints
{
    for (UIView *view in self.views) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
}



#pragma mark - Views Dictionary

- (void)createViewsDictionary
{
    self.viewsDictionary = @{@"nameLabel" : self.countryNameLabel,
                             @"populationLabel" : self.countryPopulationLabel,
                             @"rankLabel" : self.countryRankLabel,
                             @"flagView" : self.countryFlagImageView};
}



#pragma mark - Autolayout

- (void)cellAutolayout
{
    NSArray *constraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[flagView(90)]-[nameLabel]"
                                            options:0
                                            metrics:nil
                                              views:self.viewsDictionary];
    
    [self.contentView addConstraints:constraints];
    
    constraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[flagView(60)]-|"
                                            options:0
                                            metrics:nil
                                              views:self.viewsDictionary];
    
    [self.contentView addConstraints:constraints];
    
    
    constraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"H:[rankLabel]-|"
                                            options:0
                                            metrics:nil
                                              views:self.viewsDictionary];
    
    [self.contentView addConstraints:constraints];
    
    
    constraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"H:[populationLabel(nameLabel)]"
                                            options:0
                                            metrics:nil
                                              views:self.viewsDictionary];
    
    [self.contentView addConstraints:constraints];
    

    constraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"V:[nameLabel]-10-[populationLabel]"
                                            options:0
                                            metrics:nil
                                              views:self.viewsDictionary];
    
    [self.contentView addConstraints:constraints];
    
    
    // Align name and population label
    NSLayoutConstraint *constraint =
    [NSLayoutConstraint constraintWithItem:self.countryPopulationLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.countryNameLabel
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:0.0];
    
    [self.contentView addConstraint:constraint];
    
    // Center rank with flag
    constraint =
    [NSLayoutConstraint constraintWithItem:self.countryRankLabel
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.countryFlagImageView
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0
                                  constant:0.0];
    
    [self.contentView addConstraint:constraint];
    
    // Align vertical title with flag
    constraint =
    [NSLayoutConstraint constraintWithItem:self.countryNameLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.countryFlagImageView
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:0.0];
    
    [self.contentView addConstraint:constraint];
    
}

@end
