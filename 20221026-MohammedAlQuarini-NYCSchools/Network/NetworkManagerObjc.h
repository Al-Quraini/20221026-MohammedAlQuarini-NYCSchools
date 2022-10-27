//
//  Header.h
//  20221026-MohammedAlQuarini-NYCSchools
//
//  Created by Mohammed Al-Quraini on 10/27/22.
//

#import <Foundation/Foundation.h>
#import "SATScore.h"


@interface NetworkManagerObjc : NSObject

-(void) getSATScores :(NSString *) stringUrl withCompletionHandler:(void (^)(SATScore *score, NSError * err))completionBlock;

@end
