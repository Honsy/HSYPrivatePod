#
# Be sure to run `pod lib lint HSYPrivatePod.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HSYPrivatePod'
  s.version          = '0.1.0'
  s.summary          = 'A short description of HSYPrivatePod.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/fantastichong/HSYPrivatePod'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'fantastichong' => 'hongshaoy@outlook.com' }
  s.source           = { :git => 'http://192.168.0.53/hsy152115/PrivatePod', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'HSYPrivatePod/Classes/**/*'
  
  s.resource = "HSYPrivatePod/HSYPrivatePod.bundle"

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'MapKit','Foundation'
  s.dependency 'AFNetworking', '~> 3.2.1'
  s.dependency 'MBProgressHUD', '~> 1.0.0'
end
