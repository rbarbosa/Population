//
//  CHCountriesTableViewController.m
//  Population
//
//  Created by Rui Pedro Barbosa on 03/04/15.
//  Copyright (c) 2015 Rui Barbosa. All rights reserved.
//

#import "CHCountriesTableViewController.h"

#import "CHCountriesDataSource.h"
#import "CHNetworking.h"
#import "CHCountry.h"
#import "CHCountryTableViewCell.h"

NSString * const CellIdentifier = @"countryCell";

@interface CHCountriesTableViewController ()

@property(nonatomic, strong) CHCountriesDataSource *countriesDataSource;
@property (nonatomic, strong) NSArray *countries;

@end

@implementation CHCountriesTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.countriesDataSource = [[CHCountriesDataSource alloc] init];
    
    [self setUpRefreshControl];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:CellIdentifier];
    
    [self.refreshControl beginRefreshing];
    
    [self refresh];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Refresh Control

- (void)setUpRefreshControl
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl addTarget:self
                            action:@selector(refresh)
                  forControlEvents:UIControlEventValueChanged];
}



#pragma mark - Action for refresh control

- (void)refresh
{
    [self.countriesDataSource getCountriesWithCompletionBlock:^(BOOL success, NSArray *countries) {
        if (success) {
            self.countries = countries;
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
        }
    }];
    
    
    
}

#pragma mark - UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
//                                                            forIndexPath:indexPath];

    CHCountryTableViewCell *cell = [[CHCountryTableViewCell alloc]
                                    initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:CellIdentifier];

    CHCountry *country = self.countries[indexPath.row];
    
//    cell.textLabel.text = country.name;
    [cell setUpWithCountry:country];
    
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.countries count];
}


#pragma mark - TableViewDelegate methods



@end
