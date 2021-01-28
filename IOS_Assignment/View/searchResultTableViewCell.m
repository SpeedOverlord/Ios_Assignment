//
//  searchResultTableViewCell.m
//  IOS_Assignment
//
//  Created by 陳彥廷21632 on 2020/12/31.
//  Copyright © 2020 陳彥廷21632. All rights reserved.
//

#import "searchResultTableViewCell.h"
#import <SDWebImage/SDWebImage.h>
#import "DefaultColorManager.h"

@interface searchResultTableViewCell() {
     DefaultColorManager *defaultColorManager;
}

@property (nonatomic, strong) NSLayoutConstraint *trackNameUpperBond, *trackNameLowerBond, *trackNameLeftBond, *trackNameRightBond;
@property (nonatomic, strong) NSLayoutConstraint *artistNameUpperBond, *artistNameLowerBond, *artistNameLeftBond, *artistNameRightBond;
@property (nonatomic, strong) NSLayoutConstraint *collectionNameUpperBond, *collectionNameLowerBond, *collectionNameLeftBond, *collectionNameRightBond;
@property (nonatomic, strong) NSLayoutConstraint *trackTimeUpperBond, *trackTimeLowerBond, *trackTimeLeftBond, *trackTimeRightBond;
@property (nonatomic, strong) NSLayoutConstraint *coverURLUpperBond, *coverURLLowerBond, *coverURLLeftBond, *coverURLRightBond;
@property (nonatomic, strong) NSLayoutConstraint *descriptionUpperBond, *descriptionLowerBond, *descriptionLeftBond, *descriptionRightBond;
@property (nonatomic, strong) NSLayoutConstraint *readMoreUpperBond, *readMoreLowerBond, *readMoreLeftBond, *readMoreRightBond;
@property (nonatomic, strong) NSLayoutConstraint *addFavoriteUpperBond, *addFavoriteLowerBond, *addFavoriteLeftBond, *addFavoriteRightBond;
@property (nonatomic, strong) NSLayoutConstraint *removeFavoriteUpperBond, *removeFavoriteLowerBond, *removeFavoriteLeftBond, *removeFavoriteRightBond;
@end


@implementation searchResultTableViewCell {
}

@synthesize trackName = _trackName;
@synthesize artistName = _artistName;
@synthesize collectionName = _collectionName;
@synthesize trackTime = _trackTime;
@synthesize coverURL = _coverURL;
@synthesize description = _description;
@synthesize totalHeight = _totalHeight;
@synthesize readMore = _readMore;
@synthesize descriptionHeight = _descriptionHeight;
@synthesize addFavorite = _addFavorite;
@synthesize removeFavorite = _removeFavorite;


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self configureCell];
        [self checkDefaultColor];
    }
    return self;
}

-(void)checkDefaultColor {
    defaultColorManager = [DefaultColorManager new];
    BOOL settingColor = [defaultColorManager checkDefaultColor];
    if(settingColor == YES) {
        self.backgroundColor = [UIColor whiteColor];
    }else {
        self.backgroundColor = [UIColor lightGrayColor];
    }
}

