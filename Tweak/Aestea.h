#import <UIKit/UIKit.h>
#import <Cephei/HBPreferences.h>
#import "SparkColourPickerUtils.h"

// Utils
HBPreferences* pfs;

// Thanks to Nepeta for the DRM
BOOL dpkgInvalid = NO;

// Option Switches
BOOL enabled = YES;

BOOL colorOnStateSwitch = YES;
BOOL colorOffStateSwitch = NO;

UIViewController* ancestor;

NSString* colorAirplaneString;
UIColor* colorAirplane;
NSString* colorCellularString;
UIColor* colorCellular;
NSString* colorWifiString;
UIColor* colorWifi;
NSString* colorBluetoothString;
UIColor* colorBluetooth;
NSString* colorAirdropString;
UIColor* colorAirDrop;
NSString* colorHoptspotString;
UIColor* colorHotspot;

NSString* offColorAirplaneString;
UIColor* offColorAirplane;
NSString* offColorCellularString;
UIColor* offColorCellular;
NSString* offColorWifiString;
UIColor* offColorWifi;
NSString* offColorBluetoothString;
UIColor* offColorBluetooth;
NSString* offColorAirdropString;
UIColor* offColorAirDrop;
NSString* offColorHoptspotString;
UIColor* offColorHotspot;

// Storing The ColorPicker Values
NSString* airplaneColorValue = @"#147efb";
NSString* cellularColorValue = @"#147efb";
NSString* wifiColorValue = @"#147efb";
NSString* bluetoothColorValue = @"#147efb";
NSString* airdropColorValue = @"#147efb";
NSString* hotspotColorValue = @"#147efb";

NSString* airplaneOffColorValue = @"#147efb";
NSString* cellularOffColorValue = @"#147efb";
NSString* wifiOffColorValue = @"#147efb";
NSString* bluetoothOffColorValue = @"#147efb";
NSString* airdropOffColorValue = @"#147efb";
NSString* hotspotOffColorValue = @"#147efb";

// Interfaces
@interface CCUIRoundButton : UIControl
@property (nonatomic,retain)UIView* normalStateBackgroundView; 
@property(nonatomic, retain)UIView* selectedStateBackgroundView;
- (id)_viewControllerForAncestor;
@end

@interface SBIconController : UIViewController
- (void)viewDidAppear:(BOOL)animated;
@end