module Nayati
  RSpec.describe Operation do
    describe '#operation_implementer_klass_name' do
      let(:operation) { create(:nayati_operation)}
      subject { operation.operation_implementer_klass_name }

      it 'Returns workflow namespaced klass name' do
        expect(subject).to eq('DoingSomethingNayatiWorkflow::SomeOperationNayatiOperation')
      end
    end

    describe '#build_implementer' do
      let(:operation) { create(:nayati_operation)}
      let(:context) { {} }
      let(:workflow_result_object) { double }
      let(:implementer_klass) { double }
      let(:implementer_klass_name) { double }
      let(:implementer_instance) { double }

      subject { operation.build_implementer(context, workflow_result_object) }
      it 'Returns implementer class' do
        allow(operation).to receive(:operation_implementer_klass_name) { implementer_klass_name }
        allow(implementer_klass_name).to receive(:constantize) { implementer_klass }
        allow(implementer_klass).to receive(:new).with(context, workflow_result_object) { implementer_instance }
        expect(subject).to eq(implementer_instance)
        # allow()
      end
    end

    describe 'associations' do
      it { Operation.reflect_on_association(:after_success_operation).macro.should  eq(:belongs_to) }
      it { Operation.reflect_on_association(:after_failure_operation).macro.should  eq(:belongs_to) }
      it { Operation.reflect_on_association(:workflow).macro.should  eq(:belongs_to) }
    end

    describe '#validatoin' do
      let(:workflow) { create(:nayati_workflow) }
      let(:operation) { Nayati::Operation.new }
      subject { operation.valid? }

      it 'Returns false with proper error message' do
        expect(subject).to be_falsey
        expect(operation.errors.messages[:workflow]).to include('must exist')
        expect(operation.errors.messages[:name]).to include("can't be blank")
      end
    end
  end
end
