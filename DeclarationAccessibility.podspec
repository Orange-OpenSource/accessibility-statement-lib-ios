Pod::Spec.new do |spec|

  spec.name         = "DeclarationAccessibility"
  spec.version      = "1.0.0"
  spec.summary      = "DeclarationAccessibility by Orange"
  spec.description  = "This is a the va11ydette framework by Orange "
  spec.homepage     = "https://gitlab.tech.orange/tayeb.sedraia/accessibility_ios_accessibility_statement"
  spec.license      = "Orange"
  spec.author             = { "SEDRAIA Tayeb" => "tayeb.sedraia@orange.com" }
  spec.platform     = :ios
  spec.source       = { :git => "https://gitlab.tech.orange/tayeb.sedraia/accessibility_ios_accessibility_statement.git", :tag => "#{spec.version}" }
  spec.source_files  = "DeclarationAccessibility/**/*", "Classes/**/*"
spec.exclude_files = "DeclarationAccessibility/**/*.plist"
spec.resource_bundle = { "DeclarationAccessibility" => ["DeclarationAccessibility/**/*.strings"] }

end
