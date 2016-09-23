//
//  MWPhoto.h
//  MWPhotoBrowser
//
//  Created by Michael Waterfall on 17/10/2010.
//  Copyright 2010 d3i. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "MWPhotoProtocol.h"

// This class models a photo/image and it's caption
// If you want to handle photos, caching, decompression
// yourself then you can simply ensure your custom data model
// conforms to MWPhotoProtocol
@interface MWPhoto : NSObject <MWPhoto>

@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic) BOOL emptyImage;
@property (nonatomic) BOOL isVideo;

+ (MWPhoto *)photoWithImage:(UIImage *)image;
+ (MWPhoto *)photoWithURL:(NSURL *)url;
+ (MWPhoto *)photoWithAsset:(PHAsset *)asset targetSize:(CGSize)targetSize;
+ (MWPhoto *)videoWithURL:(NSURL *)url; // Initialise video with no poster image

- (id)init;
- (id)initWithImage:(UIImage *)image;
- (id)initWithURL:(NSURL *)url;
- (id)initWithAsset:(PHAsset *)asset targetSize:(CGSize)targetSize;
- (id)initWithVideoURL:(NSURL *)url;




//扩充。
#pragma mark-public medata
@property(nonatomic,strong)NSString *hide;
@property(nonatomic,strong)NSString*gentype;
@property(nonatomic,strong)NSString *modifyDate;
@property(nonatomic,strong)NSString *CreateDate;
@property(nonatomic,strong)NSNumber *size;
@property(nonatomic,strong)NSString*imageName;
@property(nonatomic,strong)NSString* lastName;
@property(nonatomic,strong)NSString *firstName;

#pragma photo
@property (nonatomic, strong) NSURL *thumbnailURL;
@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, strong) NSDate *date;
@property(nonatomic,strong)NSString *desc;
//@property NSUInteger *index;
@property(nonatomic,strong) NSIndexPath *indexpath;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *mediaNM;
@property(nonatomic,strong)NSString *selfDefine;
@property(nonatomic,strong)NSString *photoPath;

@property Boolean isSelected;
- (id)initWithThumbnailURL:(NSURL *)thumbnailURL date:(NSDate *)date;
+ (MWPhoto *)photoWithURLString:(NSString *)urlString date:(NSDate *)date;
+ (MWPhoto *)photoWithURL:(NSURL *)url date:(NSDate *)date;

// Init
- (id)initWithFilePath:(NSString *)path;




-(void)setPhotoPath:(NSString*)path;
-(void)setPhotoUrl:(NSURL*)url;

@end

