# frozen_string_literal: true

module AppStoreConnect
  module Requests
    module V1
      module InAppPurchaseSubmission
        class Create < Request::Body
          data do
            type 'inAppPurchaseSubmissions'
          end
        end
      end
    end
  end
end
