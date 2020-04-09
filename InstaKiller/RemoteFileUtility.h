////
////  RemoteFileUtility.h
////  InstaKiller
////
////  Created by user on 09.04.2020.
////  Copyright © 2020 temp. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>
//#import <objc/runtime.h>
//
///**
// * Class name: ImageCache
// * Description: caches downloaded images to reuse it.
// */
//@interface ImageCache: NSObject
//
///**
// * Property name: cache
// * Description: dictionary url - UIImage.
// */
//@property (nonatomic, strong) NSMutableDictionary *cache;
//
//-(UIImage *) cachedImageForURL: (NSString *)url;
//-(void) storeCachedImage: (UIImage *)image forURL:(NSString *)url;
//
//@end
//
///**
// * Protocol name: DownloadHelperDelegate
// * Description: delegate for downloadhelper messages
// */
//@protocol DownloadHelperDelegate <NSObject>
//
//- (void)didCompleteDownloadForURL:(NSString *)url withData:(NSMutableData *)data;
//
//@end
//
///**
// * Class name: DownloadHelper
// * Description: instance of this class is delegate of NSURLConnection. fires UIImageVIew method when image downloaded
// */
//@interface DownloadHelper : NSObject
//
//@property (nonatomic, strong) NSString *url;
//@property (nonatomic, strong) NSMutableData *data;
//@property (nonatomic, strong) NSURLConnection *connection;
//@property (nonatomic, assign) id<DownloadHelperDelegate> delegate;
//
//@end
//
///**
//* Class name: UIImageView(RemoteFile)
//* Description: public extenstion of UIImageView
//*/
//@interface UIImageView (RemoteFile)
//
///**
// * Method name: namesetImageWithRemoteFileURL
// * Description: sets image of Cell with url and placeholder image: tries to get image from ImageCache, initializes downloadHelper and fires connection
// * Parameters: urlString, placeholderImage
// */
//- (void)setImageWithRemoteFileURL:(NSString *) urlString placeholderImage: (UIImage *)placeholderImage;
//@end
//
///**
// * Class name: UIImageView(RemoteFileHidden)
// * Description: private extenstion of UIImageView to add url and downloadhelper properties and accessor methods for them
// */
//@interface UIImageView(RemoteFileHidden) <DownloadHelperDelegate>
//
//@property (nonatomic, strong, setter = setUrl:) NSString* url;
//@property (nonatomic, strong, setter = setDownloadHelper:) DownloadHelper* downloadHelper;
//
//@end
//
