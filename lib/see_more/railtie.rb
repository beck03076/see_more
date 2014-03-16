require 'see_more/helper'
module SeeMore
  class Railtie < Rails::Railtie
    initializer "my_gem.view_helpers" do
      ActionView::Base.send :include, SeeMoreHelpers
    end
  end
end
