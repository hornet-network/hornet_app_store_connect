# frozen_string_literal: true

module AppStoreConnect
  module Requests
    module V1
      module InAppPurchasePriceSchedule
        class Create < Request::Body
          data do
            type 'inAppPurchasePriceSchedules'
          end
        end
      end
    end
  end
end
