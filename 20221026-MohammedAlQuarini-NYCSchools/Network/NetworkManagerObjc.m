//
//  NetworkManagerObjc.m
//  20221026-MohammedAlQuarini-NYCSchools
//
//  Created by Mohammed Al-Quraini on 10/27/22.
//

#import "NetworkManagerObjc.h"

@implementation NetworkManagerObjc

-(void) getSATScores:(NSString *)stringUrl withCompletionHandler:(void (^)(SATScore *, NSError *))completionBlock {
    
    // create tthee url
    NSURL *url = [NSURL URLWithString:stringUrl];
    // Create the url session and give the session a task
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        // serialize the json data
        NSArray *scores = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        
        // if the serialization failed, we invoke completion and return the method
        if(err) {
            NSLog(@"Failed to serialize the json %@", err);
            completionBlock(nil,err);
            return;
        }
        // create an instance from the model SATScore
        SATScore *score = SATScore.new;
        
        // We map the serialized data to our model
        for (NSDictionary *scoreDictionary in scores) {
            score.schoolName = scoreDictionary[@"school_name"];
            score.numOfTakers = scoreDictionary[@"num_of_sat_test_takers"];
            score.rdAvg = scoreDictionary[@"sat_critical_reading_avg_score"];
            score.mthAvg = scoreDictionary[@"sat_math_avg_score"];
            score.wrAvg = scoreDictionary[@"sat_writing_avg_score"];
        }
        // we pass the model to completion
        completionBlock(score,nil);
    }] resume];
}

@end
