#!/bin/bash

set -x
set -e
set -o

cd ZKSyncCrypto

file ZKSyncCrypto/libzks/libzkscrypto.a

rm -rf ZKSyncCrypto.xcarchive

xcodebuild clean archive \
            ARCHS=x86_64 ONLY_ACTIVE_ARCH=NO \
            -configuration Release \
            -sdk iphonesimulator \
            -project ZKSyncCrypto.xcodeproj \
            -scheme ZKSyncCrypto \
            -archivePath ZKSyncCrypto.xcarchive \
            SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

rm -rf x86_64 
mkdir x86_64

cp -r ZKSyncCrypto.xcarchive/Products/Library/Frameworks/ZKSyncCrypto.framework x86_64/ZKSyncCrypto.framework
file x86_64/ZKSyncCrypto.framework/ZKSyncCrypto

rm -rf ZKSyncCrypto.xcarchive

xcodebuild clean archive \
            ARCHS=arm64 ONLY_ACTIVE_ARCH=NO \
            -configuration Release \
            -sdk iphoneos \
            -project ZKSyncCrypto.xcodeproj \
            -scheme ZKSyncCrypto \
            -archivePath ZKSyncCrypto.xcarchive \
            SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

rm -rf amr64 
mkdir amr64

cp -r ZKSyncCrypto.xcarchive/Products/Library/Frameworks/ZKSyncCrypto.framework amr64/ZKSyncCrypto.framework
file amr64/ZKSyncCrypto.framework/ZKSyncCrypto

rm -rf ZKSyncCrypto.xcframework

xcodebuild -create-xcframework \
            -framework x86_64/ZKSyncCrypto.framework \
            -framework amr64/ZKSyncCrypto.framework \
            -output ZKSyncCrypto.xcframework

file ZKSyncCrypto.xcframework

DEPENDENCIES_FOLDER="../Dependencies"

rm -rf ${DEPENDENCIES_FOLDER}
mkdir ${DEPENDENCIES_FOLDER}
cp -r ZKSyncCrypto.xcframework ${DEPENDENCIES_FOLDER}

rm -rf x86_64
rm -rf amr64
rm -rf ZKSyncCrypto.xcarchive
rm -rf ZKSyncCrypto.xcframework

# Workaround, which allows to fix build-related issue, which happens when xcframework 
# name is similar to class name, which resides in this xcframework. More information can be found here:
# https://developer.apple.com/forums/thread/123253
cd ${DEPENDENCIES_FOLDER}/ZKSyncCrypto.xcframework
find . -name "*.swiftinterface" -exec sed -i -e 's/ZKSyncCrypto\.//g' {} \;
