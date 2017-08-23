//
//  ThumpImageCell.h
//  BenhVien-app
//
//  Created by test on 7/31/17.
//  Copyright © 2017 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KASlideShow.h"
#import "HLTableViewCell.h"
#import "SlideShowModel.h"

@interface SlideShowCell : HLTableViewCell <KASlideShowDataSource, KASlideShowDelegate>

@property (strong, nonatomic) IBOutlet KASlideShow *slideShow;
@property (nonatomic )NSMutableArray *imagesDatasource;

@end
