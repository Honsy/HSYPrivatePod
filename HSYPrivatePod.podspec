
Pod::Spec.new do |s|
  s.name             = 'HSYPrivatePod'
  s.version          = '1.0'
  s.summary          = 'A short description of HSYPrivatePod.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/fantastichong/HSYPrivatePod'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'fantastichong' => 'hongshaoy@outlook.com' }
  s.source           = { :git => 'https://github.com/Honsy/HSYPrivatePod.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.ios.deployment_target = '8.0'
  s.source_files = 'HSYPrivatePod/Classes/**/*'
  # s.resource = "HSYPrivatePod/HSYPrivatePod.bundle"
	
  s.resources = ['HSYPrivatePod/Assets/*.{png,jpg,xib,plist,jpeg}']
  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'MapKit','Foundation','AFNetworking', 'MBProgressHUD','FMDB','Masonry'
  s.dependency 'AFNetworking','3.2.1'
  s.dependency 'MBProgressHUD','1.0.0'
  s.dependency 'FMDB', '2.7.2'
  s.dependency 'Masonry', '1.1.0'
end
