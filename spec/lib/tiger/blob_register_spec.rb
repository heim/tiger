require "spec_helper"
module Tiger
  describe BlobRegister do
    describe ".new" do
      it "accepts a repo as an argument" do
        BlobRegister.new(stub)
      end
    end

    describe "#add" do
      let (:repo) { mock(:repo, blob: blob) }
      let (:blob) { stub(:blob, :id => "foo") }
      let (:subject) { BlobRegister.new(repo) }
      it "returns blobs from the repo" do
        blob_id = "foo"
        repo.should_receive(:blob).with(blob_id)
        subject.get(blob_id).id.should == "foo"
      end
      
      it "does not query repo for known blobs" do
        repo.should_receive(:blob).once
        subject.get("foo")
        subject.get("foo")
      end

      it "returns class Tiger::Blob" do
        subject.get("foo").should be_a(Blob)
      end
    end
  end
end
