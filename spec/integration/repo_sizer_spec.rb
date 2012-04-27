require 'spec_helper'
REPO_PATH = File.dirname(__FILE__) + "/../fixtures/hubot"
FIXTURE_PATH = File.dirname(__FILE__) + "/../fixtures/"

describe Tiger::RepoSizer do

  
  subject { Tiger::RepoSizer.new(REPO_PATH) }
  let (:first_commit_id) { subject.commit_ids.last }
  before(:all) do
    `(cd #{FIXTURE_PATH} && mkdir hubot && cd hubot && git init --quiet && cat ../hubot.gz | gunzip | git fast-import --quiet && git checkout --quiet master)`
  end
  
  after(:all) do
    `(cd #{FIXTURE_PATH} && rm -rf hubot)`
  end
  describe ".new" do
    it "is initialized with a path to a git repo" do
      repo_sizer = Tiger::RepoSizer.new(REPO_PATH)
    end
    it "throws an exception if the path does not contain a git repo" do
      lambda {
        Tiger::RepoSizer.new("/")
      }.should raise_error Tiger::Errors::InvalidGitRepository
    end
  end

  describe "#commit_ids" do
    subject { Tiger::RepoSizer.new(REPO_PATH) }
    it "should return correct amount of commits" do
      subject.commit_ids.size.should == 579
    end
    it "should return the correct sha as the first commit" do
      subject.commit_ids.last.should == "45dd61dca2ffe6c015ac77695adef37d9c86f65d" 
    end
  end

  describe "#repo_size_for_commit" do
    it "returns correct size for first commit" do
      subject.repo_size_for_commit(first_commit_id).should == 2355  
    end
  end
  
  describe "#blobs_for_commit" do
    it "returns the correct amount of blobs for the first commit" do
      subject.blobs_for_commit(first_commit_id).size.should == 40
    end
    it "returns an array of Tiger::Blob's" do
      subject.blobs_for_commit(first_commit_id).first.should  be_a(Tiger::Blob)
      
    end
  end

  describe "#repo_size" do
    it "returns the correct size for first commit" do
      subject.repo_size.first[1].should == 542
    end
    it "returns the correct size for the last commit" do
      subject.repo_size.last[1].should == 2355
    end
    it "returns a hash as identifier" do
      subject.repo_size.last[0].should_not be_nil
    end
  end
end
