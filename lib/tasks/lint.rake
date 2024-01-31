# frozen_string_literal: true

namespace :lint do
  desc 'Run slim lint'
  task slim: :environment do
    sh 'bundle exec slim-lint app/views'
  end

  desc 'Run rubocop'
  task rubocop: :environment do
    sh './bin/rubocop'
  end

  desc 'Run all'
  task all: %i[slim rubocop]
end
