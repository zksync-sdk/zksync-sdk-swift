Pod::Spec.new do |spec|

  spec.name         = "ZKSyncSDK"
  spec.version      = "0.0.1"
  spec.summary      = "Cryptographical primitives used in zkSync network."

  spec.description  = <<-DESC
  Cryptographical primitives used in zkSync network.
                   DESC

  spec.homepage     = "https://github.com/matter-labs/zksync-sdk"
  spec.license      = "MIT"

  spec.author             = { "The Matter Labs team" => "hello@matterlabs.dev" }

  # spec.platform     = :ios
  # spec.platform     = :ios, "5.0"

  #  When using multiple platforms
  # spec.ios.deployment_target = "5.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"


  spec.source       = { :git => "https://github.com/matter-labs/zksync-sdk.git", :tag => "#{spec.version}" }

  spec.source_files  = "ZKSyncSDK/**/*.{swift,h}"
  spec.module_map = 'ZKSyncSDK/ZKSyncSDK.modulemap'
  spec.vendored_libraries = 'ZKSyncSDK/libzks/libzks_crypto.a'

end
