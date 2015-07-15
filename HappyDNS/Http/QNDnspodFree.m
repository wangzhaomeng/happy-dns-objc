//
//  QNDnspodFree.m
//  HappyDNS
//
//  Created by bailong on 15/6/23.
//  Copyright (c) 2015年 Qiniu Cloud Storage. All rights reserved.
//

#import "QNDnspodFree.h"
#import "QNDomain.h"
#import "QNRecord.h"

@implementation QNDnspodFree
- (NSArray *)query:(QNDomain *)domain networkInfo:(QNNetworkInfo *)netInfo error:(NSError *__autoreleasing *)error {
	NSString *url = [@"http://119.29.29.29/d?ttl=1&dn=" stringByAppendingString:domain.domain];
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
	NSHTTPURLResponse *response = nil;
	NSError *httpError = nil;
	NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
	                returningResponse:&response
	                error:&httpError];

	if (httpError != nil) {
		if (error != nil) {
			*error = httpError;
		}
		return nil;
	}
	if (response.statusCode != 200) {
		return nil;
	}
	NSString *raw = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSArray *ip1 = [raw componentsSeparatedByString:@","];
	if (ip1.count != 2) {
		return nil;
	}
	NSString *ttlStr = [ip1 objectAtIndex:1];
	int ttl = [ttlStr intValue];
	if (ttl <= 0) {
		return nil;
	}
	NSString *ips = [ip1 objectAtIndex:0];
	NSArray *ipArray = [ips componentsSeparatedByString:@";"];
	NSMutableArray *ret = [[NSMutableArray alloc] initWithCapacity:ipArray.count];
	for (int i = 0; i < ipArray.count; i++) {
		QNRecord *record = [[QNRecord alloc]init:[ipArray objectAtIndex:i] ttl:ttl type:0];
		[ret addObject:record];
	}
	return ret;
}

@end
