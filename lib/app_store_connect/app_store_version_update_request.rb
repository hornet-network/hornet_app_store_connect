# frozen_string_literal: true

module AppStoreConnect
  class AppStoreVersionUpdateRequest < Request::Body
    data do
      id
      type 'appStoreVersions'

      attributes do
        property :copyright
        property :earliest_release_date
        property :release_type
        property :version_string
        property :downloadable
      end
    end
  end
end
