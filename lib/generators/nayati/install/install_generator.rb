require 'rails/generators/migration'

module Nayati
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)
      desc "add the migrations"

      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      def copy_migrations
        migration_template "create_workflow.rb", "db/migrate/create_workflow.rb"
        migration_template "create_operation.rb", "db/migrate/create_operation.rb"
        # migration_template "create_something_else.rb", "db/migrate/create_something_else.rb"
      end

      def copy_operations_yml
        copy_file "operations.yml", "config/operations.yml"
      end
    end
  end
end
