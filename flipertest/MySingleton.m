//
//  MySingleton.m
//  RatingbyPolitics
//
//  Created by CooLX on 21/04/14.
//  Copyright (c) 2014 CooLX. All rights reserved.
//

#import "MySingleton.h"

@implementation MySingleton


static MySingleton * sharedMySingleton = NULL;
+(MySingleton *)sharedMySingleton {
    if (!sharedMySingleton || sharedMySingleton == NULL) {
		sharedMySingleton = [MySingleton new];
	}
	return sharedMySingleton;
}




@end
