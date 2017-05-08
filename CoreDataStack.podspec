#
#  Be sure to run `pod spec lint CoreDataStack.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name                    = "CoreDataStack"
  s.version                 = "1.0.2"
  s.summary                 = "CoreDataStack"
  s.homepage                = "https://github.com/mr-noone/CoreDataStack"
  s.license                 = { :type => "MIT", :file => "LICENSE" }
  s.author                  = { "Alex Zgurskiy" => "mr.noone@icloud.com" }
  s.platform                = :ios, "8.0"
  s.source                  = { :git => "https://github.com/mr-noone/CoreDataStack.git", :tag => s.version.to_s }
  s.source_files            = "CoreDataStack/*.{h,m}"
  s.public_header_files     = "CoreDataStack/*.h"
  s.frameworks              = "Foundation", "CoreData"
  s.requires_arc            = true

  s.dependency "macros_blocks", "~> 0.0.3"
end
