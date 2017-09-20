#
# Be sure to run `pod lib lint multiSlideMenu.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'multiSlideMenu'
  s.version          = '0.1.0'
  s.summary          = 'Slide menus toggled by pan gesture appearing from 4 directions, Top, Left. Bottom and Right.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
The open source library was for the developers who mind creating the apps with side menus which are toggled by a gesture. You can customize each side menu by specifying position and size depends on the design. Each side menus are traceable in position. When the gesture state is changed, each of override functions is called so that you can detect which side menu was dragging and where it is.
                       DESC

  s.homepage         = 'https://github.com/WataruMaeda/multiSlideMenu'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'WataruMaeda' => 'wm19850716@gmail.com' }
  s.source           = { :git => 'https://github.com/WataruMaeda/multiSlideMenu.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'multiSlideMenu/Classes/**/*'
  
  # s.resource_bundles = {
  #   'multiSlideMenu' => ['multiSlideMenu/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
