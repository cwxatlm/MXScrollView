Pod::Spec.new do |s|  
  s.name             = "MXScrollView"  
  s.version          = "1.0.0"  
  s.summary          = "The use of a simple with the effects of the rolling cycle view"
  s.description      = <<-DESC  
                       It is a loopScrollView used on iOS, which implement by Objective-C.  
                       DESC  
  s.homepage         = "https://github.com/cwxatlm/MXScrollView"  
  # s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"  
  s.license          = 'Apache License 2.0'  
  s.author           = { "陈文轩" => "cwx079@126.com" }  
  s.source           = { :git => "ttps://github.com/cwxatlm/MXScrollView.git", :tag => s.version.to_s }  
  # s.social_media_url = 'https://twitter.com/NAME'  
  
  s.platform     = :ios, '4.3'  
  # s.ios.deployment_target = '5.0'  
  # s.osx.deployment_target = '10.7'  
  s.requires_arc = true  
  
  s.source_files = 'MXScrollView/*'  
  # s.resources = 'Assets'  
  
  # s.ios.exclude_files = 'Classes/osx'  
  # s.osx.exclude_files = 'Classes/ios'  
  # s.public_header_files = 'Classes/**/*.h'  
  s.frameworks = 'Foundation', 'UIKit'  
  
end  
