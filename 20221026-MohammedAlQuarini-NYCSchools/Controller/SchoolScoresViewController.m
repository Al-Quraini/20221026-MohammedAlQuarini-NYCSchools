//
//  SchoolScoresViewController.m
//  20221026-MohammedAlQuarini-NYCSchools
//
//  Created by Mohammed Al-Quraini on 10/26/22.
//

#import "SchoolScoresViewController.h"
#import "SATScore.h"

@interface SchoolScoresViewController ()
@property (nonatomic, strong) NSString *dbn;

@property (nonatomic, strong) UILabel *schoolName;
@property (nonatomic, strong) UILabel *numOfTakers;
@property (nonatomic, strong) UILabel *rdAvg;
@property (nonatomic, strong) UILabel *mthAvg;
@property (nonatomic, strong) UILabel *wrAvg;
@property (nonatomic, strong) UIStackView *stackView;

@end

@implementation SchoolScoresViewController

- (id) initWithDbn:(NSString *)dbn{
    self = [super init];
        if (self) {
            _dbn = dbn;
        }
        return self;
}

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
    [self.stackView addArrangedSubview:_schoolName];
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
    self.stackView.distribution = UIStackViewDistributionEqualCentering;
}

-(void) setupLabels {
    // schoolName
    self.schoolName = [[UILabel alloc] init];
    [self.schoolName setFont:[UIFont systemFontOfSize:25 weight:UIFontWeightBold]];
    [self.schoolName setNumberOfLines:0];
    
    // numOfTakers
    self.numOfTakers = [[UILabel alloc] init];
    [self.numOfTakers setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightMedium]];
    
    // numOfTakers
    self.rdAvg = [[UILabel alloc] init];
    [self.rdAvg setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightMedium]];
    
    // numOfTakers
    self.mthAvg = [[UILabel alloc] init];
    [self.wrAvg setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightMedium]];
    
    // numOfTakers
    self.wrAvg = [[UILabel alloc] init];
    [self.wrAvg setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightMedium]];
    
}

// views constraints
-(void) layout {
    UILayoutGuide *safeArea = self.view.safeAreaLayoutGuide;
    [NSLayoutConstraint activateConstraints:@[
        [_stackView.topAnchor constraintEqualToAnchor:[safeArea topAnchor] constant: 30],
        [_stackView.leadingAnchor constraintEqualToAnchor:[safeArea leadingAnchor] constant: 30],
        [_stackView.trailingAnchor constraintEqualToAnchor:[safeArea trailingAnchor] constant: -30],
        [_stackView.bottomAnchor constraintEqualToAnchor:[safeArea bottomAnchor] constant: -30],
    ]];
}

-(void) configLabels :(SATScore*) model  {
    [self.schoolName setText: [NSString stringWithFormat: @"School Name: %@", model.schoolName]];
    [self.numOfTakers setText: [NSString stringWithFormat: @"School Name: %@", model.numOfTakers]];
    [self.rdAvg setText: [NSString stringWithFormat: @"School Name: %@", model.rdAvg]];
    [self.mthAvg setText: [NSString stringWithFormat: @"School Name: %@", model.mthAvg]];
    [self.wrAvg setText: [NSString stringWithFormat: @"School Name: %@", model.wrAvg]];
}

-(void) getSatScores {
    NSString *string = [NSString stringWithFormat:@"https://data.cityofnewyork.us/resource/f9bf-2cp4.json?dbn=%@", self.dbn];
    NSLog(@"%@", string);
    NSString *stringUrl = string;
    NSURL *url = [NSURL URLWithString:stringUrl];
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSArray *scores = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        
        if(err) {
            NSLog(@"Failed to serialize the json %@", err);
            return;
        }
        
        for (NSDictionary *scoreDictionary in scores) {
            SATScore *score = SATScore.new;
            score.schoolName = scoreDictionary[@"school_name"];
            score.numOfTakers = scoreDictionary[@"num_of_sat_test_takers"];
            score.rdAvg = scoreDictionary[@"sat_critical_reading_avg_score"];
            score.mthAvg = scoreDictionary[@"sat_math_avg_score"];
            score.wrAvg = scoreDictionary[@"sat_writing_avg_score"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self configLabels:score];
            });
            
        }
    }] resume];
}
@end
