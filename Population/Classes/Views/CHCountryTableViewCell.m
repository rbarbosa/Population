//
//  CHCountryTableViewCell.m
//  Population
//
//  Created by Rui Pedro Barbosa on 04/04/15.
//  Copyright (c) 2015 Rui Barbosa. All rights reserved.
//


#import "CHCountryTableViewCell.h"

#import "CHAPIManager.h"
#import "CHCountry.h"


@interface CHCountryTableViewCell ()

@property (nonatomic, strong) UILabel *countryNameLabel;
@property (nonatomic, strong) UILabel *countryPopulationLabel;
@property (nonatomic, strong) UILabel *countryRankLabel;
@property (nonatomic, strong) UIImageView *countryFlagImageView;

@property (nonatomic, strong) NSArray *views;
@property (nonatomic, strong) NSDictionary *viewsDictionary;

@property (nonatomic, strong) CHAPIManager *apiManager;

@end



@implementation CHCountryTableViewCell


#pragma mark - Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.countryNameLabel = [self nameLabel];
        self.countryPopulationLabel = [self populationLabel];
        self.countryRankLabel = [self rankLabel];
        self.countryFlagImageView = [self flagImageView];
        
        [self createArrayWithViews];
        [self addViewsToCell];
        
        [self removeAutoConstraints];

        [self createViewsDictionary];
        
        [self cellAutolayout];
        
        self.apiManager = [[CHAPIManager alloc] init];
    }
    
    return self;
}



#pragma mark - set up cell with country

- (void)setUpWithCountry:(CHCountry *)country
{
    self.countryNameLabel.text = country.name;
    self.countryPopulationLabel.text = [self stringFromNumber:country.population];
    self.countryRankLabel.text = [self stringFromNumber:country.rank];
    
    
    __weak __typeof(self)weakSelf = self;
    [self.apiManager fetchFlagImageForCountry:country
                          withCompletionBlock:^(UIImage *image) {
                              __strong __typeof(weakSelf)strongSelf = weakSelf;
                              strongSelf.countryFlagImageView.image = image;
                          }];
}



#pragma mark - Set table view separator

- (UIEdgeInsets)countrySeparatorInset
{
    CGFloat xInset = CGRectGetMinX(self.countryNameLabel.frame);
    
    
    return UIEdgeInsetsMake(0, xInset, 0, 0);
}



#pragma mark - Set up labels and image view

- (UILabel *)nameLabel
{
    UILabel *nameLabel = [[UILabel alloc] init];
    
    nameLabel.font            = [UIFont fontWithName:@"HelveticaNeue" size:25.0f];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor       = [UIColor darkGrayColor];
    nameLabel.textAlignment   = NSTextAlignmentLeft;
    
    return nameLabel;
}


- (UILabel *)populationLabel
{
    UILabel *populationLabel = [[UILabel alloc] init];
    
    populationLabel.font            = [UIFont fontWithName:@"HelveticaNeue-Medium" size:20.0f];
    populationLabel.backgroundColor = [UIColor clearColor];
    populationLabel.textColor       = [UIColor grayColor];
    populationLabel.textAlignment   = NSTextAlignmentLeft;
    
    return populationLabel;
}


- (UILabel *)rankLabel
{
    UILabel *rankLabel = [[UILabel alloc] init];
    
    rankLabel.font            = [UIFont systemFontOfSize:25.0f];
    rankLabel.backgroundColor = [UIColor clearColor];
    rankLabel.textColor       = [UIColor blackColor];
    rankLabel.textAlignment   = NSTextAlignmentLeft;
    
    return rankLabel;
}


- (UIImageView *)flagImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    
    imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    imageView.layer.borderWidth = 1.0f;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
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
    [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[flagView(60@750)]-|"
                                            options:0
                                            metrics:nil
                                              views:self.viewsDictionary];
    
    [self.contentView addConstraints:constraints];
    
    
    constraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"H:[rankLabel]-25-|"
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



#pragma mark - string from number
//TODO: Add this to a category

- (NSString *)stringFromNumber:(NSNumber *)number
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSString *stringNumber = [formatter stringFromNumber:number];
    
    return stringNumber;
}

@end
