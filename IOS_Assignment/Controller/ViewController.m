//
//  ViewController.m
//  IOS_Assignment
//
//  Created by 陳彥廷21632 on 2020/12/28.
//  Copyright © 2020 陳彥廷21632. All rights reserved.
//

#import "ViewController.h"
#import "InputView.h"
#import "searchButtonView.h"
#import "SearchITunesMusic.h"
#import "searchResultTableViewCell.h"
#import <SDWebImage/SDWebImage.h>
#import "FavoriteManager.h"
#import "DefaultColorManager.h"
#import "AppleITunesSelectedItemViewController.h"


@interface ViewController() <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>{
    InputView *textField;
    NSInteger screenWidthRatio;
    searchButtonView *searchButton;
    NSDictionary *searchDataDictionary;
    UITableView *tableView;
    NSArray *searchData;
    NSMutableArray *musicSearchArray;
    NSMutableArray *movieSearchArray;
    NSMutableArray *searchDataArray;
    NSMutableArray *isCellExtendArray;
    int currentRow;
    int movieSectionRows;
    int fixHeight;
    NSMutableArray *cellExtendHeightArray;
    FavoriteManager *favoriteManager;
    DefaultColorManager *defaultColorManager;
    NSString *trackViewUrl;
}

@property (nonatomic, strong) NSLayoutConstraint *textFieldUpperBond, *textFieldLowerBond, *textFieldLeftBond, *textFieldRightBond;
@property (nonatomic, strong)NSLayoutConstraint *searchButtonUpperBond, *searchButtonLowerBond, *searchButtonLeftBond, *searchButtonRightBond;
@property (nonatomic, strong) NSLayoutConstraint *tableViewUpperBond, *tableViewLowerBond, *tableViewLeftBond, *tableViewRightBond;

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated {
    [self checkDefaultColorSetting];
    [textField changeDefaultColor];
}

#pragma mark -viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self checkDefaultColorSetting];
    [self initSearchDataArray];
    [self calculateWidthRatio];
    [self configureTextField];
    [self setTextField];
    [self textfieldFitScreenSize];
    [self configureSearchButton];
    [self setSearchButton];
    [self searchButtonFitScreenSize];
    [self searchButtonBlock];
}

-(void)checkDefaultColorSetting {
    defaultColorManager = [DefaultColorManager new];
    if([defaultColorManager checkDefaultColor]) {
        self.view.backgroundColor = [UIColor whiteColor];
        tableView.backgroundColor = [UIColor whiteColor];
        [tableView reloadData];
    }else {
        self.view.backgroundColor = [UIColor lightGrayColor];
        tableView.backgroundColor = [UIColor lightGrayColor];
        [tableView reloadData];
    }
}

-(void)initSearchDataArray {
    musicSearchArray = [[NSMutableArray alloc]init];
    movieSearchArray = [[NSMutableArray alloc]init];
    searchDataArray = [[NSMutableArray alloc]init];
}

- (void)calculateWidthRatio {
    screenWidthRatio = [UIScreen mainScreen].bounds.size.width / 375;
}

-(void)initFavoriteManager {
    favoriteManager = [[FavoriteManager alloc]init];
}

#pragma mark -inputTextFieldView
- (void)configureTextField {
    textField = [[InputView alloc]initWithFrame:CGRectZero];
    textField.backgroundColor = [UIColor grayColor];
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: textField];
}

- (void)setTextField {
    self.textFieldUpperBond = [textField.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:50];
    self.textFieldUpperBond.active = YES;
    self.textFieldLowerBond = [textField.heightAnchor constraintEqualToConstant:150];
    self.textFieldLowerBond.active = YES;
    self.textFieldLeftBond = [textField.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:100];
    self.textFieldLeftBond.active = YES;
    self.textFieldRightBond = [textField.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:150];
    self.textFieldRightBond.active = YES;
    textField.textField.delegate = self;
}

- (void)textfieldFitScreenSize{
    self.textFieldUpperBond.constant = 50 * screenWidthRatio;
    self.textFieldLowerBond.constant = 40 * screenWidthRatio;
    self.textFieldLeftBond.constant = 5 * screenWidthRatio;
    self.textFieldRightBond.constant = -70 * screenWidthRatio;
}

