//
//  SATScore.h
//  20221026-MohammedAlQuarini-NYCSchools
//
//  Created by Mohammed Al-Quraini on 10/26/22.
//

#import <Foundation/Foundation.h>

@interface SATScore : NSObject

@property (strong, nonatomic) NSString *dbn;
@property (strong, nonatomic) NSString *schoolName;
@property (strong, nonatomic) NSString *numOfTakers;
@property (strong, nonatomic) NSString *rdAvg;
@property (strong, nonatomic) NSString *mthAvg;
@property (strong, nonatomic) NSString *wrAvg;

@end
