//
//  NetworkManagerObjc.m
//  20221026-MohammedAlQuarini-NYCSchools
//
//  Created by Mohammed Al-Quraini on 10/27/22.
//

#import "NetworkManagerObjc.h"

@implementation NetworkManagerObjc

-(void) getSATScores:(NSString *)stringUrl withCompletionHandler:(void (^)(SATScore *, NSError *))completionBlock {
    
    NSURL *url = [NSURL URLWithString:stringUrl];
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSArray *scores = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        
        if(err) {
            NSLog(@"Failed to serialize the json %@", err);
            completionBlock(nil,err);
            return;
        }
        SATScore *score = SATScore.new;
        for (NSDictionary *scoreDictionary in scores) {
            score.schoolName = scoreDictionary[@"school_name"];
            score.numOfTakers = scoreDictionary[@"num_of_sat_test_takers"];
            score.rdAvg = scoreDictionary[@"sat_critical_reading_avg_score"];
            score.mthAvg = scoreDictionary[@"sat_math_avg_score"];
            score.wrAvg = scoreDictionary[@"sat_writing_avg_score"];
        }
        completionBlock(score,nil);
    }] resume];
}

@end
