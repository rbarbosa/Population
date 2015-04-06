//
//  CHCountriesTableViewController.m
//  Population
//
//  Created by Rui Pedro Barbosa on 03/04/15.
//  Copyright (c) 2015 Rui Barbosa. All rights reserved.
//

#import "CHCountriesTableViewController.h"

#import "CHAPIManager.h"
#import "CHCountriesDataSource.h"
#import "CHCountry.h"
#import "CHCountryTableViewCell.h"

NSString * const CellIdentifier = @"countryCell";

@interface CHCountriesTableViewController ()

@property (nonatomic, strong) CHCountriesDataSource *countriesDataSource;
@property (nonatomic, strong) CHAPIManager *apiManager;

@property (nonatomic, strong) NSArray *countries;

@end

@implementation CHCountriesTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpTableView];
    
    self.countriesDataSource = [[CHCountriesDataSource alloc] init];
    
    self.apiManager = [[CHAPIManager alloc] init];
    
    [self setUpRefreshControl];
    
    [self.refreshControl beginRefreshing];
    
    [self refresh];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Set up table view

- (void)setUpTableView
{
    self.title = NSLocalizedString(@"Countries", nil);
    
    self.tableView.allowsSelection = NO;
    
    CHCountryTableViewCell *cell = [[CHCountryTableViewCell alloc] init];
    
    [cell layoutIfNeeded];
    
    self.tableView.separatorInset = [cell countrySeparatorInset];
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
    __weak __typeof(self)weakSelf = self;
    [self.apiManager fetchCountriesWithCompletionBlock:^(NSArray *countries, NSError *error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [self.refreshControl endRefreshing];
        if (!error) {
            strongSelf.countriesDataSource.countries = countries;
            [self.tableView reloadData];
            [self updateTitle];
        } else {
            [self showAlertError:error];
        }
    }];
}



#pragma mark - Update title

- (void)updateTitle
{
    NSString *title =  NSLocalizedString(@"Countries", nil);
    
    title = [title stringByAppendingFormat:@" - %ld",
     [self.countriesDataSource numberOfCountries]];
    
    self.title = title;
}


#pragma mark - Alert with error

- (void)showAlertError:(NSError *)error
{
    NSString *title =  NSLocalizedString(@"Error", nil);
    NSString *message = error.localizedDescription;
    
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:title
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:nil];
    [alertController addAction:defaultAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHCountryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (!cell) {
        cell = [[CHCountryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:CellIdentifier];
    }
    
    CHCountry *country = [self.countriesDataSource countryAtIndexPath:indexPath];
    
    [cell setUpWithCountry:country];
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.countriesDataSource numberOfCountries];
}


#pragma mark - TableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}

@end
