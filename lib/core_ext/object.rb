class Object
  def bpp
    BrowserPrint.inspect_object(self)
    self
  end
end
