//
//  SchoolScoresViewController.m
//  20221026-MohammedAlQuarini-NYCSchools
//
//  Created by Mohammed Al-Quraini on 10/26/22.
//

#import "SchoolScoresViewController.h"

@interface SchoolScoresViewController ()
@property (nonatomic, strong) UILabel *schoolName;
@property (nonatomic, strong) UILabel *numOfTakers;
@property (nonatomic, strong) UILabel *rdAvg;
@property (nonatomic, strong) UILabel *mthAvg;
@property (nonatomic, strong) UILabel *wrAvg;
@property (nonatomic, strong) UIStackView *stackView;

@end

@implementation SchoolScoresViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup];
    [self layout];
    [self getSatScores];
}

- (void) setup {
    // set view background color to white
    [self.view setBackgroundColor: [UIColor whiteColor]];
    
    // setup stack view
    [self setupStackView];
    
    // setup labels
    [self setupLabels];
    
    [self.view addSubview: _stackView];
    [self.stackView addArrangedSubview:_numOfTakers];
    [self.stackView addArrangedSubview:_rdAvg];
    [self.stackView addArrangedSubview:_mthAvg];
    [self.stackView addArrangedSubview:_wrAvg];

}

-(void) setupStackView {
    self.stackView = [[UIStackView alloc] init];
    self.stackView.translatesAutoresizingMaskIntoConstraints = false;
    self.stackView.axis = UILayoutConstraintAxisVertical;
    self.stackView.spacing = 1;
    self.stackView.distribution = UIStackViewDistributionFillEqually;
}

-(void) setupLabels {
    // schoolName
    self.schoolName = [[UILabel alloc] init];
    [self.schoolName setFont:[UIFont systemFontOfSize:15 weight:UIFontWeightBold]];
    
    // numOfTakers
    self.numOfTakers = [[UILabel alloc] init];
    [self.numOfTakers setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightMedium]];
    
    // numOfTakers
    self.rdAvg = [[UILabel alloc] init];
    [self.rdAvg setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightMedium]];
    
    // numOfTakers
    self.mthAvg = [[UILabel alloc] init];
    [self.wrAvg setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightMedium]];
    
    // numOfTakers
    self.wrAvg = [[UILabel alloc] init];
    [self.wrAvg setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightMedium]];
    
}

// views constraints
-(void) layout {
    [NSLayoutConstraint activateConstraints:@[
        [_stackView.topAnchor constraintEqualToAnchor:[self.view topAnchor] constant: 20],
        [_stackView.leadingAnchor constraintEqualToAnchor:[self.view leadingAnchor] constant: 30],
        [_stackView.trailingAnchor constraintEqualToAnchor:[self.view trailingAnchor] constant: -30],
        [_stackView.bottomAnchor constraintEqualToAnchor:[self.view bottomAnchor] constant: -20],
    ]];
}

-(void) getSatScores {
    NSLog(@"fetching");
    NSString *stringUrl = @"https://data.cityofnewyork.us/resource/f9bf-2cp4.json?dbn=02M543";
    NSURL *url = [NSURL URLWithString:stringUrl];
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"finish fetching data");
        
        NSString *dummyString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", dummyString);
        
        NSError *err;
        [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        
        if(err) {
            NSLog(@"Failed to serialize the json %@", err);
            return;
        }
    }] resume];
}
@end
