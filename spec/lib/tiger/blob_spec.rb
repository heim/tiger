require 'spec_helper'

module Tiger
  describe Blob do
    describe ".new" do
      it "wraps a grit blob" do
        Blob.new(stub)
      end
    end
    subject { Blob.new(stub) }
    [:data, :id, :size].each do |method|
      it "##{method} exists" do
        subject.should respond_to(method)
      end
    end
  end
end

