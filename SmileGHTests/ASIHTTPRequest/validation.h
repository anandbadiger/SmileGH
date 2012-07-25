//
//  validation.h
//  ModelApp
//
//  Created by win on 12/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface validation : NSObject


- (BOOL)emailRegEx:(NSString *)string;
- (BOOL)passwordMinLength:(NSInteger *)length password:(NSString *)string;

@end
