# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ImageSearch' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Network
  pod 'Alamofire'
  
  # UI
  pod 'SnapKit'
  pod 'Toast-Swift', '~> 5.0.1'

  # Rx
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxGesture'
  pod 'RxOptional'

  # Etc
  pod 'Then'
  pod 'SwiftLint'

  target 'ImageSearchTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RxBlocking'
    pod 'RxTest'
  end

  target 'ImageSearchUITests' do
    # Pods for testing
    pod 'RxBlocking'
    pod 'RxTest'
  end

end
