//
//  MySingleton.h
//  RatingbyPolitics
//
//  Created by CooLX on 21/04/14.
//  Copyright (c) 2014 CooLX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MySingleton : NSObject

@property  NSIndexPath *index;
@property  NSArray *photo;

+(MySingleton *)sharedMySingleton;


@end
