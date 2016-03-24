require 'minitest/autorun'
require 'minitest/pride'

def con(str)
  return str unless str.include?(':')
  # (:.+(.+)$)|
  # str.gsub(/:.+(([\/\b])?)/, '(.+)\1')
  str.gsub!(/(?:(?::.+[\/]([^:]+))|(:.+(.+)$))/) do
    first_match = Regexp.last_match[1]
    if first_match.nil?
      "(.+)"
    else
      "(.+)/#{first_match}"
    end
  end
  con(str)
end

class RouterTest < Minitest::Test
  def test_converts_ids
    assert_equal('/(.+)', con('/:id'))
    assert_equal('/users/(.+)', con('/users/:id'))
    assert_equal('/users/(.+)/edit', con('/users/:id/edit'))
  end

  def test_converts_names
    assert_equal('/(.+)', con('/:name'))
    assert_equal('/users/(.+)', con('/users/:name'))
    assert_equal('/users/(.+)/edit', con('/users/:name/edit'))
  end

  def test_multiple_dynamic_segments
    assert_equal('/users/(.+)/edit/(.+)', con('/users/:name/edit/:id'))
  end

  def test_rails_level_dynamic_segments
    skip
    assert_equal('/(.+)/(.+)/(.+)', con('/:resource/:id/:action'))
  end
end
