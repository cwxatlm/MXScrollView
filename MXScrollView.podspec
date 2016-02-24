Pod::Spec.new do |s|  
  s.name         = 'MXScrollView'
  s.version      = '1.0.0'
  s.summary      = 'The use of a simple with the effects of the rolling cycle view'
  s.homepage     = 'https://github.com/cwxatlm/MXScrollView'
  s.license      = 'MIT'
  s.authors      = {'wx chen' => '524200634@qq.com'}
  s.platform     = :ios, '6.0'
  s.source       = {:git => 'https://github.com/cwxatlm/MXScrollView.git', :tag => s.version}
  s.source_files = 'MXScrollView/**/*.{h,m}'
  s.resource     = 'MXScrollView/resource'
  s.requires_arc = true
end  
