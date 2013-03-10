module Kernel
  alias pew_original_require require
  private :pew_original_require

  def require(path)
    begin
      pew_original_require(path)
    rescue LoadError
      PEW.require(path)
    end
  end

  private :require
end
