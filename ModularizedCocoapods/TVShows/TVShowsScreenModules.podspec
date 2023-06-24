Pod::Spec.new do |spec|
  spec.name         = "TVShowsScreenModules"
  spec.version      = "0.0.1"
  spec.summary      = "TVShowsScreenModules contains all screens"
  spec.homepage     = "https://github.com/terzicluka/iOS-App-Modularization"
  spec.source       = { :git => "https://github.com/terzicluka/iOS-App-Modularization", :tag => "#{spec.version}" }
  spec.license      = "MIT"
  spec.authors      = { "Luka Terzić"   => "luka.terzic@infinum.com" }
  spec.platform     = :ios, "16.0"

  spec.subspec 'Common' do |common|
    common.dependency "TVShowsCore"
  end

  spec.subspec 'Login' do |login|
    login.dependency "TVShowsScreenModules/Common"
    login.source_files =
                                "TVShows/Modules/Login/**/*.swift",
                                "TVShows/Common/Model/User.swift",
                                "TVShows/Common/Model/MetaData.swift"
    login.resources =
                                "TVShows/Modules/Login/**/*.{xib,storyboard}"
  end

  spec.subspec 'Home' do |home|
    home.dependency "TVShowsScreenModules/Common"
    home.source_files =
                                "TVShows/Modules/Home/**/*.swift",
                                "TVShows/Common/Model/Show.swift"
    home.resources =
                                "TVShows/Modules/Home/**/*.{xib,storyboard}"
  end

  spec.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'TVShowsTests/Modules/**/*'
  end

end
