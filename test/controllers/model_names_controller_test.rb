require 'test_helper'

class ModelNamesControllerTest < ActionController::TestCase
  setup do
    @model_name = model_names(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:model_names)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create model_name" do
    assert_difference('ModelName.count') do
      post :create, model_name: { model_name: @model_name.model_name }
    end

    assert_redirected_to model_name_path(assigns(:model_name))
  end

  test "should show model_name" do
    get :show, id: @model_name
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @model_name
    assert_response :success
  end

  test "should update model_name" do
    patch :update, id: @model_name, model_name: { model_name: @model_name.model_name }
    assert_redirected_to model_name_path(assigns(:model_name))
  end

  test "should destroy model_name" do
    assert_difference('ModelName.count', -1) do
      delete :destroy, id: @model_name
    end

    assert_redirected_to model_names_path
  end
end
