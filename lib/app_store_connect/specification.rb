# frozen_string_literal: true

require 'net/http'
require 'app_store_connect/specification/component/schema'

module AppStoreConnect
  class Specification
    def initialize(hash)
      @hash = hash
    end

    def find(version, type)
      @hash['paths'].find do |path, _declaration|
        path == "/#{version}/#{type}"
      end&.[](-1)
    end

    def component_schema(ref)
      Component::Schema.new(traverse(ref))
    end

    def traverse(ref)
      _, *parts = ref.split('/')

      @hash.dig(*parts)
    end

    def create_request_schema_ref(version, type)
      declarations = find(version, type)
      declarations['post']['requestBody']['content']['application/json']['schema']['$ref']
    end

    def self.read(path)
      require 'zip'

      Zip::File.open(path) do |zip_file|
        entry, = zip_file.entries
        content = entry.get_input_stream(&:read)

        JSON.parse(content)
      end
    end

    def self.download(path)
      uri = URI('https://developer.apple.com/sample-code/app-store-connect/app-store-connect-openapi-specification.zip')

      Net::HTTP.start(uri.host, uri.port, { use_ssl: true }) do |http|
        response = http.get(uri.path)

        File.write(path, response.body)
      end
    end
  end
end
