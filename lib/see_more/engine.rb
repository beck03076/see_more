module SeeMore
  class Engine < Rails::Engine
    initializer "setup for rails" do
      ActionView::Base.send(:include, SeeMore::SeeMoreHelpers)
      #ActionController::Base.send(:include, BestInPlace::ControllerExtensions)
    end
  end
end
