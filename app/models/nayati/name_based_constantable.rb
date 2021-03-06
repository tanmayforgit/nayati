module Nayati
  module NameBasedConstantable
    def camelcased_name
      return "" if name.nil?
      Nayati::NameBasedConstantable.name_as_constant(self.name)
    end

    def namespaced_name
      return "" if name.nil?
      Nayati::NameBasedConstantable.name_as_namespace(self.name)
    end

    def underscored_name
      return "" if name.nil?
      Nayati::NameBasedConstantable.underscored_name(name)
    end

    def self.name_as_constant(name)
      name.to_s.split(' ').join('_').camelcase
    end

    def self.name_as_namespace(name)
      name.to_s.downcase.split(' ').join('_')
    end

    def self.underscored_name(name)
      name.to_s.underscore.split(' ').join('_')
    end
  end
end
