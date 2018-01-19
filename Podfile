# Uncomment the next line to define a global platform for your project

platform :ios, '8.0'
target 'RNHybird' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!

  # Pods for RNHybird
  pod 'yoga',  :path => './ReactComponent/node_modules/react-native/ReactCommon/yoga'

  pod 'React', :path => './ReactComponent/node_modules/react-native',
  :subspecs => [
      'Core',
      'RCTText',
      'RCTNetwork’,
      'RCTWebSocket',
      'RCTActionSheet',
      'RCTGeolocation',
      'RCTImage',
      'RCTLinkingIOS',
      'RCTSettings',
      'RCTVibration',
      'BatchedBridge',
      'DevSupport',
  ]

  target 'RNHybirdTests' do
    inherit! :search_paths
    # Pods for testing

  end

  target 'RNHybirdUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
