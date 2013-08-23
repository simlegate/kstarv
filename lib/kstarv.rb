require "kstarv/version"
require "kstarv/k_v"

module Kstarv
  class NoSuchFile < StandardError
    def message
      # TODO should say file path to message
      "can not find _such file_"
    end
  end

  def self.from file,join='='
    File.exists?(file) ? KV.new(file, join) : (raise NoSuchFile)
  end
end
