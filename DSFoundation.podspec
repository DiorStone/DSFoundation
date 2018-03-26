Pod::Spec.new do |s|
  s.name             = 'DSFoundation'
  s.version          = '0.1.0'
  s.summary          = '常用基础代码.'
  s.description      = <<-DESC
  常用基础代码,持续更新中.
                       DESC

  s.homepage         = 'https://github.com/DiorStone/DSFoundation'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mrdaios' => 'mrdaios@gmail.com' }
  s.source           = { :git => 'https://github.com/DiorStone/DSFoundation.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '8.0'
  s.source_files = 'Sources/**/*{h,swift}'
end
