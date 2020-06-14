#import "Aestea.h"

BOOL enabled;

%group Aestea

%hook CCUIRoundButton

- (void)didMoveToWindow {

	%orig;

	if (enabled) {
		ancestor = [self _viewControllerForAncestor];
		NSDictionary* preferencesDictionary = [NSDictionary dictionaryWithContentsOfFile: @"/var/mobile/Library/Preferences/sh.litten.aesteapreferences.plist"];
		if (colorOnStateSwitch) {
			colorAirplaneString = [preferencesDictionary objectForKey: @"airplaneColor"];
			colorAirplane = [SparkColourPickerUtils colourWithString: colorAirplaneString withFallback: @"#147efb"];
			colorCellularString = [preferencesDictionary objectForKey: @"cellularColor"];
			colorCellular = [SparkColourPickerUtils colourWithString: colorCellularString withFallback: @"#147efb"];
			colorWifiString = [preferencesDictionary objectForKey: @"wifiColor"];
			colorWifi = [SparkColourPickerUtils colourWithString: colorWifiString withFallback: @"#147efb"];
			colorBluetoothString = [preferencesDictionary objectForKey: @"bluetoothColor"];
			colorBluetooth = [SparkColourPickerUtils colourWithString: colorBluetoothString withFallback: @"#147efb"];
			colorAirdropString = [preferencesDictionary objectForKey: @"airdropColor"];
			colorAirDrop = [SparkColourPickerUtils colourWithString: colorAirdropString withFallback: @"#147efb"];
			colorHoptspotString = [preferencesDictionary objectForKey: @"hotspotColor"];
			colorHotspot = [SparkColourPickerUtils colourWithString: colorHoptspotString withFallback: @"#147efb"];	
		}

		if (colorOffStateSwitch) {
			offColorAirplaneString = [preferencesDictionary objectForKey: @"offAirplaneColor"];
			offColorAirplane = [SparkColourPickerUtils colourWithString: offColorAirplaneString withFallback: @"#147efb"];
			offColorCellularString = [preferencesDictionary objectForKey: @"offCellularColor"];
			offColorCellular = [SparkColourPickerUtils colourWithString: offColorCellularString withFallback: @"#147efb"];
			offColorWifiString = [preferencesDictionary objectForKey: @"offWifiColor"];
			offColorWifi = [SparkColourPickerUtils colourWithString: offColorWifiString withFallback: @"#147efb"];
			offColorBluetoothString = [preferencesDictionary objectForKey: @"offBluetoothColor"];
			offColorBluetooth = [SparkColourPickerUtils colourWithString: offColorBluetoothString withFallback: @"#147efb"];
			offColorAirdropString = [preferencesDictionary objectForKey: @"offAirdropColor"];
			offColorAirDrop = [SparkColourPickerUtils colourWithString: offColorAirdropString withFallback: @"#147efb"];
			offColorHoptspotString = [preferencesDictionary objectForKey: @"offHotspotColor"];
			offColorHotspot = [SparkColourPickerUtils colourWithString: offColorHoptspotString withFallback: @"#147efb"];
		}

		if ([ancestor isKindOfClass: %c(CCUIConnectivityAirplaneViewController)]) {
			if (colorOnStateSwitch) {
				[[self selectedStateBackgroundView] setBackgroundColor:colorAirplane];
			}
			if (colorOffStateSwitch) {
				[[self normalStateBackgroundView] setBackgroundColor:offColorAirplane];
			}
		}

		if ([ancestor isKindOfClass: %c(CCUIConnectivityCellularDataViewController)]) {
			if (colorOnStateSwitch) {
				[[self selectedStateBackgroundView] setBackgroundColor:colorCellular];
			}
			if (colorOffStateSwitch) {
				[[self normalStateBackgroundView] setBackgroundColor:offColorCellular];
			}
		}

		if ([ancestor isKindOfClass: %c(CCUIConnectivityWifiViewController)]) {
			if (colorOnStateSwitch) {
				[[self selectedStateBackgroundView] setBackgroundColor:colorWifi];
			}
			if (colorOffStateSwitch) {
				[[self normalStateBackgroundView] setBackgroundColor:offColorWifi];
			}
		}

		if ([ancestor isKindOfClass: %c(CCUIConnectivityBluetoothViewController)]) {
			if (colorOnStateSwitch) {
				[[self selectedStateBackgroundView] setBackgroundColor:colorBluetooth];
			}
			if (colorOffStateSwitch) {
				[[self normalStateBackgroundView] setBackgroundColor:offColorBluetooth];
			}
		}

		if ([ancestor isKindOfClass: %c(CCUIConnectivityAirDropViewController)]) {
			if (colorOnStateSwitch) {
				[[self selectedStateBackgroundView] setBackgroundColor:colorAirDrop];
			}
			if (colorOffStateSwitch) {
				[[self normalStateBackgroundView] setBackgroundColor:offColorAirDrop];
			}
		}

		if ([ancestor isKindOfClass: %c(CCUIConnectivityHotspotViewController)]) {
			if (colorOnStateSwitch) {
				[[self selectedStateBackgroundView] setBackgroundColor:colorHotspot];
			}
			if (colorOffStateSwitch) {
				[[self normalStateBackgroundView] setBackgroundColor:offColorHotspot];
			}
		}
	}

}

