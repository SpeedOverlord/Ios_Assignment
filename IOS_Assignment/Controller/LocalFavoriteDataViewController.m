//
//  LocalFavoriteDataViewController.m
//  IOS_Assignment
//
//  Created by ESB21632 on 2021/1/20.
//  Copyright © 2021 陳彥廷21632. All rights reserved.
//

#import "LocalFavoriteDataViewController.h"
#import "previousButtonView.h"
#import "DefaultColorManager.h"
#import "localFavoriteMovieButtonView.h"
#import "localFavoriteMusicButtonView.h"
#import "localFavoriteTableViewCell.h"
#import <SDWebImage/SDWebImage.h>
#import "FavoriteManager.h"
#import "AppleITunesSelectedItemViewController.h"

@interface LocalFavoriteDataViewController ()<UITableViewDelegate, UITableViewDataSource> {
    float screenWidthRatio;
    previousButtonView *previousButton;
    UITableView *localFavoriteTable;
    localFavoriteMovieButtonView *localFavoriteMovieBtn;
    localFavoriteMusicButtonView *localFavoriteMusicBtn;
    DefaultColorManager *defaultManager;
    DefaultColorManager *defaultColorManager;
    NSUserDefaults *favoriteData;
    NSMutableArray *currentFavoriteArray;
    NSMutableArray *specificFavoriteArray;
    NSMutableArray *isCellExtendArray;
    FavoriteManager *favoriteManager;
    NSString *trackViewUrl;
    
}

@property (nonatomic, strong) NSLayoutConstraint *previousBtnUpperBond, *previousBtnLowerBond, *previousBtnLeftBond, *previousBtnRightBond;

@property (nonatomic, strong) NSLayoutConstraint *localFavoriteUpper, *localFavoriteLower, *localFavoriteLeft, *localFavoriteRight;

@property (nonatomic, strong) NSLayoutConstraint *localMovieUpper, *localMovieLower, *localMovieLeft, *localMovieRight;

@property (nonatomic, strong) NSLayoutConstraint *localMusicUpper, *localMusicLower, *localMusicLeft, *localMusicRight;


@end

@implementation LocalFavoriteDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    defaultManager = [DefaultColorManager new];
    currentFavoriteArray = [NSMutableArray new];
    specificFavoriteArray = [NSMutableArray new];
    favoriteManager = [[FavoriteManager alloc]init];
    [self initUIView];
    [self calculateWidthRatio];
    [self configurePreviousPageBtn];
    [self setPreviousPageBtn];
    [self previousPageButtonBlock];
    [self configureLocalFavoriteMovieBtn];
    [self setLocalFavoriteMovieBtn];
    [self localFavoriteMovieBtnBlock];
    [self configureLocalFavoriteMusicBtn];
    [self setLocalFavoriteMusicBtn];
    [self localFavoriteMusicBtnBlock];
}

-(void)initUIView {
    BOOL currentColorSettingIsLight = [defaultManager checkDefaultColor];
    if(currentColorSettingIsLight == YES) {
        self.view.backgroundColor = [UIColor whiteColor];
    }else {
        self.view.backgroundColor = [UIColor lightGrayColor];
    }
}

- (void)calculateWidthRatio {
    screenWidthRatio = [UIScreen mainScreen].bounds.size.width / 375;
}

#pragma mark -previousPageBtn
-(void)configurePreviousPageBtn {
    previousButton = [[previousButtonView alloc]initWithFrame:CGRectZero];
    previousButton.backgroundColor = [UIColor whiteColor];
    previousButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: previousButton];
}

-(void)setPreviousPageBtn {
    self.previousBtnUpperBond = [previousButton.topAnchor constraintEqualToAnchor: self.view.topAnchor constant:70];
    self.previousBtnLowerBond = [previousButton.heightAnchor constraintEqualToConstant:50];
    self.previousBtnLeftBond = [previousButton.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor constant:15];
    self.previousBtnRightBond = [previousButton.widthAnchor constraintEqualToConstant:50];
    self.previousBtnUpperBond.active = YES;
    self.previousBtnLowerBond.active = YES;
    self.previousBtnLeftBond.active = YES;
    self.previousBtnRightBond.active = YES;
}

