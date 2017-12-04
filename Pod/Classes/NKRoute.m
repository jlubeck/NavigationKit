//
//  NKRoute.m
//  Pods
//
//  Created by Axel Möller on 11/12/14.
//  Copyright (c) 2014 Sendus Sverige AB. All rights reserved.
//

#import "NKRoute.h"
#import "NKRouteStep.h"

@implementation NKRoute

- (id)initWithMKRoute:(MKRoute *)route {
    self = [super init];
    
    if(self && route) {
        
        for(MKRouteStep *routeStep in [route steps]) {
            
            NSInteger stepPoints = routeStep.polyline.pointCount;
            CLLocationCoordinate2D *coordinates = malloc(stepPoints * sizeof(CLLocationCoordinate2D));
            [routeStep.polyline getCoordinates:coordinates range:NSMakeRange(0, stepPoints)];
            
            for(int i = 0; i < stepPoints; i++) {
                //[path addCoordinate:coordinates[i]];
            }
        }
        
        // Save polyline
        self.polyline = [route polyline];
        
        // Convert array of MKRouteStep's to NKRouteStep's
        NSMutableArray *routeSteps = [[NSMutableArray alloc] init];
        
        for(MKRouteStep *step in [route steps]) {
            NKRouteStep *routeStep = [[NKRouteStep alloc] initWithMKRouteStep:step];
            [routeSteps addObject:routeStep];
        }
        
        self.steps = routeSteps;
        
        // Save expectedTravelTime
        self.expectedTravelTime = [route expectedTravelTime];
    }
    
    return self;
}

@end
