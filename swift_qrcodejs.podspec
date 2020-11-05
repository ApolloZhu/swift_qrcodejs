Pod::Spec.new do |s|

  s.name         = "swift_qrcodejs"
  s.module_name  = "QRCodeSwift"
  s.version      = "2.2.2"
  s.summary      = "Cross-appleOS SIMPLE QRCode generator for swift, modified based on qrcodejs."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
    No CIFilter on watchOS? Then we generate QRCode without it ourselves!
    swift_qrcodejs is a cross-appleOS simple QRCode generator for swift, modified based on qrcodejs.
  DESC

  s.homepage     = "https://github.com/ApolloZhu/swift_qrcodejs"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  # s.author             = { "Apollo Zhu" => "public-apollonian@outlook.com" }
  # Or just: s.author    = "ApolloZhu"
  s.authors            = { "ApolloZhu" => "public-apollonian@outlook.com" }
  s.social_media_url   = "http://github.com/ApolloZhu"

  s.ios.deployment_target = "9.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/ApolloZhu/swift_qrcodejs.git", :tag => s.version }

  s.source_files  = "Sources/**/*.{h,swift}"
  s.swift_versions = ['4.2', '5.0']

  s.frameworks = "Foundation"

end
