//
//  FeedInfoViewController.m
//  Avia Tickets
//
//  Created by Марат Нургалиев on 25/03/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

#import "FeedInfoViewController.h"

@interface FeedInfoViewController ()

@end

@implementation FeedInfoViewController
    
    - (instancetype)initWithFeed:(Feed *)feed {
        
        self = [super init];
        
        if (self) {
            
            _feed = feed;
            
            self.title = @"Новость";
        }
        
        return self;
    }
    

    - (void)viewDidLoad {
        
        [super viewDidLoad];
        
        [self addSubviews];
        
//        [self addConstraints];
    }
    
    
    - (void) addSubviews {
        
        self.navigationController.navigationBar.translucent = NO;
        
        self.view.backgroundColor = UIColor.whiteColor;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 60)];
        
        _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 760);

        _scrollView.backgroundColor = [UIColor whiteColor];

        _scrollView.showsVerticalScrollIndicator = YES;

        _scrollView.scrollEnabled = YES;
    
        
        _labelTitle = [[UILabel alloc] initWithFrame: CGRectMake(16, 10, [UIScreen mainScreen].bounds.size.width - 32, 200)];

        _labelTitle.font = [UIFont systemFontOfSize:20.0 weight:UIFontWeightBold];

        _labelTitle.numberOfLines = 0;

        _labelTitle.textAlignment = NSTextAlignmentJustified;

        _labelTitle.text = _feed.title;

        [_scrollView addSubview:_labelTitle];




        _labelPublishedAt = [[UILabel alloc] initWithFrame:  CGRectMake(16, CGRectGetMaxY(_labelTitle.frame) + 10.0, [UIScreen mainScreen].bounds.size.width - 32, 20)];

        _labelPublishedAt.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];

        _labelPublishedAt.text = _feed.publishedAt;

        [_scrollView addSubview:_labelPublishedAt];


        _imageView = [[UIImageView alloc] initWithFrame: CGRectMake(16, CGRectGetMaxY(_labelPublishedAt.frame) + 10.0, [UIScreen mainScreen].bounds.size.width - 32, 200)];

        _imageView.contentMode = UIViewContentModeScaleAspectFit;

        [_scrollView addSubview:_imageView];

        if (_feed.urlToImage != nil) {

            NSURL *urlLogo = GenerateNSUrl(_feed.urlToImage);

            [_imageView yy_setImageWithURL:urlLogo options:YYWebImageOptionSetImageWithFadeAnimation];
        }


        _labelContent = [[UILabel alloc] initWithFrame: CGRectMake(16, CGRectGetMaxY(_imageView.frame) + 10.0, [UIScreen mainScreen].bounds.size.width - 32, 300)];

        _labelContent.font = [UIFont systemFontOfSize:20.0 weight:UIFontWeightRegular];

        _labelContent.numberOfLines = 0;

        _labelContent.text = _feed.descript;

        _labelContent.textAlignment = NSTextAlignmentNatural;

        [_scrollView addSubview:_labelContent];




        _labelAuthor = [[UILabel alloc] initWithFrame: CGRectMake(16, CGRectGetMaxY(_labelContent.frame) + 10.0, [UIScreen mainScreen].bounds.size.width - 32, 20)];

        _labelAuthor.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];

        _labelAuthor.textAlignment = NSTextAlignmentRight;

        [_scrollView addSubview:_labelAuthor];

        _labelAuthor.text = [NSString stringWithFormat: @"%@", _feed.author];