#pragma mark -searchButtonView
-(void)configureSearchButton {
    searchButton = [[searchButtonView alloc]initWithFrame:CGRectZero];
    searchButton.backgroundColor = [UIColor blackColor];
    searchButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:searchButton];
}

-(void)setSearchButton {
    self.searchButtonUpperBond = [searchButton.topAnchor constraintEqualToAnchor: self.view.topAnchor constant: 50];
    self.searchButtonUpperBond.active = YES;
    self.searchButtonLowerBond = [searchButton.heightAnchor constraintEqualToConstant:100];
    self.searchButtonLowerBond.active = YES;
    self.searchButtonLeftBond = [searchButton.leadingAnchor constraintEqualToAnchor:textField.trailingAnchor constant:30];
    self.searchButtonLeftBond.active = YES;
    self.searchButtonRightBond = [searchButton.widthAnchor constraintEqualToConstant:100];
    self.searchButtonRightBond.active = YES;
}

-(void)searchButtonFitScreenSize {
    self.searchButtonUpperBond.constant = 50 * screenWidthRatio;
    self.searchButtonLowerBond.constant = 50 * screenWidthRatio;
    self.searchButtonLeftBond.constant = 15 * screenWidthRatio;
    self.searchButtonRightBond.constant = 50 * screenWidthRatio;
}

-(void)searchButtonBlock{
    __weak typeof(self) weakSelf = self;
    searchButton.buttonAction = ^(UIButton* _Nonnull sender) {
        [weakSelf onClickSearchButton];
    };
}

#pragma mark -inputViewDelegate methods
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.text = @"";
    [textField becomeFirstResponder];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


#pragma mark -searchButtonView Action
-(void)onClickSearchButton {
    NSString *fixedString = [self replaceSpaceWithAddition:textField.textField.text];
    [[SearchITunesMusic alloc] initSearch:fixedString musicBlock:^(NSDictionary * returnObj) {
        NSMutableArray *searchDataArray = [[NSMutableArray alloc]init];
        [self initFavoriteManager];
        [self separateSearchData:returnObj searchDataArray:searchDataArray];
        [self configureTableView];
        [self->textField resignTextField];
    }];
}