-(void)previousPageButtonBlock {
    __weak typeof (self) weakSelf = self;
    previousButton.buttonAction = ^(UIButton* _Nonnull sender) {
        [weakSelf onClickPreviousPageButton];
    };
}

-(void)onClickPreviousPageButton {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark -local Favorite movie button
-(void)configureLocalFavoriteMovieBtn {
    localFavoriteMovieBtn = [[localFavoriteMovieButtonView alloc]initWithFrame:CGRectZero];
    localFavoriteMovieBtn.backgroundColor = [UIColor whiteColor];

    localFavoriteMovieBtn.clipsToBounds = YES;
    localFavoriteMovieBtn.layer.cornerRadius = 5;
    localFavoriteMovieBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: localFavoriteMovieBtn];
}

-(void)setLocalFavoriteMovieBtn {
    self.localMovieUpper = [localFavoriteMovieBtn.topAnchor constraintEqualToAnchor: self.view.topAnchor constant:110];
    self.localMovieLower = [localFavoriteMovieBtn.heightAnchor constraintEqualToConstant:30];
    self.localMovieLeft = [localFavoriteMovieBtn.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor constant:107.5];
    self.localMovieRight = [localFavoriteMovieBtn.widthAnchor constraintEqualToConstant:80];
    self.localMovieUpper.active = YES;
    self.localMovieLower.active = YES;
    self.localMovieLeft.active = YES;
    self.localMovieRight.active = YES;
}

-(void)localFavoriteMovieBtnBlock {
    __weak typeof (self) weakSelf = self;
    localFavoriteMovieBtn.buttonAction = ^(UIButton* _Nonnull sender) {
        [weakSelf onClickLocalFavoriteMovieBtn];
    };
}

-(void)onClickLocalFavoriteMovieBtn {
    [specificFavoriteArray removeAllObjects];
    [isCellExtendArray removeAllObjects];
    isCellExtendArray = [[NSMutableArray alloc] init];
    favoriteData = [NSUserDefaults standardUserDefaults];
    currentFavoriteArray = [favoriteData objectForKey:@"FavoriteData"];
    for(int i = 0; i < [currentFavoriteArray count]; i++) {
        if([[currentFavoriteArray[i] valueForKey:@"kind"] isEqualToString:@"feature-movie"]) {
            [specificFavoriteArray addObject:(currentFavoriteArray[i])];
            [isCellExtendArray addObject:[NSNumber numberWithInt:0]];
        }
    }
    [self configureFavoriteTableView];
}

#pragma mark -local Favorite music button
-(void)configureLocalFavoriteMusicBtn {
    localFavoriteMusicBtn = [[localFavoriteMusicButtonView alloc]initWithFrame:CGRectZero];
    localFavoriteMusicBtn.backgroundColor = [UIColor whiteColor];

    localFavoriteMusicBtn.clipsToBounds = YES;
    localFavoriteMusicBtn.layer.cornerRadius = 5;
    localFavoriteMusicBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: localFavoriteMusicBtn];
}

-(void)setLocalFavoriteMusicBtn {
    self.localMusicUpper = [localFavoriteMusicBtn.topAnchor constraintEqualToAnchor: self.view.topAnchor constant:110];
    self.localMusicLower = [localFavoriteMusicBtn.heightAnchor constraintEqualToConstant:30];
    self.localMusicLeft = [localFavoriteMusicBtn.leadingAnchor constraintEqualToAnchor: localFavoriteMovieBtn.trailingAnchor];
    self.localMusicRight = [localFavoriteMusicBtn.widthAnchor constraintEqualToConstant:80];
    self.localMusicUpper.active = YES;
    self.localMusicLower.active = YES;
    self.localMusicLeft.active = YES;
    self.localMusicRight.active = YES;
}

-(void)localFavoriteMusicBtnBlock {
    __weak typeof (self) weakSelf = self;
    localFavoriteMusicBtn.buttonAction = ^(UIButton* _Nonnull sender) {
        [weakSelf onClickLocalFavoriteMusicBtn];
    };
}

