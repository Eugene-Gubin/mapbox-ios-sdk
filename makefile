XBUILD=/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild
PROJECT_ROOT=.
PROJECT=$(PROJECT_ROOT)/MapView/MapView.xcodeproj
TARGET=MapView
OUT_NAME=MapBox

all: libUniversal.a

libi386.a:
	$(XBUILD) -project $(PROJECT) -target $(TARGET) -sdk iphonesimulator -configuration Release clean build
	-mv $(PROJECT_ROOT)/$(TARGET)/build/Release-iphonesimulator/lib$(OUT_NAME).a $@

libArmv7.a:
	$(XBUILD) -project $(PROJECT) -target $(TARGET) -sdk iphoneos -arch armv7 -configuration Release clean build
	-mv $(PROJECT_ROOT)/$(TARGET)/build/Release-iphoneos/lib$(OUT_NAME).a $@

libArmv7s.a:
	$(XBUILD) -project $(PROJECT) -target $(TARGET) -sdk iphoneos -arch armv7s -configuration Release clean build
	-mv $(PROJECT_ROOT)/$(TARGET)/build/Release-iphoneos/lib$(OUT_NAME).a $@

libArm64.a:
	$(XBUILD) -project $(PROJECT) -target $(TARGET) -sdk iphoneos -arch arm64 -configuration Release clean build
	-mv $(PROJECT_ROOT)/$(TARGET)/build/Release-iphoneos/lib$(OUT_NAME).a $@

libUniversal.a: libi386.a libArmv7.a libArmv7s.a libArm64.a
	lipo -create -output lib$(OUT_NAME)Universal.a $^

clean:
	-rm -f *.a *.dll
	-rm -rf build