%end

%end

%group AesteaIntegrityFail

%hook SBIconController

- (void)viewDidAppear:(BOOL)animated {

    %orig;

    if (!dpkgInvalid) return;
		UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Aestea"
		message:@"Seriously? Pirating a free Tweak is awful!\nPiracy repo's Tweaks could contain Malware if you didn't know that, so go ahead and get Aestea from the official Source https://repo.litten.love/.\nIf you're seeing this but you got it from the official source then make sure to add https://repo.litten.love to Cydia or Sileo."
		preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Okey" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {

			UIApplication *application = [UIApplication sharedApplication];
			[application openURL:[NSURL URLWithString:@"https://repo.litten.love/"] options:@{} completionHandler:nil];

	}];

		[alertController addAction:cancelAction];

		[self presentViewController:alertController animated:YES completion:nil];

}

%end

%end

%ctor {
  
    dpkgInvalid = ![[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/sh.litten.aestea.list"];

    if (!dpkgInvalid) dpkgInvalid = ![[NSFileManager defaultManager] fileExistsAtPath:@"/var/lib/dpkg/info/sh.litten.aestea.md5sums"];

    if (dpkgInvalid) {
        %init(AesteaIntegrityFail);
        return;
    }

	pfs = [[HBPreferences alloc] initWithIdentifier:@"sh.litten.aesteapreferences"];

    [pfs registerBool:&enabled default:YES forKey:@"Enabled"];

	[pfs registerBool:&colorOnStateSwitch default:YES forKey:@"colorOnState"];
	[pfs registerBool:&colorOffStateSwitch default:NO forKey:@"colorOffState"];

	// Toggle On Color
	[pfs registerObject:&airplaneColorValue default:@"147efb" forKey:@"airplaneColor"];
	[pfs registerObject:&cellularColorValue default:@"147efb" forKey:@"cellularColor"];
	[pfs registerObject:&wifiColorValue default:@"147efb" forKey:@"wifiColor"];
	[pfs registerObject:&bluetoothColorValue default:@"147efb" forKey:@"bluetoothColor"];
	[pfs registerObject:&airdropColorValue default:@"147efb" forKey:@"airdropColor"];
	[pfs registerObject:&hotspotColorValue default:@"147efb" forKey:@"hotspotColor"];

	// Toggle Off Color
	[pfs registerObject:&airplaneOffColorValue default:@"147efb" forKey:@"offAirplaneColor"];
	[pfs registerObject:&cellularOffColorValue default:@"147efb" forKey:@"offCellularColor"];
	[pfs registerObject:&wifiOffColorValue default:@"147efb" forKey:@"offWifiColor"];
	[pfs registerObject:&bluetoothOffColorValue default:@"147efb" forKey:@"offBluetoothColor"];
	[pfs registerObject:&airdropOffColorValue default:@"147efb" forKey:@"offAirdropColor"];
	[pfs registerObject:&hotspotOffColorValue default:@"147efb" forKey:@"offHotspotColor"];

	if (!dpkgInvalid && enabled) {
        BOOL ok = false;
        
        ok = ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/var/lib/dpkg/info/%@%@%@%@%@%@%@%@%@.aestea.md5sums", @"s", @"h", @".", @"l", @"i", @"t", @"t", @"e", @"n"]]
        );

        if (ok && [@"litten" isEqualToString:@"litten"]) {
            %init(Aestea);
            return;
        } else {
            dpkgInvalid = YES;
        }
    }
}