//        _scrollView.contentSize.height = CGSizeMake(_scrollView.frame.size.width, CGRectGetMaxY(_labelContent.frame) + 10.0);

        [self.view addSubview:_scrollView];

    }

    
    - (void) addConstraints {

//        [_labelTitle.topAnchor constraintEqualToAnchor:_scrollView.topAnchor constant:10].active = YES;
//
//        [_labelTitle.leftAnchor constraintEqualToAnchor:_scrollView.leftAnchor constant:16].active = YES;
//
//        [_labelTitle.rightAnchor constraintEqualToAnchor:_scrollView.rightAnchor constant:16].active = YES;
        
//        NSLayoutConstraint *constraintScrollViewTop = [NSLayoutConstraint
//                                                       constraintWithItem:_scrollView
//                                                       attribute:NSLayoutAttributeTop
//                                                       relatedBy:NSLayoutRelationEqual
//                                                       toItem:self.view
//                                                       attribute:NSLayoutAttributeTop
//                                                       multiplier:1.0
//                                                       constant:0];
//
//        NSLayoutConstraint *constraintScrollViewBottom = [NSLayoutConstraint
//                                                       constraintWithItem:_scrollView
//                                                       attribute:NSLayoutAttributeBottom
//                                                       relatedBy:NSLayoutRelationEqual
//                                                       toItem:self.view
//                                                       attribute:NSLayoutAttributeBottom
//                                                       multiplier:1.0
//                                                       constant:0];
//
//        NSLayoutConstraint *constraintScrollViewLeft = [NSLayoutConstraint
//                                                       constraintWithItem:_scrollView
//                                                       attribute:NSLayoutAttributeLeft
//                                                       relatedBy:NSLayoutRelationEqual
//                                                       toItem:self.view
//                                                       attribute:NSLayoutAttributeLeft
//                                                       multiplier:1.0
//                                                       constant:0];
//
//        NSLayoutConstraint *constraintScrollViewRight = [NSLayoutConstraint
//                                                       constraintWithItem:_scrollView
//                                                       attribute:NSLayoutAttributeRight
//                                                       relatedBy:NSLayoutRelationEqual
//                                                       toItem:self.view
//                                                       attribute:NSLayoutAttributeRight
//                                                       multiplier:1.0
//                                                       constant:0];
//
//
//
//
//        [self.view addConstraints: @[constraintScrollViewTop, constraintScrollViewBottom, constraintScrollViewLeft, constraintScrollViewRight]];
//
//        NSLayoutConstraint *constraintLabelTitleTop = [NSLayoutConstraint
//                                                       constraintWithItem:_labelTitle
//                                                       attribute:NSLayoutAttributeTop
//                                                       relatedBy:NSLayoutRelationEqual
//                                                       toItem:_scrollView
//                                                       attribute:NSLayoutAttributeTop
//                                                       multiplier:1.0
//                                                       constant:10];
//
//        NSLayoutConstraint *constraintLabelTitleLeft = [NSLayoutConstraint
//                                                        constraintWithItem:_labelTitle
//                                                        attribute:NSLayoutAttributeLeft
//                                                        relatedBy:NSLayoutRelationEqual
//                                                        toItem:_scrollView
//                                                        attribute:NSLayoutAttributeLeft
//                                                        multiplier:1.0
//                                                        constant:16];
//
//        NSLayoutConstraint *constraintLabelTitleRight = [NSLayoutConstraint
//                                                         constraintWithItem:_labelTitle
//                                                         attribute:NSLayoutAttributeRight
//                                                         relatedBy:NSLayoutRelationEqual
//                                                         toItem:_scrollView
//                                                         attribute:NSLayoutAttributeRight
//                                                         multiplier:1.0
//                                                         constant:16];
//
//
//        [self.view addConstraints: @[constraintLabelTitleTop, constraintLabelTitleLeft, constraintLabelTitleRight]];
//
//
//        NSLayoutConstraint *constraintLabelPublishedTop = [NSLayoutConstraint
//                                                           constraintWithItem:_labelPublishedAt
//                                                           attribute:NSLayoutAttributeTop
//                                                           relatedBy:NSLayoutRelationEqual
//                                                           toItem:_labelTitle
//                                                           attribute:NSLayoutAttributeBottom
//                                                           multiplier:1.0
//                                                           constant:10];
//
//        NSLayoutConstraint *constraintLabelPublishedLeft = [NSLayoutConstraint
//                                                            constraintWithItem:_labelPublishedAt
//                                                            attribute:NSLayoutAttributeLeft
//                                                            relatedBy:NSLayoutRelationEqual
//                                                            toItem:_scrollView
//                                                            attribute:NSLayoutAttributeLeft
//                                                            multiplier:1.0
//                                                            constant:16];
//
//        NSLayoutConstraint *constraintLabelPublishedRight = [NSLayoutConstraint
//                                                             constraintWithItem:_labelPublishedAt
//                                                             attribute:NSLayoutAttributeRight
//                                                             relatedBy:NSLayoutRelationEqual
//                                                             toItem:_scrollView
//                                                             attribute:NSLayoutAttributeRight
//                                                             multiplier:1.0
//                                                             constant:16];
//
//        [self.view addConstraints: @[constraintLabelPublishedTop, constraintLabelPublishedLeft, constraintLabelPublishedRight]];
//
//
//        NSLayoutConstraint *constraintImageTop = [NSLayoutConstraint
//                                                  constraintWithItem:_imageView
//                                                  attribute:NSLayoutAttributeTop
//                                                  relatedBy:NSLayoutRelationEqual
//                                                  toItem:_labelPublishedAt
//                                                  attribute:NSLayoutAttributeBottom
//                                                  multiplier:1.0
//                                                  constant:10];
//
//        NSLayoutConstraint *constraintImageHeight = [NSLayoutConstraint
//                                                     constraintWithItem:_imageView
//                                                     attribute:NSLayoutAttributeHeight
//                                                     relatedBy:NSLayoutRelationEqual
//                                                     toItem:nil
//                                                     attribute:NSLayoutAttributeNotAnAttribute
//                                                     multiplier:1.0
//                                                     constant:_feed.urlToImage == nil ? 0 : 100];
//
//        NSLayoutConstraint *constraintImageLeft = [NSLayoutConstraint
//                                                   constraintWithItem:_imageView
//                                                   attribute:NSLayoutAttributeLeft
//                                                   relatedBy:NSLayoutRelationEqual
//                                                   toItem:_scrollView
//                                                   attribute:NSLayoutAttributeLeft
//                                                   multiplier:1.0
//                                                   constant:16];
//
//        NSLayoutConstraint *constraintImageRight = [NSLayoutConstraint
//                                                    constraintWithItem:_imageView
//                                                    attribute:NSLayoutAttributeRight
//                                                    relatedBy:NSLayoutRelationEqual
//                                                    toItem:_scrollView
//                                                    attribute:NSLayoutAttributeRight
//                                                    multiplier:1.0
//                                                    constant:16];
//
//        [self.view addConstraints: @[constraintImageTop, constraintImageHeight, constraintImageLeft, constraintImageRight]];
//
//
//        NSLayoutConstraint *constraintLabelContentTop = [NSLayoutConstraint
//                                                         constraintWithItem:_labelContent
//                                                         attribute:NSLayoutAttributeTop
//                                                         relatedBy:NSLayoutRelationEqual
//                                                         toItem:_imageView
//                                                         attribute:NSLayoutAttributeBottom
//                                                         multiplier:1.0
//                                                         constant:10];
//
//        NSLayoutConstraint *constraintLabelContentLeft = [NSLayoutConstraint
//                                                          constraintWithItem:_labelContent
//                                                          attribute:NSLayoutAttributeLeft
//                                                          relatedBy:NSLayoutRelationEqual
//                                                          toItem:_scrollView
//                                                          attribute:NSLayoutAttributeLeft
//                                                          multiplier:1.0
//                                                          constant:16];
//
//        NSLayoutConstraint *constraintLabelContentRight = [NSLayoutConstraint
//                                                           constraintWithItem:_labelContent
//                                                           attribute:NSLayoutAttributeRight
//                                                           relatedBy:NSLayoutRelationEqual
//                                                           toItem:_scrollView
//                                                           attribute:NSLayoutAttributeRight
//                                                           multiplier:1.0
//                                                           constant:16];
//
//        [self.view addConstraints: @[constraintLabelContentTop, constraintLabelContentLeft, constraintLabelContentRight]];
//
//
//        NSLayoutConstraint *constraintLabelAuthorTop = [NSLayoutConstraint
//                                                        constraintWithItem:_labelAuthor
//                                                        attribute:NSLayoutAttributeTop
//                                                        relatedBy:NSLayoutRelationEqual
//                                                        toItem:_labelContent
//                                                        attribute:NSLayoutAttributeBottom
//                                                        multiplier:1.0
//                                                        constant:10];
//
//        NSLayoutConstraint *constraintLabelAuthorBottom = [NSLayoutConstraint
//                                                           constraintWithItem:_labelAuthor
//                                                           attribute:NSLayoutAttributeBottom
//                                                           relatedBy:NSLayoutRelationEqual
//                                                           toItem:_scrollView
//                                                           attribute:NSLayoutAttributeBottom
//                                                           multiplier:1.0
//                                                           constant:10];
//
//        NSLayoutConstraint *constraintLabelAuthorLeft = [NSLayoutConstraint
//                                                         constraintWithItem:_labelAuthor
//                                                         attribute:NSLayoutAttributeLeft
//                                                         relatedBy:NSLayoutRelationEqual
//                                                         toItem:_scrollView
//                                                         attribute:NSLayoutAttributeLeft
//                                                         multiplier:1.0
//                                                         constant:16];
//
//        NSLayoutConstraint *constraintLabelAuthorRight = [NSLayoutConstraint
//                                                          constraintWithItem:_labelAuthor
//                                                          attribute:NSLayoutAttributeRight
//                                                          relatedBy:NSLayoutRelationEqual
//                                                          toItem:_scrollView
//                                                          attribute:NSLayoutAttributeRight
//                                                          multiplier:1.0
//                                                          constant:16];
//
//        [self.view addConstraints: @[constraintLabelAuthorTop, constraintLabelAuthorBottom, constraintLabelAuthorLeft, constraintLabelAuthorRight]];
//
        
    }



@end
