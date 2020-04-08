//
//  RemoteFile.h
//  InstaKiller
//
//  Created by user on 31.03.2020.
//  Copyright © 2020 temp. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

/**
 * Class name: ImageCache
 * Description: caches downloaded images to reuse it.
 */
@interface ImageCache: NSObject

/**
 * Property name: cache
 * Description: dictionary url - UIImage.
 */
@property (nonatomic, strong) NSMutableDictionary *cache;

-(UIImage *) cachedImageForURL: (NSString *)url;
-(void) storeCachedImage: (UIImage *)image forURL:(NSString *)url;

@end

@implementation ImageCache

@synthesize cache = _cache;

/**
 * Method name: init
 * Description: overrides super init to subscribe to notofication center if lack of memory occures
 * Parameters: none
 */
-(id) init
{
    self = [super init];
    if(self) {
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(clearCache)
         name: UIApplicationDidReceiveMemoryWarningNotification
         object:nil];
    }
    
    return self;
}

/**
 * Method name: dealloc
 * Description: unsubscribe from notification center from notofication center
 * Parameters: none
 */
- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
    name:UIApplicationDidReceiveMemoryWarningNotification
                                                  object: nil];
}

/**
 * Method name: cache
 * Description: returns singletone cache
 * Parameters: none
 */
- (NSMutableDictionary *) cache
{
    NSLog(@"ds");
    if(_cache == nil) {
        _cache = [NSMutableDictionary dictionary];
    }
    return _cache;
}

- (void) clearCache
{
    [self.cache removeAllObjects];
}

- (void) storeCachedImage:(UIImage *)image forURL:(NSString *)url
{
    self.cache[url] = image;
}

- (UIImage *) cachedImageForURL:(NSString *) url;
{
    return self.cache[url];
}

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

@end

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

/**
 * Class name: UIImageView(RemoteFileHidden)
 * Description: private extenstion of UIImageView to add url and downloadhelper properties and accessor methods for them
 */
@interface UIImageView(RemoteFileHidden) <DownloadHelperDelegate>

@property (nonatomic, strong, setter = setUrl:) NSString* url;
@property (nonatomic, strong, setter = setDownloadHelper:) DownloadHelper* downloadHelper;

@end

@implementation UIImageView(RemoteFileHidden)

/**
 * Property name: url, downloadHelper
 * Description: cannot synthesize properties of UIImageView extention. so using runtime library
 */
@dynamic url;
@dynamic downloadHelper;

/**
* Var name: kImageUrlObjectKey
* Description: cannot synthesize properties of UIImageView extention. so using runtime library
*/
static char kImageUrlObjectKey;
static char kImageDownloadHelperObjectKey;

+ (ImageCache *) imageCache {
    static ImageCache *_imageCache;
    
    if(_imageCache == nil) {
        _imageCache = [[ImageCache alloc] init];
    }
    
    return _imageCache;
}

- (NSString *)url {
    return (NSString *)objc_getAssociatedObject(self, &kImageUrlObjectKey);
}

- (void) setUrl:(NSString *)url {
    objc_setAssociatedObject(self, &kImageUrlObjectKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DownloadHelper *)downloadHelper {
    DownloadHelper *helper = (DownloadHelper *)objc_getAssociatedObject(self, &kImageDownloadHelperObjectKey);
    if (helper == nil) {//lazy loading of the helper class
        helper = [[DownloadHelper alloc] init];
        //when the helper finishes downloading the remote image data it will call it’s
        helper.delegate = self;
        self.downloadHelper = helper;
        
    }
    
        return helper;
}

- (void)setDownloadHelper:(DownloadHelper *)downloadHelper {
    objc_setAssociatedObject(self, &kImageDownloadHelperObjectKey, downloadHelper,
OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void) dealloc {
    if (self.url != nil) [self.downloadHelper cancelConnection];
}

#pragma mark DownloadHelperDelegate
/**
* Method name: namedidCompleteDownloadForURL
* Description: fires when URLConnection finishes downloading and sets image using imageCache
* Parameters: url, data
*/
- (void)didCompleteDownloadForURL:(NSString *)url withData:(NSMutableData *)data {
    //handles the downloaded image data, turns it into an image instance and saves then it
    UIImage *image = [UIImage imageWithData:data];
    if (image == nil) {//something didn't work out - data may be corrupted or a bad url
        return;
    }
    //cache the image
    ImageCache *imageCache = [UIImageView imageCache];
    [imageCache storeCachedImage:image forURL:url];
    //update the placeholder image display of this UIImageView
    self.image = image;
}

@end

/**
* Class name: UIImageView(RemoteFile)
* Description: public extenstion of UIImageView
*/
@interface UIImageView (RemoteFile)

/**
 * Method name: namesetImageWithRemoteFileURL
 * Description: sets image of Cell with url and placeholder image: tries to get image from ImageCache, initializes downloadHelper and fires connection
 * Parameters: urlString, placeholderImage
 */
- (void)setImageWithRemoteFileURL:(NSString *) urlString placeholderImage: (UIImage *)placeholderImage;
@end

@implementation UIImageView (RemoteFile)

- (void)setImageWithRemoteFileURL:(NSString *) urlString placeholderImage: (UIImage *)placeholderImage {
    NSLog(@"inUIImageView first method");
    if (self.url != nil && [self.url isEqualToString:urlString]) { //if the url matches the existing url then ignore it
        return;
    }
        
    [self.downloadHelper cancelConnection];
    self.url = urlString;
    //get a reference to the image cache singleton
    ImageCache *imageCache = [UIImageView imageCache];
    UIImage *image = [imageCache cachedImageForURL:urlString]; //check it we've already got a cached version of the image
    if (image) {
        self.image = image;
        return;
    }
    
    //no cached version so start downloading the remote file
    self.image = placeholderImage;
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    self.downloadHelper.url = urlString;
    //set the download helper as the delegate of the data download updates
    
    self.downloadHelper.connection = (NSURLConnection *)[[NSURLConnection alloc] initWithRequest:request delegate:self.downloadHelper startImmediately:YES];
    if (self.downloadHelper.connection) {
    //create an empty mutable data container to add the data bytes to
    self.downloadHelper.data = [NSMutableData data];
    }
}
@end

