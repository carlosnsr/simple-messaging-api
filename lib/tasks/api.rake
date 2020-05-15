namespace :api do
  namespace :doc do
    desc 'Generate API documentation morkdown'

    OUTPUT_DIR = 'public/api/docs/v1'.freeze
    MD_OUTPUT = "#{OUTPUT_DIR}/apispec.md".freeze
    HTML_OUTPUT = "#{OUTPUT_DIR}/index.html".freeze

    task :md do
      require 'rspec/core/rake_task'

      RSpec::Core::RakeTask.new(:api_spec) do |t|
        t.pattern = 'spec/requests/api/v1'
        t.rspec_opts = "-f Dox::Formatter --order defined --tag dox --out #{MD_OUTPUT} --require rails_helper"
      end

      Rake::Task['api_spec'].invoke
    end

    task html: :md do
      `yarn run aglio -i #{MD_OUTPUT} -o #{HTML_OUTPUT}`
    end

    task open: :html do
      `open #{HTML_OUTPUT}`
    end
  end
end
