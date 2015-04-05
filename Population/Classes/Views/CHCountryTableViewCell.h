//
//  CHCountryTableViewCell.h
//  Population
//
//  Created by Rui Pedro Barbosa on 04/04/15.
//  Copyright (c) 2015 Rui Barbosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHCountry;

@interface CHCountryTableViewCell : UITableViewCell

@property (nonatomic, strong) CHCountry *country;


- (void)setUpWithCountry:(CHCountry *)country;

- (UIEdgeInsets)countrySeparatorInset;

@end
