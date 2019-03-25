//
//  MainViewController.m
//  Avia Tickets
//
//  Created by Марат Нургалиев on 23/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () <PlaceViewControllerDelegate>

@end


@implementation MainViewController

    - (void)viewDidLoad {
        
        [super viewDidLoad];
        
        [[DataManager sharedInstance] loadData];
        
        [self configureView];
        
        [self addSubviews];
    }
    
    
    - (void)dealloc {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kDataManagerLoadDataDidComplete object:nil];
    }
    
    
    - (void)loadDataComplete {
       
        [[ApiManager sharedInstance] cityForCurrentIP:^(City *city) {
            
            [self setPlace:city withDataType:DataSourceTypeCity andPlaceType:PlaceTypeDeparture forButton:_departureButton];
        }];

    }
    
    
    - (void) configureView {
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        
        self.navigationController.navigationBar.translucent = NO;
        
        self.title = @"Поиск";
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDataComplete) name:kDataManagerLoadDataDidComplete object:nil];
    }
    
    
    - (void) addSubviews {
        
        _placeContainerView = [[UIView alloc] initWithFrame:CGRectMake(20.0, 20.0, [UIScreen mainScreen].bounds.size.width - 40.0, 170.0)];
       
        _placeContainerView.backgroundColor = [UIColor whiteColor];
        
        _placeContainerView.layer.shadowColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];
        
        _placeContainerView.layer.shadowOffset = CGSizeZero;
        
        _placeContainerView.layer.shadowRadius = 20.0;
        
        _placeContainerView.layer.shadowOpacity = 1.0;
        
        _placeContainerView.layer.cornerRadius = 6.0;
        
        
        _departureButton = [UIButton buttonWithType:UIButtonTypeSystem];
       
        [_departureButton setTitle:@"Откуда" forState: UIControlStateNormal];
        
        _departureButton.tintColor = [UIColor blackColor];
        
        _departureButton.frame = CGRectMake(10.0, 20.0, _placeContainerView.frame.size.width - 20.0, 60.0);
        
        _departureButton.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
        
        _departureButton.layer.cornerRadius = 4.0;
        
        [_departureButton addTarget:self action:@selector(placeButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.placeContainerView addSubview:_departureButton];
        
        
        _arrivalButton = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [_arrivalButton setTitle:@"Куда" forState: UIControlStateNormal];
        
        _arrivalButton.tintColor = [UIColor blackColor];
        
        _arrivalButton.frame = CGRectMake(10.0, CGRectGetMaxY(_departureButton.frame) + 10.0, _placeContainerView.frame.size.width - 20.0, 60.0);
        
        _arrivalButton.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
        
        _arrivalButton.layer.cornerRadius = 4.0;
        
        [_arrivalButton addTarget:self action:@selector(placeButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.placeContainerView addSubview:_arrivalButton];
        
        [self.view addSubview:_placeContainerView];
        
        
        _searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [_searchButton setTitle:@"Найти" forState:UIControlStateNormal];
        
        _searchButton.tintColor = [UIColor whiteColor];
        
        _searchButton.frame = CGRectMake(30.0, CGRectGetMaxY(_placeContainerView.frame) + 30, [UIScreen mainScreen].bounds.size.width - 60.0, 60.0);
        
        _searchButton.backgroundColor = [UIColor blackColor];
        
        _searchButton.layer.cornerRadius = 8.0;
        
        _searchButton.titleLabel.font = [UIFont systemFontOfSize:20.0 weight:UIFontWeightBold];
        
        [_searchButton addTarget:self action:@selector(searchButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_searchButton];
        
        
        _feedsButton = [[UIBarButtonItem alloc]
                        initWithTitle: @"Новости"
                        style: UIBarButtonItemStylePlain
                        target: self
                        action: @selector(feedsButtonDidTap:)];
        
        self.navigationItem.rightBarButtonItem = _feedsButton;
    }


    - (void)placeButtonDidTap:(UIButton *)sender {
       
        PlaceViewController *placeViewController;
        
        if ([sender isEqual:_departureButton]) {
        
            placeViewController = [[PlaceViewController alloc] initWithType: PlaceTypeDeparture];
        }
        else {
        
            placeViewController = [[PlaceViewController alloc] initWithType: PlaceTypeArrival];
        }
        
        placeViewController.delegate = self;
        
        [self.navigationController pushViewController: placeViewController animated:YES];
    }
    
    
    - (void)searchButtonDidTap:(UIButton *)sender {
       
        [[ApiManager sharedInstance] ticketsWithRequest:_searchRequest withCompletion:^(NSArray *tickets) {
        
            if (tickets.count > 0) {
            
                TicketsViewController *ticketsViewController = [[TicketsViewController alloc] initWithTickets:tickets];
                
                [self.navigationController showViewController:ticketsViewController sender:self];
            }
            else {
            
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Увы!" message:@"По данному направлению билетов не найдено" preferredStyle: UIAlertControllerStyleAlert];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"Закрыть" style:(UIAlertActionStyleDefault) handler:nil]];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }
            
        }];
        
    }
    
    
    - (void)feedsButtonDidTap:(UIButton *)sender {
        
        [[ApiManager sharedInstance] feedsWithRequest: @"ru" withCompletion: ^(NSArray *feeds) {//bbc-news
            
            if (feeds.count > 0) {
                
                FeedsViewController *feedsViewController = [[FeedsViewController alloc] initWithFeeds: feeds];
                
                [self.navigationController showViewController:feedsViewController sender:self];
            }
            else {
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Увы!" message:@"Не получилось найти новости или ошибка реализации" preferredStyle: UIAlertControllerStyleAlert];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"Закрыть" style:(UIAlertActionStyleDefault) handler:nil]];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }
            
        }];
        
    }

    
//    -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//       
//        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
//        
//        backItem.title = @"";
//        
//        self.navigationItem.backBarButtonItem = backItem;
//    }
    
    
#pragma mark - PlaceViewControllerDelegate
    
    - (void)selectPlace:(id)place withType:(PlaceType)placeType andDataType:(DataSourceType)dataType {
        
        [self setPlace:place withDataType:dataType andPlaceType:placeType forButton: (placeType == PlaceTypeDeparture) ? _departureButton : _arrivalButton ];
    }
    
    - (void)setPlace:(id)place withDataType:(DataSourceType)dataType andPlaceType:(PlaceType)placeType forButton:(UIButton *)button {
        
        NSString *title;
        
        NSString *iata;
        
        if (dataType == DataSourceTypeCity) {
        
            City *city = (City *)place;
            
            title = city.name;
            
            iata = city.code;
        }
        else if (dataType == DataSourceTypeAirport) {
            
            Airport *airport = (Airport *)place;
            
            title = airport.name;
            
            iata = airport.cityCode;
        }
        if (placeType == PlaceTypeDeparture) {
            
            _searchRequest.origin = iata;
        }
        else {
        
            _searchRequest.destionation = iata;
        }
        
        [button setTitle: title forState: UIControlStateNormal];
    }
    
@end
