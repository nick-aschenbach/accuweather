$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'accuweather'

def load_fixture(filename)
  File.read(File.join(File.dirname(__FILE__), 'fixtures', filename))
end