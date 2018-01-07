//
//  WWPrivacyHelper.h
//
//  Created by Tidus on 2017/5/5.
//  Copyright © 2017年 ExEdu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef NS_ENUM(NSUInteger, WWPrivacyLocationPermission)
{
    WWPrivacyLocationPermissionNO = 0,
    WWPrivacyLocationPermissionYES = 1,
    WWPrivacyLocationPermissionND = 2   //kCLAuthorizationStatusNotDetermined
};

/**
 *  请求用户权限
 */
@interface WWPrivacyHelper : NSObject

+ (WWPrivacyLocationPermission)checkLocationPermission:(CLLocationManager *)locationManager;

+ (BOOL)checkCameraPermission;

+ (BOOL)checkAlbumPermission;

+ (BOOL)checkMicrophonePermission;

@end