#pragma mark -replaceSpaceWithAddition
-(NSString *)replaceSpaceWithAddition: (NSString*) stringWantToChange{
    NSString *replacedString = [stringWantToChange stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    return replacedString;
}

#pragma mark -seperateAndStoreData
-(void)separateSearchData: (NSDictionary *)returnObj searchDataArray: (NSMutableArray *)searchDataArray{
    searchDataDictionary = returnObj;
    searchData = (NSArray *) searchDataDictionary[@"results"];
    int dataLength = (int)[searchData count];
    [self storeMusicData: searchDataDictionary dataLength: dataLength];
    [self storeMovieData: searchDataDictionary dataLength: dataLength];
    [self combineDataArray];
    [self initExtendCellArray];
}

-(void)storeMusicData: (NSDictionary*) searchDictionary dataLength:(int) dataLength{
    [musicSearchArray removeAllObjects];
    for (int i = 0; i < dataLength; i++) {
        if([[searchDataDictionary[@"results"][i]valueForKey:@"kind"]  isEqual: @"song"]) {
            [musicSearchArray addObject:(searchDataDictionary[@"results"][i])];
        }
    }
}

-(void)storeMovieData: (NSDictionary*) searchDictionary dataLength:(int) dataLength{
    [movieSearchArray removeAllObjects];
    for (int i = 0; i <dataLength; i++) {
        if([[searchDictionary[@"results"][i]valueForKey:@"kind"] isEqual: @"feature-movie"]) {
            [movieSearchArray addObject:(searchDataDictionary[@"results"][i])];
        }
    }
}

-(void)combineDataArray {
    [searchDataArray removeAllObjects];
    [searchDataArray addObject: movieSearchArray];
    [searchDataArray addObject: musicSearchArray];
}

-(void)initExtendCellArray {
     movieSectionRows = (int)[(NSArray*)[searchDataArray objectAtIndex:0] count];
    isCellExtendArray = [[NSMutableArray alloc] init];
    cellExtendHeightArray = [[NSMutableArray alloc] init];
    for(int i = 0; i< movieSectionRows;  i++) {
        [isCellExtendArray addObject: [NSNumber numberWithInt:0]];
        [cellExtendHeightArray addObject: [NSNumber numberWithInt:0]];
    }
}

#pragma mark -configure tableView
-(void)configureTableView {
    [tableView removeFromSuperview];
    tableView = [[UITableView alloc]initWithFrame:CGRectZero];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 140;
    [tableView registerClass:searchResultTableViewCell.class forCellReuseIdentifier:@"SearchCell"];
    [self checkDefaultColorSetting];
    [self.view addSubview: tableView];
    [self setTableView];
}

- (void)setTableView {
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableViewUpperBond = [tableView.topAnchor constraintEqualToAnchor: textField.bottomAnchor constant: 30];
    self.tableViewUpperBond.active = YES;
    self.tableViewLowerBond = [tableView.heightAnchor constraintEqualToConstant:600];
    self.tableViewLowerBond.active = YES;
    self.tableViewLeftBond = [tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:5];
    self.tableViewLeftBond.active = YES;
    self.tableViewRightBond = [tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-5];
    self.tableViewRightBond.active = YES;
    self.tableViewUpperBond.constant = 30 * screenWidthRatio;
    self.tableViewLowerBond.constant = 700 * screenWidthRatio;
    self.tableViewLeftBond.constant = 5 * screenWidthRatio;
    self.tableViewRightBond.constant = -5 * screenWidthRatio;
}

#pragma mark -tableView datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [searchDataArray count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [(NSArray*)[searchDataArray objectAtIndex:section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"SearchCell";
    searchResultTableViewCell *cell = (searchResultTableViewCell *)[tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    [cell checkDefaultColor];
    //artist name
    cell.artistName.text = [[[searchDataArray objectAtIndex: indexPath.section] valueForKey:@"artistName"] objectAtIndex:indexPath.row];
    //track name
    cell.trackName.text = [[[searchDataArray objectAtIndex: indexPath.section] valueForKey:@"trackName"] objectAtIndex:indexPath.row];
    //collection name
    NSString *collectionName = [[[searchDataArray objectAtIndex: indexPath.section] valueForKey:@"collectionName"] objectAtIndex:indexPath.row];
    if(collectionName == (id)[NSNull null]) {
        cell.collectionName.text = @"";
    }else {
        cell.collectionName.text = collectionName;
    }
    //time
    NSNumber *timeInMillis = [[[searchDataArray objectAtIndex: indexPath.section] valueForKey:@"trackTimeMillis"] objectAtIndex:indexPath.row];
    if(timeInMillis == (id)[NSNull null]) {
        cell.trackTime.text = @"";
    }else {
        NSString *time = [self convertMillisToSecondAndMinutes: timeInMillis];
        cell.trackTime.text = time;
    }
    //coverUrl
    [cell.coverURL sd_setImageWithURL:[NSURL URLWithString:[[[searchDataArray objectAtIndex: indexPath.section] valueForKey:@"artworkUrl60"] objectAtIndex:indexPath.row]]
    placeholderImage:[UIImage imageNamed:@"Personal_Data_1x.png"] options:SDWebImageRetryFailed];
    //description
    NSString *description = [[[searchDataArray objectAtIndex: indexPath.section] valueForKey:@"longDescription"] objectAtIndex:indexPath.row];
    if(description == (id)[NSNull null]) {
         cell.description.text = @"";
     }else {
         cell.description.text = description;
     }
    //get description height and set readmore btn
    [cell getRealHeight];
    if(indexPath.section == 0 && cell.descriptionHeight > 30) {
        cellExtendHeightArray[indexPath.row] = [NSNumber numberWithInt:cell.descriptionHeight];
        cell.readMore.hidden = NO;
        cell.readMore.tag = indexPath.row;
        [cell.readMore addTarget:self action: @selector(onClickReadMoreButton:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        cell.readMore.hidden = YES;
    }
    //description height
    if(indexPath.section == 0 && isCellExtendArray[indexPath.row] == [NSNumber numberWithInt:1]) {
        [cell fitTextLength];
    }else if(indexPath.section == 0 && isCellExtendArray[indexPath.row] == [NSNumber numberWithInt:0]){
        [cell originTextLength];
    }else {
         [cell originTextLength];
    }
    //addFavorite
    NSString *isFavorite = [[[searchDataArray objectAtIndex: indexPath.section] valueForKey:@"trackName"] objectAtIndex:indexPath.row];
    BOOL favoriteStatus = [favoriteManager isFavorite: isFavorite];
    if(indexPath.section == 0) {
        if(!favoriteStatus ) {
            cell.addFavorite.hidden = NO;
            cell.addFavorite.tag =
            (indexPath.section * 1000 + indexPath.row);
            [cell.addFavorite addTarget:self action: @selector(onClickAddFavoriteButton:) forControlEvents:UIControlEventTouchUpInside];
        }else {
            cell.addFavorite.hidden = YES;
        }
    }else if(indexPath.section == 1) {
        if(!favoriteStatus) {
            cell.addFavorite.hidden = NO;
            cell.addFavorite.tag = (indexPath.section * 1000 + indexPath.row);
            [cell.addFavorite addTarget:self action: @selector(onClickAddFavoriteButton:) forControlEvents:UIControlEventTouchUpInside];
        }else {
            cell.addFavorite.hidden = YES;
        }
    }
    
    //removeFavorite
    if(indexPath.section == 0) {
        if(favoriteStatus) {
            cell.removeFavorite.hidden = NO;
            cell.removeFavorite.tag = (indexPath.section * 1000 + indexPath.row);
            [cell.removeFavorite addTarget:self action: @selector(onClickRemoveFavoriteButton:) forControlEvents:UIControlEventTouchUpInside];
        }else {
            cell.removeFavorite.hidden = YES;
        }
    }else if(indexPath.section == 1) {
        if(favoriteStatus) {
            cell.removeFavorite.hidden = NO;
            cell.removeFavorite.tag = (indexPath.section * 1000 + indexPath.row);
            [cell.removeFavorite addTarget:self action: @selector(onClickRemoveFavoriteButton:) forControlEvents:UIControlEventTouchUpInside];
        }else {
            cell.removeFavorite.hidden = YES;
        }
    }
    cell.coverURL.tag = (indexPath.section*1000 + indexPath.row);
    [self clickPhotoBlock:cell];
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"電影";
            break;
        case 1:
            return @"音樂";
            break;
            
        default:
            return @"";
            break;
    }
}

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
    currentRow = (int)sender.tag;
    isCellExtendArray[currentRow] = [NSNumber numberWithInt:1];
    [self->tableView beginUpdates];
    [self->tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:sender.tag inSection:0]] withRowAnimation: UITableViewRowAnimationNone];
    [self->tableView endUpdates];
}

