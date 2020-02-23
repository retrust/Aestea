#import <UIKit/UIKit.h>
#import <Cephei/HBPreferences.h>
#import "SparkColourPickerUtils.h"

// Utils
HBPreferences* pfs;

// Option Switches
BOOL enabled = YES;

UIViewController* ancestor;

// Storing The ColorPicker Values
NSString* airplaneColorValue = @"#147efb";
NSString* cellularColorValue = @"#147efb";
NSString* wifiColorValue = @"#147efb";
NSString* bluetoothColorValue = @"#147efb";
NSString* airdropColorValue = @"#147efb";
NSString* hotspotColorValue = @"#147efb";

// Interfaces
@interface CCUIRoundButton : UIControl
@property(nonatomic, retain)UIView* selectedStateBackgroundView;
- (id)_viewControllerForAncestor;
@end