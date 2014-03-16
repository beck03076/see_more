require 'rails'

module SeeMore
  class Engine < ::Rails::Engine
    initializer 'see_more' do |app|
      ActiveSupport.on_load(:action_view) do
        require "see_more/helper"
        class ActionView::Base
          include SeeMore::SeeMoreHelpers
        end
      end
    end
  end
end