-(void)onClickLocalFavoriteMusicBtn {
    [specificFavoriteArray removeAllObjects];
    [isCellExtendArray removeAllObjects];
    isCellExtendArray = [[NSMutableArray alloc] init];
    favoriteData = [NSUserDefaults standardUserDefaults];
    currentFavoriteArray = [favoriteData objectForKey:@"FavoriteData"];
    for(int i = 0; i < [currentFavoriteArray count]; i++) {
        if([[currentFavoriteArray[i] valueForKey:@"kind"] isEqualToString:@"song"]) {
            [specificFavoriteArray addObject:(currentFavoriteArray[i])];
            [isCellExtendArray addObject:[NSNumber numberWithInt:0]];
        }
    }
    [self configureFavoriteTableView];
}

#pragma mark -configure tableView
-(void)configureFavoriteTableView {
    [localFavoriteTable removeFromSuperview];
    localFavoriteTable = [[UITableView alloc]initWithFrame:CGRectZero];
    localFavoriteTable.delegate = self;
    localFavoriteTable.dataSource = self;
    localFavoriteTable.estimatedRowHeight = 140;
    [localFavoriteTable registerClass:localFavoriteTableViewCell.class forCellReuseIdentifier:@"LocalFavorite"];
    localFavoriteTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self checkDefaultColorSetting];
    [self.view addSubview: localFavoriteTable];
    [self setFavoriteTableView];
}

- (void)setFavoriteTableView {
    localFavoriteTable.translatesAutoresizingMaskIntoConstraints = NO;
    self.localFavoriteUpper = [localFavoriteTable.topAnchor constraintEqualToAnchor: localFavoriteMovieBtn.bottomAnchor constant: 10];
    self.localFavoriteUpper.active = YES;
    self.localFavoriteLower = [localFavoriteTable.heightAnchor constraintEqualToConstant:600];
    self.localFavoriteLower.active = YES;
    self.localFavoriteLeft = [localFavoriteTable.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:5];
    self.localFavoriteLeft.active = YES;
    self.localFavoriteRight = [localFavoriteTable.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-5];
    self.localFavoriteRight.active = YES;
    self.localFavoriteUpper.constant = 10 * screenWidthRatio;
    self.localFavoriteLower.constant = 630 * screenWidthRatio;
    self.localFavoriteLeft.constant = 5 * screenWidthRatio;
    self.localFavoriteRight.constant = -5 * screenWidthRatio;
}

