//
//  WWPrivacyHelper.m
//
//  Created by Tidus on 2017/5/5.
//  Copyright © 2017年 ExEdu. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AdSupport/ASIdentifierManager.h>

#import "WWPrivacyHelper.h"
#import "UIAlertView+BlocksKit.h"


@implementation WWPrivacyHelper

/**
 *  需要用外部传入的locationManager来请求权限
 */
+ (WWPrivacyLocationPermission)checkLocationPermission:(CLLocationManager *)locationManager
{
    if(![CLLocationManager locationServicesEnabled]) {
        return WWPrivacyLocationPermissionNO;
    }
    
    switch ([CLLocationManager authorizationStatus]) {
        //NO
        case kCLAuthorizationStatusRestricted: {
            
        }
        case kCLAuthorizationStatusDenied: {
            return WWPrivacyLocationPermissionNO;
        }
        //NotDetermined
        case kCLAuthorizationStatusNotDetermined: {
            if(IOS_VERSION >= 8.f) {
                if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]) {
                    [locationManager requestAlwaysAuthorization];
                } else if ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                    [locationManager  requestWhenInUseAuthorization];
                } else {
                    #ifdef DEBUG
                        NSAssert(NO, @"[ERROR] require keys NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
                    #endif
                }
            }
            return WWPrivacyLocationPermissionND;
        }
        //YES
        case kCLAuthorizationStatusAuthorizedAlways: {
            
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse: {
            return WWPrivacyLocationPermissionYES;
        }
        default:
            break;
    }
    
    return WWPrivacyLocationPermissionNO;
}

+ (BOOL)checkCameraPermission
{
    if (IOS_VERSION < 7.f) {
        return YES;
    }
    
    BOOL isCameraAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    if (!isCameraAvailable) {
        [UIAlertView bk_showAlertViewWithTitle:@"该设备没有相机" message:nil cancelButtonTitle:@"好" otherButtonTitles:nil handler:nil];
        return NO;
    }
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusAuthorized) {
        return YES;
    }
    else if (authStatus == AVAuthorizationStatusDenied) {
        [UIAlertView bk_showAlertViewWithTitle:@"需要相机功能" message:[NSString stringWithFormat:@"请进入系统【设置】>【隐私】>【照片】，允许%@使用您的相机。",APP_NAME] cancelButtonTitle:@"确定" otherButtonTitles:nil handler:nil];
        return NO;
    }
    else if (authStatus == AVAuthorizationStatusNotDetermined) {
        NSLog(@"系统还未知是否访问，第一次开启相机时");
    }
    return YES;
}

+ (BOOL)checkAlbumPermission
{
    if ([ALAssetsLibrary authorizationStatus] !=  ALAuthorizationStatusDenied) {
        return YES;
    }else {
        [UIAlertView bk_showAlertViewWithTitle:@"需要相册功能" message:[NSString stringWithFormat:@"请进入系统【设置】>【隐私】>【照片】，允许%@使用您的相册。",APP_NAME] cancelButtonTitle:@"确定" otherButtonTitles:nil handler:nil];
        return NO;
    }
}

+ (BOOL)checkMicrophonePermission
{
    __block BOOL result = YES;
    if ([[AVAudioSession sharedInstance] respondsToSelector:@selector(requestRecordPermission:)]) {
        [[AVAudioSession sharedInstance] performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted) {
                
            }else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIAlertView bk_showAlertViewWithTitle:@"需要麦克风" message:[NSString stringWithFormat:@"请进入系统【设置】>【隐私】>【照片】，允许%@使用您的麦克风。",APP_NAME] cancelButtonTitle:@"确定" otherButtonTitles:nil handler:nil];
                    result = NO;
                });
            }
        }];
    }
    return result;
}
@end
