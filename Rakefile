require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task :default => :test

namespace :plantae do                                                                                    desc 'Release a new version'
  task :release do
    version_file = './lib/plantae/version.rb'
    File.open(version_file, 'w') do |file|
      file.puts <<~EOVERSION
        # frozen_string_literal: true

        module Plantae
          VERSION = '#{Plantae::VERSION.split('.').map(&:to_i).tap { |parts| parts[2] += 1 }.join('.')}'
        end
      EOVERSION
    end
    module Plantae
      remove_const :VERSION
    end
    load version_file
    puts "Updated version to #{Plantae::VERSION}"

    `git commit lib/plantae/version.rb -m "Version #{Plantae::VERSION}"`
    `git push`
    `git tag #{Plantae::VERSION}`
    `git push --tags`
  end
end