#pragma mark -tableView datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return specificFavoriteArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"LocalFavorite";
    localFavoriteTableViewCell *cell = (localFavoriteTableViewCell *)[localFavoriteTable dequeueReusableCellWithIdentifier: cellIdentifier];
    [cell setSeparatorInset:UIEdgeInsetsZero];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [cell checkDefaultColor];
    cell.artistName.text = [specificFavoriteArray[indexPath.row] valueForKey:@"artistName"];
    cell.trackName.text = [specificFavoriteArray[indexPath.row] valueForKey:@"trackName"];
    if([specificFavoriteArray[indexPath.row] valueForKey:@"collectionName"] == NULL) {
        cell.collectionName.text = @"";
    }else {
        cell.collectionName.text = [specificFavoriteArray[indexPath.row] valueForKey:@"collectionName"];
    }
    NSNumber *timeInMillis = [specificFavoriteArray[indexPath.row] valueForKey:@"trackTimeMillis"];
    if(timeInMillis == (id)[NSNull null]) {
        cell.trackTime.text = @"";
    }else {
        NSString *time = [self convertMillisToSecondAndMinutes: timeInMillis];
        cell.trackTime.text = time;
    }
    
    [cell.coverURL sd_setImageWithURL: [specificFavoriteArray[indexPath.row] valueForKey:@"artworkUrl60"]
    placeholderImage:[UIImage imageNamed:@"Personal_Data_1x.png"] options:SDWebImageRetryFailed];
    cell.coverURL.tag =  indexPath.row;
    [self clickPhotoBlock:cell];
    
    NSString *description = [specificFavoriteArray[indexPath.row] valueForKey:@"longDescription"];
      if(description == (id)[NSNull null]) {
           cell.description.text = @"";
       }else {
           cell.description.text = description;
       }
    [cell getRealHeight];
    if( cell.descriptionHeight > 30) {
        cell.readMore.hidden = NO;
        cell.readMore.tag = indexPath.row;
        [cell.readMore addTarget:self action: @selector(onClickReadMoreButton:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        cell.readMore.hidden = YES;
    }
    
    //description height
     if( isCellExtendArray[indexPath.row] == [NSNumber numberWithInt:1]) {
         [cell fitTextLength];
     }else if( isCellExtendArray[indexPath.row] == [NSNumber numberWithInt:0]){
         [cell originTextLength];
     }else {
         [cell originTextLength];
     }
    //addFavorite
    NSString *isFavorite =  [specificFavoriteArray[indexPath.row] valueForKey:@"trackName"];
    BOOL favoriteStatus = [favoriteManager isFavorite: isFavorite];
    
    //removeFavorite
    NSLog(@"status %d", favoriteStatus);
    if(favoriteStatus == YES) {
        cell.removeFavorite.hidden = NO;
        cell.removeFavorite.tag = indexPath.row;
        [cell.removeFavorite addTarget:self action: @selector(onClickRemoveFavoriteButton:) forControlEvents:UIControlEventTouchUpInside];
    }else {
        cell.removeFavorite.hidden = YES;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setSeparatorInset:UIEdgeInsetsZero];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark -color setting
-(void)checkDefaultColorSetting {
    defaultColorManager = [DefaultColorManager new];
    if([defaultColorManager checkDefaultColor] == YES) {
        self.view.backgroundColor = [UIColor whiteColor];
        localFavoriteTable.backgroundColor = [UIColor whiteColor];
        [localFavoriteTable reloadData];
    }else {
        self.view.backgroundColor = [UIColor lightGrayColor];
        localFavoriteTable.backgroundColor = [UIColor lightGrayColor];
        [localFavoriteTable reloadData];
    }
}

#pragma mark -time converter
-(NSString *)convertMillisToSecondAndMinutes : (NSNumber *)timeInMillis{
    double timeInSecond = [timeInMillis intValue] / 1000;
    int miniutes = timeInSecond / 60;
    int modTimeInSecond = (int)timeInSecond % 60;
    NSString *addZero;
    NSString *time;
    if(modTimeInSecond < 10) {
        addZero = [NSString stringWithFormat:@"0%d", modTimeInSecond];
        time = [NSString stringWithFormat: @"%d : %@", miniutes, addZero];
    } else {
         time = [NSString stringWithFormat: @"%d : %d", miniutes, modTimeInSecond];
    }
    return time;
}

#pragma mark -readMore action
-(void)onClickReadMoreButton:(UIButton *)sender {
  //  currentRow = (int)sender.tag;
    isCellExtendArray[sender.tag] = [NSNumber numberWithInt:1];
    [self->localFavoriteTable beginUpdates];
    [self->localFavoriteTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0]] withRowAnimation: UITableViewRowAnimationNone];
    [self->localFavoriteTable endUpdates];
}

#pragma mark -removeLike action
-(void)onClickRemoveFavoriteButton: (UIButton *)sender {
    int currentRow = (int)sender.tag % 1000;
    NSArray *tempArray = specificFavoriteArray[currentRow];
    [favoriteManager deleteFavorite:tempArray];
    [specificFavoriteArray removeObjectAtIndex:currentRow];
    [isCellExtendArray removeObjectAtIndex:currentRow];
    [localFavoriteTable reloadData];
}

#pragma mark -click photo
-(void)clickPhotoBlock: (localFavoriteTableViewCell *)cell {
    __weak typeof (self) weakSelf = self;
    int getTag = (int)cell.coverURL.tag;
    cell.clickPhoto = ^(UIImageView* _Nonnull imageView) {
        [weakSelf onClickPhoto:getTag];
    };
}

-(void)onClickPhoto: (int)tag{
    int currentRow = tag % 1000;
    trackViewUrl = [NSString stringWithString:    [specificFavoriteArray[currentRow] valueForKey:@"trackViewUrl"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackViewUrl]];
    
}

@end
