require 'spec_helper'

describe Job::Worker do
  subject(:model) do
    Struct.new("J#{unique_id}") do
      include Job::Worker
      def call
      end
    end
  end

  describe ".call_async" do
    it "creates Job::Model" do
      expect { model.call_async }.to change { Job::Model.count }.by(1)
    end
  end

  describe ".call_in" do
    it "creates Job::Model" do
      expect { model.call_in 2.minutes.from_now }.to change { Job::Model.count }.by(1)
    end
  end

  describe ".job_options" do
    it  do
      expect(model.job_options).not_to be_nil
      expect(model.job_options).to be_a(Hash)
    end
  end
end
