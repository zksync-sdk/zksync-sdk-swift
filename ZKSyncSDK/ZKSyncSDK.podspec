Pod::Spec.new do |spec|

  spec.name         = "ZKSyncSDK"
  spec.version      = "0.0.2"
  spec.summary      = "Cryptographical primitives used in zkSync network."

  spec.description  = <<-DESC
  zkSync is a scaling and privacy engine for Ethereum. Its current functionality scope includes low gas transfers of ETH and ERC20 tokens in the Ethereum network
                   DESC

  spec.homepage     = "https://github.com/zksync-sdk/zksync-sdk-swift"
  spec.license      = "MIT"

  spec.author             = { "The Matter Labs team" => "hello@matterlabs.dev" }

  # spec.platform     = :ios
  spec.platform     = :ios, "10.0"

  #  When using multiple platforms
  spec.ios.deployment_target = "10.0"
  spec.swift_version = '5.0'
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"


  spec.source       = { :git => "https://github.com/zksync-sdk/zksync-sdk-swift.git", :tag => "#{spec.version}" }

  spec.source_files  = "ZKSyncSDK/ZKSyncSDK/**/*.{swift,h}"
  spec.preserve_paths = 'ZKSyncSDK/ZKSyncSDK/*.{modulemap}'
  spec.vendored_libraries = "ZKSyncSDK/ZKSyncSDK/libzks/*.{a}"
  spec.module_map = "ZKSyncSDK/ZKSyncSDK/ZKSyncSDK.modulemap"

  # spec.xcconfig = { :VALID_ARCHS => 'arm64 arm64e armv7 armv7s x86_64' }
  spec.pod_target_xcconfig = { :VALID_ARCHS => 'arm64 arm64e armv7 armv7s x86_64' }
  # spec.user_target_xcconfig = { :VALID_ARCHS => 'arm64 arm64e armv7 armv7s x86_64' }

end
