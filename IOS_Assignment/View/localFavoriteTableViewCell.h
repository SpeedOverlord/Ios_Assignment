//
//  localFavoriteTableViewCell.h
//  IOS_Assignment
//
//  Created by ESB21632 on 2021/1/26.
//  Copyright © 2021 陳彥廷21632. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface localFavoriteTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *trackName;
@property (nonatomic, strong) UILabel *artistName;
@property (nonatomic, strong) UILabel *collectionName;
@property (nonatomic, strong) UILabel *trackTime;
@property (nonatomic, strong) UIImageView *coverURL;
@property (nonatomic, strong) UILabel *description;
@property (nonatomic) int totalHeight;
@property (nonatomic, strong) UIButton *readMore;
@property (nonatomic, copy) void (^readMoreButtonAction)(UIButton *);
@property (nonatomic) int descriptionHeight;
@property (nonatomic, strong) UIButton *removeFavorite;
@property (nonatomic, copy) void (^clickPhoto)(UIImageView*);

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

-(void)fitTextLength;
-(void)originTextLength;
-(void)getRealHeight;
-(void)checkDefaultColor;

@end

NS_ASSUME_NONNULL_END
