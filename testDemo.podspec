
Pod::Spec.new do |s|

  s.name         = "testDemo"
  s.version      = "0.0.1"
  s.summary      = "a testDemo"
  s.description  = "a testDemo"

  s.homepage     = "https://github.com/EJParadise/TestDemo"



  s.license      = "MIT"


  s.author             = { "LiDandan" => "lidandan@cubehealth.com" }

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/EJParadise/TestDemo", :tag => "0.0.1" }

  s.source_files  = "runtime/other/**/*.{h,m}"

   s.requires_arc = true

end
