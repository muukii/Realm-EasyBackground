#
# Be sure to run `pod lib lint Realm-EasyBackground.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Realm-EasyBackground"
  s.version          = "0.5.0"
  s.summary          = "Extensions for Realm"

  s.description      = <<-DESC
                       Extensions for Realm (To write in background thread easily.)
                       DESC

  s.homepage         = "https://github.com/muukii/Realm-EasyBackground"
  s.license          = 'MIT'
  s.author           = { "muukii" => "m@muukii.me" }
  s.source           = { :git => "https://github.com/muukii/Realm-EasyBackground.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/muukii0803'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'Realm-EasyBackground' => ['Pod/Assets/*.png']
  }
  s.dependency 'RealmSwift', '~> 1.0'
end
