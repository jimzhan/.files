/**
 *  ------------------------------------------------------------
 *  @project    ___PROJECTNAME___
 *  @file       ___FILENAME___
 *  @date       ___DATE___
 *  @author     ___FULLUSERNAME___
 *
 *  Copyright © ___YEAR___ ___FULLUSERNAME___.
 *  ------------------------------------------------------------
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *  ------------------------------------------------------------
 */

#import "HTTPSessionManager.h"


static NSString * const kAppBaseURL = @"";


@implementation HTTPSessionManager

+ (instancetype)sharedInstance 
{
    static HTTPSessionManager *instance = nil;
    static dispatch_once_t token;

    dispatch_once(&token, ^{
        instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:kAppBaseURL]];
        instance.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        instance.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        instance.requestSerializer = [AFJSONRequestSerializer new];
        instance.responseSerializer = [AFJSONResponseSerializer new];
        [instance.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    });

    return instance;
}

@end
