#
#  Be sure to run `pod spec lint CoreDataStack.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name                    = "CoreDataStack"
  s.version                 = "1.0"
  s.summary                 = "CoreDataStack"
  s.homepage                = "https://github.com/mr-noone/CoreDataStack"
  s.license                 = { :type => "MIT", :file => "LICENSE" }
  s.author                  = { "Alex Zgurskiy" => "mr.noone@icloud.com" }
  s.platform                = :ios, "8.0"
  s.source                  = { :git => "https://github.com/mr-noone/CoreDataStack.git", :tag => "1.0" }
  s.source_files            = "Classes/*.{h,m}"
  s.exclude_files           = "Classes/*.{h}"
  s.public_header_files     = "Classes/*.h"
  s.frameworks              = "Foundation", "CoreData"
  s.requires_arc            = true

  s.dependency "macros_blocks", "~> 0.0.3"
end