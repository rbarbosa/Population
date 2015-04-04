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
        
        // Do autolayout
        
    }
    
    return self;
}

#pragma mark - set up cell with country

- (void)setUpWithCountry:(CHCountry *)country
{
    self.countryNameLabel.text = country.name;

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

@end
