module Versions
  def self.included(base)
    base.version :square_100 do
      process :resize_to_fill => [100, 100]
      def full_filename(for_file)
        "square_100.#{model.extension}"
      end
    end
  end
end