-(void)configureCell {
    self.trackName = [[UILabel alloc] initWithFrame:CGRectZero];
    self.trackName.textColor = [UIColor blackColor];
    self.trackName.font = [UIFont fontWithName:@"Arial" size:18.0f];
    self.artistName = [[UILabel alloc] initWithFrame:CGRectZero];
    self.artistName.textColor = [UIColor blackColor];
    self.artistName.font = [UIFont fontWithName:@"Arial" size:12.0f];
    self.collectionName = [[UILabel alloc] initWithFrame:CGRectZero];
    self.collectionName.textColor = [UIColor blackColor];
    self.collectionName.font = [UIFont fontWithName:@"Arial" size:12.0f];
    self.description = [[UILabel alloc]initWithFrame:CGRectZero];
    self.description.textColor = [UIColor blackColor];
    self.description.font = [UIFont fontWithName:@"Arial" size:12.0f];
    self.readMore = [[UIButton alloc]initWithFrame:CGRectZero];
    [self.readMore setTitle:@"read more" forState:UIControlStateNormal];
    [self.readMore setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    [self.readMore.titleLabel setFont:  [UIFont fontWithName:@"Arial" size:12.0f]];
    self.readMore.backgroundColor = [UIColor cyanColor];
    self.trackTime = [[UILabel alloc] initWithFrame:CGRectZero];
    self.coverURL = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.addFavorite = [[UIButton alloc]initWithFrame:CGRectZero];
    [self.addFavorite setTitle:@"Like" forState:UIControlStateNormal];
    [self.addFavorite setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    [self.addFavorite.titleLabel setFont:  [UIFont fontWithName:@"Arial" size:16]];
    self.addFavorite.backgroundColor = [UIColor systemYellowColor];
    self.removeFavorite = [[UIButton alloc]initWithFrame:CGRectZero];
    [self.removeFavorite setTitle:@"Dislike" forState:UIControlStateNormal];
    [self.removeFavorite setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    [self.removeFavorite.titleLabel setFont:  [UIFont fontWithName:@"Arial" size:16]];
    self.removeFavorite.backgroundColor = [UIColor systemYellowColor];
    [self.contentView addSubview: self.trackName];
    [self.contentView addSubview: self.artistName];
    [self.contentView addSubview: self.collectionName];
    [self.contentView addSubview: self.trackTime];
    [self.contentView addSubview: self.coverURL];
    [self.contentView addSubview: self.description];
    [self.contentView addSubview: self.readMore];
    [self.contentView addSubview: self.addFavorite];
    [self.contentView addSubview: self.removeFavorite];
    [self setTrackNameLabel];
    [self setArtistNameLabel];
    [self setCollectionNameLabel];
    [self setTrackTimeLabel];
    [self setCoverURLImageView];
    [self setDescription];
    [self setReadMore];
    [self setAddFavorite];
    [self setRemoveFavorite];
    [self originTextLength];
}

-(void)setTrackNameLabel {
    self.trackName.translatesAutoresizingMaskIntoConstraints = NO;
    self.trackNameUpperBond = [self.trackName.topAnchor constraintEqualToAnchor: self.contentView.topAnchor constant: 10];
    self.trackNameUpperBond.active = YES;
    self.trackNameLowerBond = [self.trackName.heightAnchor constraintEqualToConstant:18];
    self.trackNameLowerBond.active = YES;
    self.trackNameLeftBond = [self.trackName.leadingAnchor constraintEqualToAnchor: self.contentView.leadingAnchor constant:80];
    self.trackNameLeftBond.active = YES;
    self.trackNameRightBond = [self.trackName.widthAnchor constraintEqualToConstant:200];
    self.trackNameRightBond.active = YES;
}

-(void)setArtistNameLabel {
    self.artistName.translatesAutoresizingMaskIntoConstraints = NO;
    self.artistNameUpperBond = [self.artistName.topAnchor constraintEqualToAnchor: self.trackName.bottomAnchor constant: 5];
    self.artistNameUpperBond.active = YES;
    self.artistNameLowerBond = [self.artistName.heightAnchor constraintEqualToConstant:15];
    self.artistNameLowerBond.active = YES;
    self.artistNameLeftBond = [self.artistName.leadingAnchor constraintEqualToAnchor: self.contentView.leadingAnchor constant:80];
    self.artistNameLeftBond.active = YES;
    self.artistNameRightBond = [self.artistName.widthAnchor constraintEqualToConstant:200];
    self.artistNameRightBond.active = YES;
}

-(void)setCollectionNameLabel {
    self.collectionName.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionNameUpperBond = [self.collectionName.topAnchor constraintEqualToAnchor: self.artistName.bottomAnchor constant: 5];
    self.collectionNameUpperBond.active = YES;
    self.collectionNameLowerBond = [self.collectionName.heightAnchor constraintEqualToConstant:15];
    self.collectionNameLowerBond.active = YES;
    self.collectionNameLeftBond = [self.collectionName.leadingAnchor constraintEqualToAnchor: self.contentView.leadingAnchor constant:80];
    self.collectionNameLeftBond.active = YES;
    self.collectionNameRightBond = [self.collectionName.widthAnchor constraintEqualToConstant:200];
    self.collectionNameRightBond.active = YES;
}

-(void)setTrackTimeLabel {
    self.trackTime.translatesAutoresizingMaskIntoConstraints = NO;
    self.trackTimeUpperBond = [self.trackTime.topAnchor constraintEqualToAnchor: self.collectionName.bottomAnchor constant: 5];
    self.trackTimeUpperBond.active = YES;
    self.trackTimeLowerBond = [self.trackTime.heightAnchor constraintEqualToConstant:15];
    self.trackTimeLowerBond.active = YES;
    self.trackTimeLeftBond = [self.trackTime.leadingAnchor constraintEqualToAnchor: self.contentView.leadingAnchor constant:80];
    self.trackTimeLeftBond.active = YES;
    self.trackTimeRightBond = [self.trackTime.widthAnchor constraintEqualToConstant:200];
    self.trackTimeRightBond.active = YES;
}

-(void)setCoverURLImageView {
    self.coverURL.translatesAutoresizingMaskIntoConstraints = NO;
    self.coverURLUpperBond = [self.coverURL.topAnchor constraintEqualToAnchor: self.contentView.topAnchor constant: 20];
    self.coverURLUpperBond.active = YES;
    self.coverURLLowerBond = [self.coverURL.heightAnchor constraintEqualToConstant:60];
    self.coverURLLowerBond.active = YES;
    self.coverURLLeftBond = [self.coverURL.leadingAnchor constraintEqualToAnchor: self.contentView.leadingAnchor constant:5];
    self.coverURLLeftBond.active = YES;
    self.coverURLRightBond = [self.coverURL.widthAnchor constraintEqualToConstant:60];
    self.coverURLRightBond.active = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    singleTap.numberOfTapsRequired = 1;
    [self.coverURL setUserInteractionEnabled:YES];
    [self.coverURL addGestureRecognizer:singleTap];
}

-(void)tapDetected: (UIImageView *)imageView{
    if(self.clickPhoto) {
        self.clickPhoto(imageView);
    }
}

-(void)setDescription{
    self.description.translatesAutoresizingMaskIntoConstraints = NO;
    self.descriptionUpperBond = [self.description.topAnchor constraintEqualToAnchor: self.trackTime.bottomAnchor constant: 5];
    self.descriptionUpperBond.active = YES;
    self.descriptionLowerBond = [self.description.bottomAnchor  constraintEqualToAnchor:self.contentView.bottomAnchor constant:-15];
    self.descriptionLowerBond.active = YES;
    self.descriptionLeftBond = [self.description.leadingAnchor constraintEqualToAnchor: self.contentView.leadingAnchor constant:80];
    self.descriptionLeftBond.active = YES;
    self.descriptionRightBond = [self.description.widthAnchor constraintEqualToConstant:200];
    self.descriptionRightBond.active = YES;
}

-(void)setReadMore {
    self.readMore.translatesAutoresizingMaskIntoConstraints = NO;
    self.readMoreUpperBond = [self.readMore.topAnchor constraintEqualToAnchor: self.addFavorite.bottomAnchor constant: 15];
    self.readMoreUpperBond.active = YES;
    self.readMoreLowerBond = [self.readMore.heightAnchor constraintEqualToConstant:40];
    self.readMoreLowerBond.active = YES;
    self.readMoreLeftBond = [self.readMore.leadingAnchor constraintEqualToAnchor: self.description.trailingAnchor constant:15];
    self.readMoreLeftBond.active = YES;
    self.readMoreRightBond = [self.readMore.widthAnchor constraintEqualToConstant:80];
    self.readMoreRightBond.active = YES;
}

-(void)setAddFavorite {
    self.addFavorite.translatesAutoresizingMaskIntoConstraints = NO;
    self.addFavoriteUpperBond = [self.addFavorite.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:10];
    self.addFavoriteUpperBond.active = YES;
    self.addFavoriteLowerBond = [self.addFavorite.heightAnchor constraintEqualToConstant:60];
    self.addFavoriteLowerBond.active = YES;
    self.addFavoriteLeftBond = [self.addFavorite.leadingAnchor constraintEqualToAnchor: self.artistName.trailingAnchor constant:15];
    self.addFavoriteLeftBond.active = YES;
    self.addFavoriteRightBond = [self.addFavorite.widthAnchor constraintEqualToConstant:80];
    self.addFavoriteRightBond.active = YES;
}

-(void)setRemoveFavorite {
    self.removeFavorite.translatesAutoresizingMaskIntoConstraints = NO;
    self.removeFavoriteUpperBond = [self.removeFavorite.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:10];
    self.removeFavoriteUpperBond.active = YES;
    self.removeFavoriteLowerBond = [self.removeFavorite.heightAnchor constraintEqualToConstant:60];
    self.removeFavoriteLowerBond.active = YES;
    self.removeFavoriteLeftBond = [self.removeFavorite.leadingAnchor constraintEqualToAnchor: self.artistName.trailingAnchor constant:15];
    self.removeFavoriteLeftBond.active = YES;
    self.removeFavoriteRightBond = [self.removeFavorite.widthAnchor constraintEqualToConstant:80];
    self.removeFavoriteRightBond.active = YES;
}

-(void)fitTextLength {
    self.description.numberOfLines = 0;
    [self.description sizeToFit];
}

-(void)originTextLength {
    self.description.numberOfLines = 2;
}

-(void)getRealHeight {
    self.description.numberOfLines = 0;
    [self.description sizeToFit];
    CGSize heightSize = CGSizeMake(200, 1000);
    self.descriptionHeight = [self.description sizeThatFits:heightSize].height;
    self.descriptionHeight += 1;
}


@end
