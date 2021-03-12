//
//  ModelAuthBusiness.m
//
//  Created by 林栋 隋 on 2021/1/20
//  Copyright (c) 2021 __MyCompanyName__. All rights reserved.
//

#import "ModelAuthBusiness.h"


NSString *const kModelAuthBusinessQualificationUrl = @"qcUrl";
NSString *const kModelAuthBusinessQualificationNumber = @"qcNumber";
NSString *const kModelAuthBusinessQcEndDate = @"qcEndDate";
NSString *const kModelAuthBusinessRoadUrl = @"rtpUrl";
NSString *const kModelAuthBusinessReviewTime = @"reviewTime";
NSString *const kModelAuthBusinessRtpEndDate = @"rtpEndDate";
NSString *const kModelAuthBusinessReviewerName = @"reviewerName";
NSString *const kModelAuthBusinessReason = @"reason";
NSString *const kModelAuthBusinessReviewerId = @"reviewerId";
NSString *const kModelAuthBusinessSubmitterName = @"submitterName";
NSString *const kModelAuthBusinessSubmitTime = @"submitTime";
NSString *const kModelAuthBusinessSubmitterId = @"submitterId";
NSString *const kModelAuthBusinessRoadNumber = @"rtpNumber";
NSString *const kModelAuthBusinessReviewStatus = @"reviewStatus";


@interface ModelAuthBusiness ()
@property (nonatomic, strong) NSString * reviewerName;
@property (nonatomic, strong) NSString * reason;

@end

@implementation ModelAuthBusiness

@synthesize qualificationUrl = _qualificationUrl;
@synthesize qualificationNumber = _qualificationNumber;
@synthesize qcEndDate = _qcEndDate;
@synthesize roadUrl = _roadUrl;
@synthesize reviewTime = _reviewTime;
@synthesize rtpEndDate = _rtpEndDate;
@synthesize reviewerName = _reviewerName;
@synthesize reason = _reason;
@synthesize reviewerId = _reviewerId;
@synthesize submitterName = _submitterName;
@synthesize submitTime = _submitTime;
@synthesize submitterId = _submitterId;
@synthesize roadNumber = _roadNumber;
@synthesize reviewStatus = _reviewStatus;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.qualificationUrl = [dict stringValueForKey:kModelAuthBusinessQualificationUrl];
            self.qualificationNumber = [dict stringValueForKey:kModelAuthBusinessQualificationNumber];
            self.qcEndDate = [dict doubleValueForKey:kModelAuthBusinessQcEndDate];
            self.roadUrl = [dict stringValueForKey:kModelAuthBusinessRoadUrl];
            self.reviewTime = [dict doubleValueForKey:kModelAuthBusinessReviewTime];
            self.rtpEndDate = [dict doubleValueForKey:kModelAuthBusinessRtpEndDate];
            self.reviewerName = [dict stringValueForKey:kModelAuthBusinessReviewerName];
            self.reason = [dict stringValueForKey:kModelAuthBusinessReason];
            self.reviewerId = [dict doubleValueForKey:kModelAuthBusinessReviewerId];
            self.submitterName = [dict stringValueForKey:kModelAuthBusinessSubmitterName];
            self.submitTime = [dict doubleValueForKey:kModelAuthBusinessSubmitTime];
            self.submitterId = [dict doubleValueForKey:kModelAuthBusinessSubmitterId];
            self.roadNumber = [dict stringValueForKey:kModelAuthBusinessRoadNumber];
            self.reviewStatus = [dict doubleValueForKey:kModelAuthBusinessReviewStatus];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.qualificationUrl forKey:kModelAuthBusinessQualificationUrl];
    [mutableDict setValue:self.qualificationNumber forKey:kModelAuthBusinessQualificationNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.qcEndDate] forKey:kModelAuthBusinessQcEndDate];
    [mutableDict setValue:self.roadUrl forKey:kModelAuthBusinessRoadUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.reviewTime] forKey:kModelAuthBusinessReviewTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.rtpEndDate] forKey:kModelAuthBusinessRtpEndDate];
    [mutableDict setValue:self.reviewerName forKey:kModelAuthBusinessReviewerName];
    [mutableDict setValue:self.reason forKey:kModelAuthBusinessReason];
    [mutableDict setValue:[NSNumber numberWithDouble:self.reviewerId] forKey:kModelAuthBusinessReviewerId];
    [mutableDict setValue:self.submitterName forKey:kModelAuthBusinessSubmitterName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.submitTime] forKey:kModelAuthBusinessSubmitTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.submitterId] forKey:kModelAuthBusinessSubmitterId];
    [mutableDict setValue:self.roadNumber forKey:kModelAuthBusinessRoadNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.reviewStatus] forKey:kModelAuthBusinessReviewStatus];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
