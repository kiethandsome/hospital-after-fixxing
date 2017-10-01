//
//  ThumpImageCell.m
//  BenhVien-app
//
//  Created by test on 7/31/17.
//  Copyright © 2017 test. All rights reserved.
//

#import "SlideShowCell.h"

@implementation SlideShowCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self setupSlideShow:self.imagesDatasource];
//    });
//    [self setupSlideShow:_imagesDatasource];

    
}

- (void)configureCell:(id)model {
    SlideShowModel *slideShow = (SlideShowModel *)model;
    if (slideShow) {
            // Vì kaslideshow chạy trên một queue khác nên phải cho nó chạy trên main queue.
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setupSlideShow:slideShow.images];
        });
    }
}

- (void)setupSlideShow:(NSArray *)images {
    self.imagesDatasource = [NSMutableArray new];
    for (NSString *URL in images) {
        [self.imagesDatasource addObject:[NSURL URLWithString:URL]];
    }
    _slideShow.datasource = self;
    _slideShow.delegate = self;
    [_slideShow setDelay: 0.5]; // Delay between transitions
    [_slideShow setTransitionDuration: 1]; // Transition duration
    [_slideShow setTransitionType: KASlideShowTransitionSlideVertical]; // Choose a transition type
    [_slideShow setImagesContentMode: UIViewContentModeScaleToFill];
    [_slideShow addGesture:KASlideShowGestureTap];
    
    [self.slideShow start];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark KASlideShow datasource

- (NSObject *)slideShow:(KASlideShow *)slideShow objectAtIndex:(NSUInteger)index {
    return _imagesDatasource[index];
}

- (NSUInteger)slideShowImagesNumber:(KASlideShow *)slideShow {
    return self.imagesDatasource.count;
}


@end







