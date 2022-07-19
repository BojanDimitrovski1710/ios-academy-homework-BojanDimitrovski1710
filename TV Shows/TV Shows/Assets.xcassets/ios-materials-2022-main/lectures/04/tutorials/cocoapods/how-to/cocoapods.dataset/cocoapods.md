# Cocoapods

- preferred way of handling dependencies in iOS Academy

## `pod init` & `pod install`
- open **terminal** in the root directory of you project (e.g. you have `.git`, `*.xcodeproj` ...)
    - close Xcode
        - `CMD + Q`
    - you can navigate using
        - `cd` - change directory
        - `pwd` - see where you are currently
        - `ls -al` - list all files and folders in current directory
    - `pod init`
    - `pod install`

## Open xcworkspace
- open `TV Shows.xcworkspace` (not `.xcodeproj` )
- navigate to Pods project
- open Podfile and add 
    - `pod "MBProgressHUD"`
    - `pod "Alamofire"`
- save
- it should look like this (with your target name, not Cocoapods)
    ![alt](cocoapods_pod_open.png)

## `pod install`
- enter `pod install` in terminal
- it should look like this
    ![alt](cocoapods_pod_install.png)

## `open TV Shows.xcworkspace`
- it should look like this
    ![alt](cocoapods_pod_installed.png)
- keep in mind, you need to open `TVShow.xcworkspace`
- do `CMD + B` 
    - to build newly added framework

## `import SVProgressHUD`
- import and start using ;)
- it should look like this
    ![alt](cocoapods_pod_import.png)
