require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:tet)
    @micropost = @user.microposts.build(content: 'Lorem ipsum')
  end

  test 'should be vaild' do
    assert @micropost.valid?
  end

  test 'user id should be present' do
    @micropost.user_id = nil
    refute @micropost.valid?
  end

  test 'content should be present' do
    @micropost.content = ''
    refute @micropost.valid?
  end

  test 'content should be at most 140 chars' do
    @micropost.content = 'a' *141
    refute @micropost.valid?
  end

  test 'order should be most recent first' do
    assert_equal microposts(:most_recent), Micropost.first
  end
 end
