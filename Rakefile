# frozen_string_literal: true

require 'base64'
require 'httparty'
require 'rake'
require 'cucumber/rake/task'

namespace :test do
  desc 'Execute multiples tests.'
  task :multiples, [:platform, :feature, :num_devices] do |_task, args|
    @num_devices = args[:num_devices].to_i
    Cucumber::Rake::Task.new(:run) do |t|
      t.cucumber_opts = "-p #{args[:platform]} #{args[:feature]} --retry 1"
    end
    (0..@num_devices - 1).each do |i|
      ENV['TASK_ID'] = i.to_s
      Rake::Task[:run].execute
    end
  end
end

desc 'Upload all test results in reports folder to Allure server.'
task :allure_upload_test_results do
  response = post_test_results_to_allure_server
  p "Allure report post status code => #{response.code}"
  p "Allure post message => #{response['meta_data']}" if response.code == 200
end

def load_report_files
  report_files = Dir['reports/allure/*json']
  report_files.delete_if { |file_name| file_name.include? 'categories.json' }
end

def load_screenshots
  Dir['report/screenshots/*.png']
end

def prepare_body
  body = { 'results' => [] }
  files = load_report_files + load_screenshots

  files.each do |file_path|
    data = File.read(file_path)
    file_name = file_path.split('/').last
    hash = { file_name: file_name, content_base64: Base64.encode64(data) }
    body['result'] << hash
  end

  body
end

def post_test_results_to_allure_server
  body = prepare_body
  AllureServer.new.send_results(body)
end

# Report implementation
class AllureServer
  include HTTParty
  base_uri '#'
  headers 'Content-Type' => 'application/json', 'Accept' => '*/*'

  def send_results(body)
    self.class.post('/send-results', body: body.to_json)
  end
end
