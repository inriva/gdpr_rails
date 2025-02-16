module PolicyManager
  class Engine < ::Rails::Engine
    isolate_namespace PolicyManager
    config.autoload_paths << File.expand_path("lib/generators", __dir__)
    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.assets false
      g.helper false
    end

    if config.respond_to?(:assets)
      config.assets.precompile += %w( policy_manager/application.css policy_manager/application.js )
    end
  end
end
