workspace "Workspace"

platform :ios, '10.0'


target 'Pillow' do
  project 'Pillow/Pillow.xcodeproj'
  use_frameworks!
	pod 'CouchbaseLiteSwift', :git => 'https://github.com/couchbase/couchbase-lite-ios.git', :tag => '2.0DB021', :submodules => true
  target 'PillowTests' do
    inherit! :search_paths
    # Pods for testing
  end
end

target 'PillowExampleApp' do
  project 'PillowExampleApp/PillowExampleApp.xcodeproj'
  use_frameworks!
        pod 'CouchbaseLiteSwift', :git => 'https://github.com/couchbase/couchbase-lite-ios.git', :tag => '2.0DB021', :submodules => true
end
