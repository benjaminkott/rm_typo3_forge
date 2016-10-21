module WelcomeControllerPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development

      alias_method_chain :index, :typo3
    end
  end

  module InstanceMethods
    def index_with_typo3
      @news = News.latest User.current, 2
      @random_users = User.where("img_hash != ''").limit(10).order("RAND()")

      render 'start/index'
    end
  end
end
