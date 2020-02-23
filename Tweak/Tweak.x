
// Aestea is part of my Tweak Development Guide for beginners https://litten.sh/OwO/tweakDevelopmentForBeginners.pdf and was created with explanations for each line in the code

#import "Aestea.h"

%group Aestea

%hook CCUIRoundButton

- (void)layoutSubviews {

	%orig;

	if (enabled) {
		ancestor = [self _viewControllerForAncestor];
		
		NSDictionary* preferencesDictionary = [NSDictionary dictionaryWithContentsOfFile: @"/var/mobile/Library/Preferences/sh.litten.aesteapreferences.plist"];

		if ([ancestor isKindOfClass: %c(CCUIConnectivityAirplaneViewController)]) {
			NSString* colorString = [preferencesDictionary objectForKey: @"airplaneColor"];
			UIColor* color = [SparkColourPickerUtils colourWithString: colorString withFallback: @"#147efb"];

			self.selectedStateBackgroundView.backgroundColor = color;

		}

		if ([ancestor isKindOfClass: %c(CCUIConnectivityCellularDataViewController)]) {
			NSString* colorString = [preferencesDictionary objectForKey: @"cellularColor"];
			UIColor* color = [SparkColourPickerUtils colourWithString: colorString withFallback: @"#147efb"];

			self.selectedStateBackgroundView.backgroundColor = color;

		}

		if ([ancestor isKindOfClass: %c(CCUIConnectivityWifiViewController)]) {
			NSString* colorString = [preferencesDictionary objectForKey: @"wifiColor"];
			UIColor* color = [SparkColourPickerUtils colourWithString: colorString withFallback: @"#147efb"];

			self.selectedStateBackgroundView.backgroundColor = color;

		}

		if ([ancestor isKindOfClass: %c(CCUIConnectivityBluetoothViewController)]) {
			NSString* colorString = [preferencesDictionary objectForKey: @"bluetoothColor"];
			UIColor* color = [SparkColourPickerUtils colourWithString: colorString withFallback: @"#147efb"];

			self.selectedStateBackgroundView.backgroundColor = color;

		}

		if ([ancestor isKindOfClass: %c(CCUIConnectivityAirDropViewController)]) {
			NSString* colorString = [preferencesDictionary objectForKey: @"airdropColor"];
			UIColor* color = [SparkColourPickerUtils colourWithString: colorString withFallback: @"#147efb"];

			self.selectedStateBackgroundView.backgroundColor = color;

		}

		if ([ancestor isKindOfClass: %c(CCUIConnectivityHotspotViewController)]) {
			NSString* colorString = [preferencesDictionary objectForKey: @"hotspotColor"];
			UIColor* color = [SparkColourPickerUtils colourWithString: colorString withFallback: @"#147efb"];

			self.selectedStateBackgroundView.backgroundColor = color;

		}

	}

}

%end

%end

%ctor {

    if (![NSProcessInfo processInfo]) return;
    NSString *processName = [NSProcessInfo processInfo].processName;
    bool isSpringboard = [@"SpringBoard" isEqualToString:processName];

    // Someone smarter than Nepeta invented this.
    // https://www.reddit.com/r/jailbreak/comments/4yz5v5/questionremote_messages_not_enabling/d6rlh88/
    bool shouldLoad = NO;
    NSArray *args = [[NSClassFromString(@"NSProcessInfo") processInfo] arguments];
    NSUInteger count = args.count;
    if (count != 0) {
        NSString *executablePath = args[0];
        if (executablePath) {
            NSString *processName = [executablePath lastPathComponent];
            BOOL isApplication = [executablePath rangeOfString:@"/Application/"].location != NSNotFound || [executablePath rangeOfString:@"/Applications/"].location != NSNotFound;
            BOOL isFileProvider = [[processName lowercaseString] rangeOfString:@"fileprovider"].location != NSNotFound;
            BOOL skip = [processName isEqualToString:@"AdSheet"]
                        || [processName isEqualToString:@"CoreAuthUI"]
                        || [processName isEqualToString:@"InCallService"]
                        || [processName isEqualToString:@"MessagesNotificationViewService"]
                        || [executablePath rangeOfString:@".appex/"].location != NSNotFound;
            if ((!isFileProvider && isApplication && !skip) || isSpringboard) {
                shouldLoad = YES;
            }
        }
    }

    if (!shouldLoad) return;


	pfs = [[HBPreferences alloc] initWithIdentifier:@"sh.litten.aesteapreferences"];

    [pfs registerBool:&enabled default:YES forKey:@"Enabled"];

	[pfs registerObject:&airplaneColorValue default:@"147efb" forKey:@"airplaneColor"];
	[pfs registerObject:&cellularColorValue default:@"147efb" forKey:@"cellularColor"];
	[pfs registerObject:&wifiColorValue default:@"147efb" forKey:@"wifiColor"];
	[pfs registerObject:&bluetoothColorValue default:@"147efb" forKey:@"bluetoothColor"];
	[pfs registerObject:&airdropColorValue default:@"147efb" forKey:@"airdropColor"];
	[pfs registerObject:&hotspotColorValue default:@"147efb" forKey:@"hotspotColor"];

	if (enabled) {
		%init(Aestea);

	}

}