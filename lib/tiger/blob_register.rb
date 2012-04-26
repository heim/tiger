module Tiger
  class BlobRegister
    def initialize(grit_repo)
      @repo = grit_repo
      @register = {}
    end
    def get(blob_id)
      @register[blob_id] || add(blob_id)
    end
    private

    def add(blob_id)
      @register[blob_id] = Blob.new(@repo.blob(blob_id))
    end
  end
end
