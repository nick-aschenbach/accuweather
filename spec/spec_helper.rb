$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'accuweather'

def load_fixture(filename)
  path = File.join(File.dirname(__FILE__), 'fixtures', filename)
  allow(File).to receive(:read).with(path).and_call_original
  File.read(path)
end