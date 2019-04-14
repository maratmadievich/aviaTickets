//
//  PlaceViewController.m
//  Avia Tickets
//
//  Created by Марат Нургалиев on 23/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import "PlaceViewController.h"

#define ReuseIdentifier @"CellIdentifier"


@interface PlaceViewController () <UISearchResultsUpdating>
  
@end


@implementation PlaceViewController

    - (instancetype)initWithType:(PlaceType)type {
        
        self = [super init];
        
        if (self) {
            
            _placeType = type;
        }
    
        return self;
    }
    

    - (void)viewDidLoad {
   
        [super viewDidLoad];
    
        [self configureView];
    }
    
    
    - (void)configureView {
        
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
        
        
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        
        _searchController.dimsBackgroundDuringPresentation = NO;
        
        _searchController.searchResultsUpdater = self;
        
        _searchArray = [NSArray new];
        
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.minimumLineSpacing = 10.0;
        
        layout.minimumInteritemSpacing = 10.0;
        
        layout.itemSize = CGSizeMake(100.0, 100.0);
        
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        _collectionView.delegate = self;
        
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[PlaceCollectionCell class] forCellWithReuseIdentifier:ReuseIdentifier];
        
//        _collectionView.tableFooterView = [[UIView alloc] init];
        
        if (@available(iOS 11.0, *)) {
            
            self.navigationItem.searchController = _searchController;
            
            self.navigationItem.hidesSearchBarWhenScrolling = NO;
        }
        else {
            
//            _collectionView.heade = _searchController.searchBar;
        }

        [self.view addSubview:_collectionView];
        
        
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[[@"place_cities" localize], [@"place_airports" localize]]];
        
        [_segmentedControl addTarget:self action:@selector(changeSource) forControlEvents:UIControlEventValueChanged];
        
        _segmentedControl.tintColor = [UIColor blackColor];
        
        self.navigationItem.titleView = _segmentedControl;
        
        _segmentedControl.selectedSegmentIndex = 0;
        
        [self changeSource];
        
        if (_placeType == PlaceTypeDeparture) {
            
            self.title = [@"main_from" localize];
        }
        else {
            
            self.title = [@"main_to" localize];
        }
        
    }
    

    - (void)changeSource {
    
        switch (_segmentedControl.selectedSegmentIndex) {
        
            case 0:
        
            _currentArray = [[DataManager sharedInstance] cities];
       
            break;
        
            case 1:
        
            _currentArray = [[DataManager sharedInstance] airports];
       
            break;
        
            default:
        
            break;
        }
        
        [self.collectionView reloadData];
    }
    
    
#pragma mark - UISearchResultsUpdating

    - (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
        
        if (searchController.searchBar.text) {
           
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[cd] %@", searchController.searchBar.text];
           
            _searchArray = [_currentArray filteredArrayUsingPredicate: predicate];
            
            [_collectionView reloadData];
        }
        
    }

    
#pragma mark - UICollectionViewDataSource

    - (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
        
        return (_searchController.isActive && [_searchArray count] > 0) ? [_searchArray count] : [_currentArray count];
    }

    - (CGSize)collectionView:(UICollectionView *)collectionView layout:   (UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
   
        return CGSizeMake(100, 100);
    }

    - (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
        
        PlaceCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: ReuseIdentifier  forIndexPath:indexPath];
        
        if (_segmentedControl.selectedSegmentIndex == 0) {
            
            City *city = (_searchController.isActive && [_searchArray count] > 0) ? [_searchArray objectAtIndex: indexPath.row] : [_currentArray objectAtIndex: indexPath.row];
            
            cell.labelName.text = city.name;
            
            cell.labelCode.text = city.code;
        }
        else if (_segmentedControl.selectedSegmentIndex == 1) {
            
            Airport *airport = (_searchController.isActive && [_searchArray count] > 0) ? [_searchArray objectAtIndex: indexPath.row] : [_currentArray objectAtIndex: indexPath.row];
            
            cell.labelName.text = airport.name;
            
            cell.labelCode.text = airport.code;
        }
        
        return cell;
    }
    

#pragma mark - UICollectionViewDelegate

    - (void)collectionView:(UICollectionView *)collectionView
  didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
        
        DataSourceType dataType = ((int)_segmentedControl.selectedSegmentIndex) + 1;
        
        if (_searchController.isActive && [_searchArray count] > 0) {
            
            [self.delegate selectPlace:[_searchArray objectAtIndex:indexPath.row] withType:_placeType andDataType:dataType];
            
            _searchController.active = NO;
        }
        else {
            
            [self.delegate selectPlace:[_currentArray objectAtIndex:indexPath.row] withType:_placeType andDataType:dataType];
        }
        
        
        [self.navigationController popViewControllerAnimated:YES];
    }

@end
