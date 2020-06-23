# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

install! 'cocoapods', :disable_input_output_paths => true
inhibit_all_warnings!


target 'ZLSudokuExercise' do
  # Repo 依赖， 1.7 之后可以用CDN地址：
  source 'https://cdn.cocoapods.org/'

  #OC
  pod 'SnapKit'
  pod 'NVActivityIndicatorView'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 9.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
      end
    end
  end
end
