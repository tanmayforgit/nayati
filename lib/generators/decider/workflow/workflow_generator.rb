require 'rails/generators'
require 'pry'
module Decider
  module Generators
    class WorkflowGenerator < Rails::Generators::Base


      source_root File.expand_path('../templates', __FILE__)
      desc "generate a operation"

      def check_installation
        raise 'Run rails generate decider:install first' unless File.exists?("#{Rails.root}/config/operations.yml")
      end

      def generate_workflow
        raise "Workflow name must be passed" unless args.size == 1
        workflow_name = args.first

        workflow_namespace = Decider::NameBasedConstantable.name_as_namespace(workflow_name)

        master_worflow = Decider::MasterWorkflow.new(workflow_name)
        raise 'Workflow already exists' if master_worflow.exists?

        # make entry in operations.yml
        master_worflow.save!
        operation_file_path = "#{Rails.root}/workflows/#{workflow_namespace}/#{operation_namespace}.rb"
      end
    end
  end
end