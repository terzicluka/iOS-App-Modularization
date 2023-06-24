Pod::Spec.new do |spec|
  spec.name         = "TVShowsCore"
  spec.version      = "0.0.1"
  spec.summary      = "TVShowsCore module contains all the code that is reused by components and screens"
  spec.homepage     = "https://github.com/terzicluka/iOS-App-Modularization"
  spec.source       = { :git => "https://github.com/terzicluka/iOS-App-Modularization", :tag => "#{spec.version}" }
  spec.license      = "MIT"
  spec.authors      = { "Luka Terzić" => "luka.terzic@infinum.com" }
  spec.platform     = :ios, "16.0"

  spec.subspec 'Resources' do |resources|
    resources.source_files =
                             "TVShows/Common/Extensions/UIImageExtension.swift"
  end

  spec.subspec 'Utils' do |utils|
    utils.dependency "RxSwift"
    utils.dependency "RxCocoa"
    utils.dependency "Alamofire"
    utils.dependency "Kingfisher"

    utils.source_files =
                          # UI
                          "TVShows/Common/Extensions/UIImageViewExtension.swift",
                          "TVShows/Common/Extensions/UIButtonExtension.swift",
                          "TVShows/Common/Extensions/UIScrollView+BottomDetection.swift",
                          "TVShows/Common/Extensions/UITextViewExtension.swift",
                          "TVShows/Common/Extensions/UIViewExtension.swift",
                          "TVShows/Common/Extensions/Refreshable.swift",
                          "TVShows/Common/Progressable/**/*.swift",
                          "TVShows/Common/TableView/**/*.swift",
                          "TVShows/Common/VIPER/UIStoryboardExtension.swift",
                          # Foundation
                          "TVShows/Common/Extensions/Result+Map.swift",
                          "TVShows/Common/Extensions/String+Blank.swift",
                          # Rx
                          "TVShows/Common/Extensions/Driver+Utility.swift",
                          "TVShows/Common/Extensions/Observable+Utility.swift",
                          "TVShows/Common/Extensions/Result+Rx.swift",
                          # Paging
                          "TVShows/Common/Paging/**/*.swift"
  end

  spec.subspec 'Data' do |data|
    data.dependency "TVShowsCore/Utils"

    data.source_files =
                      "TVShows/Common/Model/APIError.swift",
                      "TVShows/Common/Model/AuthInfo.swift",
                      "TVShows/Common/Model/ValidationError.swift",
                      "TVShows/Common/Networking/**/*.swift",
                      "TVShows/Common/Validation/**/*.swift",
                      "TVShows/Application/Constants.swift"
  end

  spec.subspec 'VIPER' do |viper|
    viper.dependency "RxSwift"
    viper.dependency "RxCocoa"
    viper.dependency "MBProgressHUD"

    viper.source_files =
                      "TVShows/Common/VIPER/**/*.swift"
                             
    viper.exclude_files =
                      "TVShows/Common/VIPER/UIStoryboardExtension.swift" # Already included in Utils                     
  end

  spec.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'TVShowsTests/Extensions/**/*'
  end

end
