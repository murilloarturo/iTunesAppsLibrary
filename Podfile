source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
use_frameworks!

target 'iTunesAppsLibrary' do

    pod 'Alamofire', '~> 4.3'
    pod 'AlamofireObjectMapper'
    pod 'AlamofireImage', '~> 3.1'
    pod 'SVProgressHUD'
    pod 'RealmSwift'
    pod "ObjectMapper+Realm"
    pod 'AZDropdownMenu'
    pod 'TTZoomTransition'
    pod 'BRYXBanner'
    pod 'DZNEmptyDataSet'

    #RxSwift
    pod 'RxSwift',    '~> 3.0'
    pod 'RxCocoa',    '~> 3.0'
    pod 'RxBlocking', '~> 3.0'

    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.0'
            end
        end
    end

end