#pragma mark -clickLike action
-(void)onClickAddFavoriteButton: (UIButton *)sender {
    int currentSection = (int)sender.tag / 1000;
    int currentRow = (int)sender.tag % 1000;
    NSArray *tempArray =
    [[searchDataArray objectAtIndex: currentSection]  objectAtIndex:currentRow];
    [favoriteManager addFavorite:tempArray];
    [self->tableView beginUpdates];
    [self->tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:currentRow inSection:currentSection]] withRowAnimation: UITableViewRowAnimationNone];
    [self->tableView endUpdates];
}

#pragma mark -removeLike action
-(void)onClickRemoveFavoriteButton: (UIButton *)sender {
    int currentSection = (int)sender.tag / 1000;
    int currentRow = (int)sender.tag % 1000;
    NSArray *tempArray =
    [[searchDataArray objectAtIndex: currentSection]  objectAtIndex:currentRow];
    [favoriteManager deleteFavorite:tempArray];
    [self->tableView beginUpdates];
    [self->tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:currentRow inSection:currentSection]] withRowAnimation: UITableViewRowAnimationNone];
    [self->tableView endUpdates];
}

#pragma mark -click photo
-(void)clickPhotoBlock: (searchResultTableViewCell *)cell {
    __weak typeof (self) weakSelf = self;
    int getTag = (int)cell.coverURL.tag;
    cell.clickPhoto = ^(UIImageView* _Nonnull imageView) {
        [weakSelf onClickPhoto:getTag];
    };
}

-(void)onClickPhoto: (int)tag{
    int currentRow = tag % 1000;
    int currentSection = tag / 1000;
    UIApplication *application = [UIApplication sharedApplication];
    trackViewUrl = [NSString stringWithString:[[[searchDataArray objectAtIndex: currentSection] valueForKey:@"trackViewUrl"] objectAtIndex:currentRow]];
    NSURL *nsUrl = [NSURL URLWithString: trackViewUrl];
    [application openURL:nsUrl options:@{} completionHandler:^(BOOL success) {
    }];
}

@end
