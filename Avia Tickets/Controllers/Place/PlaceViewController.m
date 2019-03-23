//
//  PlaceViewController.m
//  Avia Tickets
//
//  Created by Марат Нургалиев on 23/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import "PlaceViewController.h"
#import "PlaceCell.h"

#define ReuseIdentifier @"CellIdentifier"


@interface PlaceViewController ()
    
    @property (nonatomic) PlaceType placeType;
    
    @property (nonatomic, strong) UITableView *tableView;
    
    @property (nonatomic, strong) UISegmentedControl *segmentedControl;
    
    @property (nonatomic, strong) NSArray *currentArray;

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
        
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
        
        _tableView.tableFooterView = nil;
        
        [self.view addSubview:_tableView];
        
        
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Города", @"Аэропорты"]];
        
        [_segmentedControl addTarget:self action:@selector(changeSource) forControlEvents:UIControlEventValueChanged];
        
        _segmentedControl.tintColor = [UIColor blackColor];
        
        self.navigationItem.titleView = _segmentedControl;
        
        _segmentedControl.selectedSegmentIndex = 0;
        
        [self changeSource];
        
        if (_placeType == PlaceTypeDeparture) {
            
            self.title = @"Откуда";
        }
        else {
            
            self.title = @"Куда";
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
        
        [self.tableView reloadData];
    }
    
    
    
    
#pragma mark - UITableViewDataSource

    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
       
//        return [_currentArray count];
        return 10;
    }

    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
//
//        if (!cell) {
//
//            cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:ReuseIdentifier];
//
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        }
//
//        if (_segmentedControl.selectedSegmentIndex == 0) {
//
//            City *city = [_currentArray objectAtIndex:indexPath.row];
//
//            cell.textLabel.text = city.name;
//
//            cell.detailTextLabel.text = city.code;
//        }
//        else if (_segmentedControl.selectedSegmentIndex == 1) {
//
//            Airport *airport = [_currentArray objectAtIndex:indexPath.row];
//
//            cell.textLabel.text = airport.name;
//
//            cell.detailTextLabel.text = airport.code;
//        }
        
        PlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceCell"];
        
        if (!cell) {
            
            cell = [[PlaceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
        }
        
        if (_segmentedControl.selectedSegmentIndex == 0) {
            
            City *city = [_currentArray objectAtIndex:indexPath.row];
            
            cell.labelName.text = @"Город";//city.name;
            
            cell.labelCode.text = @"Код города";//city.code;
        }
        else if (_segmentedControl.selectedSegmentIndex == 1) {
            
            Airport *airport = [_currentArray objectAtIndex:indexPath.row];
            
            cell.labelName.text = @"Аэропорт";//airport.name;
            
            cell.labelCode.text = @"Код аэропорта";//airport.code;
        }
        
        return cell;
    }
    
    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        
        return 70;
    }

#pragma mark - UITableViewDelegate

    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        DataSourceType dataType = ((int)_segmentedControl.selectedSegmentIndex) + 1;
    
        [self.delegate selectPlace:[_currentArray objectAtIndex:indexPath.row] withType:_placeType andDataType:dataType];
   
        [self.navigationController popViewControllerAnimated:YES];
    }
    
@end
