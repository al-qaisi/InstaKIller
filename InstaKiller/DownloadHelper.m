//
//  DownloadHelper.m
//  InstaKiller
//
//  Created by user on 13.04.2020.
//  Copyright © 2020 temp. All rights reserved.
//

#import "DownloadHelper.h"


@implementation DownloadHelper

@synthesize url = _url;
@synthesize data = _data;
@synthesize connection = _connection;
@synthesize delegate = _delegate;

- (void)connection: (NSURLConnection*) connection didReceiveData: (NSData*) data {
    [self.data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.delegate didCompleteDownloadForURL:self.url withData:self.data];
}

- (void) cancelConnection {
    if(self.connection) {
        [self.connection cancel];
        [self setConnection:nil];
    }
}

-(void) dealloc {
    [self cancelConnection];
}
@end
