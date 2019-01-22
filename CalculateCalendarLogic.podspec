Pod::Spec.new do |s|
  s.name                  = "CalculateCalendarLogic"
  s.version               = "0.2.5"
  s.summary               = "This library CalculateCalendarLogic (sample project name is handMadeCalendarAdvance) can judge a holiday in Japan."
  s.description           = <<-DESC
                          This library 'CalculateCalendarLogic' can judge a holiday in Japan.
                          When you use this library, you can judge can judge a holiday in Japan very easily.
                          A method which named 'judgeJapaneseHoliday' method stores variables year, month, and day in an argument, it returns true or false.
                          DESC
  s.homepage              = "http://qiita.com/fumiyasac@github/items/33bfc07ad36dfffcdf8f"
  s.license               = { :type => "MIT", :file => "LICENSE" }
  s.author                = { "Fumiya Sakai" => "fumiya.def.mathmatica@gmail.com" }
  s.platform              = :ios, '9.0'
  s.source                = { :git => "https://github.com/fumiyasac/handMadeCalendarAdvance.git", :tag => "#{s.version}" }
  s.social_media_url      = "https://twitter.com/fumiyasac"
  s.source_files          = "CalculateCalendarLogic/*.swift"
  s.exclude_files         = "CalculateCalendarLogic/*.plist"
  s.requires_arc          = true
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.10'
end
