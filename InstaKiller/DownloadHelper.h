//
//  DownloadHelper.h
//  InstaKiller
//
//  Created by user on 13.04.2020.
//  Copyright © 2020 temp. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 * Protocol name: DownloadHelperDelegate
 * Description: delegate for downloadhelper messages
 */
@protocol DownloadHelperDelegateCommon <NSObject>

- (void)didCompleteDownloadForURL: (NSArray *)data;

@end

/**
 * Protocol name: DownloadHelperDelegate
 * Description: delegate for downloadhelper messages
 */
@protocol DownloadHelperDelegate <NSObject>

- (void)didCompleteDownloadForURL:(NSString *)url withData:(NSMutableData *)data;

@end

/**
 * Class name: DownloadHelper
 * Description: instance of this class is delegate of NSURLConnection. fires UIImageVIew method when image downloaded
 */
@interface DownloadHelper : NSObject

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, assign) id<DownloadHelperDelegate> delegate;

- (void) cancelConnection;

@end
