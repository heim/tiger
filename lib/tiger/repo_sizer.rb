require 'grit'

module Tiger
  class RepoSizer
    
    def initialize(repo_path)
      begin
        @repo_path = repo_path
        @repo = Grit::Repo.new(repo_path)
        @register = Tiger::BlobRegister.new(@repo)
      rescue Grit::InvalidGitRepositoryError => e
        raise Tiger::Errors::InvalidGitRepository
      end
    end

    def commit_ids
      command = "git rev-list --reverse HEAD"
      @commit_shas ||= run_command_in_repo_path(command).split("\n") 
    end

    def repo_size
      commit_ids.map do |commit_id|
        [nil, repo_size_for_commit(commit_id)]
      end
    end 

    def repo_size_for_commit(commit_id)
      size = 0
      blobs_for_commit(commit_id).each do |blob|
        size += blob.data.count("\n")
      end
      size
    end

    def blobs_for_commit(commit)
      command = "git ls-tree -r #{commit} | awk '{print $3}'"
      blob_ids = run_command_in_repo_path(command).split("\n")
      blobs = blob_ids.map  do |blob_id|
        @register.get(blob_id) 
      end
    end

    private

    def run_command_in_repo_path(command)
      `(cd #{@repo_path} && #{command})`
    end
  end
end
