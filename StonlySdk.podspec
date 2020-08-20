Pod::Spec.new do |s|  
    s.name              = 'StonlySdk'
    s.version           = '1.0.0'
    s.summary        = 'Stonly library'
    s.homepage      = 'https://github.com/StonlyHQ/StonlySdk'

    s.author            = { 'Stonly' => 'developers@stonly.com' }
    s.license           = { :type => 'MIT', :file => 'LICENSE' }

    s.platform          = :ios
    s.source            = { :git => 'https://github.com/StonlyHQ/StonlySdk', :tag => '1.0.0' }   

    s.swift_version     = '5.0' 
    s.ios.deployment_target = '11.0'
    s.ios.vendored_frameworks = 'StonlySdk.framework'

    s.dependency 'FloatingPanel', '1.7.4'
end