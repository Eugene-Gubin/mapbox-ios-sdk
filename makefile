XBUILD=/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild
PROJECT_ROOT=.
PROJECT=$(PROJECT_ROOT)/MapView/MapView.xcodeproj
TARGET=MapView
OUT_NAME=MapBox
CFG=Debug

all: libUniversal.a

libi386.a:
	$(XBUILD) -project $(PROJECT) -target $(TARGET) -sdk iphonesimulator -arch i386 -configuration $(CFG) clean build
	-mv $(PROJECT_ROOT)/$(TARGET)/build/$(CFG)-iphonesimulator/lib$(OUT_NAME).a $@

libix86_64.a:
	$(XBUILD) -project $(PROJECT) -target $(TARGET) -sdk iphonesimulator -arch x86_64 -configuration $(CFG) clean build
	-mv $(PROJECT_ROOT)/$(TARGET)/build/$(CFG)-iphonesimulator/lib$(OUT_NAME).a $@

libArmv7.a:
	$(XBUILD) -project $(PROJECT) -target $(TARGET) -sdk iphoneos -arch armv7 -configuration $(CFG) clean build
	-mv $(PROJECT_ROOT)/$(TARGET)/build/$(CFG)-iphoneos/lib$(OUT_NAME).a $@

libArmv7s.a:
	$(XBUILD) -project $(PROJECT) -target $(TARGET) -sdk iphoneos -arch armv7s -configuration $(CFG) clean build
	-mv $(PROJECT_ROOT)/$(TARGET)/build/$(CFG)-iphoneos/lib$(OUT_NAME).a $@

libArm64.a:
	$(XBUILD) -project $(PROJECT) -target $(TARGET) -sdk iphoneos -arch arm64 -configuration $(CFG) clean build
	-mv $(PROJECT_ROOT)/$(TARGET)/build/$(CFG)-iphoneos/lib$(OUT_NAME).a $@

libUniversal.a: libi386.a libix86_64.a libArmv7.a libArmv7s.a libArm64.a
	lipo -create -output lib$(OUT_NAME)Universal.a $^

clean:
	-rm -f *.a *.dll
	-rm -rf build
