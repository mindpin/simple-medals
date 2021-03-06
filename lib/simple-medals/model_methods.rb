class Medal
  module ModelMethods
    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def give_medal(medal_name, options = {})
        send(:"after_#{options[:on]}") do |model|
          user = options[:user].call(model)
          condition = options[:if].call(model, user)

          Medal.get(medal_name).give_to(user) if condition
          true
        end
      end
    end
  end
end
