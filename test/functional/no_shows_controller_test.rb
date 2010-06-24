require 'test_helper'

class NoShowsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:no_shows)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create no_show" do
    assert_difference('NoShow.count') do
      post :create, :no_show => { }
    end

    assert_redirected_to no_show_path(assigns(:no_show))
  end

  test "should show no_show" do
    get :show, :id => no_shows(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => no_shows(:one).to_param
    assert_response :success
  end

  test "should update no_show" do
    put :update, :id => no_shows(:one).to_param, :no_show => { }
    assert_redirected_to no_show_path(assigns(:no_show))
  end

  test "should destroy no_show" do
    assert_difference('NoShow.count', -1) do
      delete :destroy, :id => no_shows(:one).to_param
    end

    assert_redirected_to no_shows_path
  end
end
