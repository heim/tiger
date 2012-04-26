module Tiger
  class Blob
    def initialize(grit_blob)
      @blob = grit_blob
    end
    def data
      @data ||= @blob.data
    end
    def size
      @size ||= data.count("\n")
    end
    def id
      @id ||= @blob.id
    end
  end
end
