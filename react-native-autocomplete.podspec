Pod::Spec.new do |s|
  s.name             = "react-native-autocomplete"
  s.version          = "0.1.1"
  s.summary          = "React Native Component for MLPAutoCompleteTextField"
  s.requires_arc = true
  s.author       = { 'Nicolas Ulrich' => 'github@ulrich.co' }
  s.license      = 'MIT'
  s.homepage     = 'https://github.com/nulrich/RCTAutoComplete'
  s.source       = { :git => "https://github.com/nulrich/RCTAutoComplete.git" }
  s.platform     = :ios, "7.0"
  s.dependency 'React'

  s.subspec 'MLPAutoCompleteTextField' do |ss|
    ss.source_files     = "MLPAutoCompleteTextField/*.{h,m}"
  end

  s.subspec 'RCTAutoComplete' do |ss|
    ss.dependency         'react-native-autocomplete/MLPAutoCompleteTextField'
    ss.source_files     = "*.{h,m}"
    ss.preserve_paths   = "*.js"
  end
end
