#
# Be sure to run `pod lib lint objchttp.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'objchttp'
  s.version          = '0.1.3'
  s.summary          = 'A library made fully in objective c to make http calls.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  With objchttp you can make http calls, get their responses by completion handlers and use that response to make your app connect to the internet in a fast and easy way.
                       DESC

  s.homepage         = 'https://github.com/PhoenixPassenger/objchttp'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '32482081' => 'Rodrigo.ato@hotmail.com' }
  s.source           = { :git => 'https://github.com/PhoenixPassenger/objchttp.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'objchttp/Classes/**/*'
  
  # s.resource_bundles = {
  #   'objchttp' => ['objchttp/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
