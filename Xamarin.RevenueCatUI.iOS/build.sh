#!/bin/bash

IOS_SDK_VERSION="17.4"
SWIFT_PROJECT_NAME="RevenueCatUI"
SWIFT_PROJECT_PATH="ios/$SWIFT_PROJECT_NAME.xcodeproj"
SWIFT_BUILD_PATH="Output"

xcodebuild -sdk iphoneos$IOS_SDK_VERSION  -project "$SWIFT_PROJECT_PATH" -scheme $SWIFT_PROJECT_NAME -configuration Release -derivedDataPath Output/Output-iphoneos SKIP_INSTALL=NO ENABLE_BITCODE=NO SWIFT_INSTALL_OBJC_HEADER=YES
xcodebuild -sdk iphonesimulator$IOS_SDK_VERSION  -project "$SWIFT_PROJECT_PATH" -scheme $SWIFT_PROJECT_NAME -configuration Release -derivedDataPath Output/Output-iphonesimulator SKIP_INSTALL=NO ENABLE_BITCODE=NO SWIFT_INSTALL_OBJC_HEADER=YES EXCLUDED_ARCHS="arm64"

cp -R "$SWIFT_BUILD_PATH/Output-iphoneos/Build/Products/Release-iphoneos/" "$SWIFT_BUILD_PATH/Release-fat"
cp -R "$SWIFT_BUILD_PATH/Output-iphonesimulator/Build/Products/Release-iphonesimulator/$SWIFT_PROJECT_NAME.framework/Modules/RevenueCat.swiftmodule/" "$SWIFT_BUILD_PATH/Release-fat/$SWIFT_PROJECT_NAME.framework/Modules/RevenueCat.swiftmodule/"

#
##xcodebuild -create-xcframework -framework Output/Output-iphonesimulator.xcarchive/Products/Library/Frameworks/$SWIFT_PROJECT_NAME.framework -framework Output/Output-iphoneos.xcarchive/Products/Library/Frameworks/$SWIFT_PROJECT_NAME.framework -output Output/$SWIFT_PROJECT_NAME.xcframework
lipo -create -output $SWIFT_BUILD_PATH/Release-fat/$SWIFT_PROJECT_NAME.framework/$SWIFT_PROJECT_NAME $SWIFT_BUILD_PATH/Output-iphonesimulator/Build/Products/Release-iphonesimulator/$SWIFT_PROJECT_NAME.framework/$SWIFT_PROJECT_NAME $SWIFT_BUILD_PATH/Output-iphoneos/Build/Products/Release-iphoneos/$SWIFT_PROJECT_NAME.framework//$SWIFT_PROJECT_NAME
