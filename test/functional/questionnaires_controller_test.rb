require 'test_helper'

class QuestionnairesControllerTest < ActionController::TestCase
  before do
    sign_in FactoryGirl.create(:person)
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:questionnaires)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_questionnaire
    old_count = Questionnaire.count
    post :create, :questionnaire => { :title => "New questionnaire!" }
    assert_equal old_count+1, Questionnaire.count
    
    assert_redirected_to questionnaire_path(assigns(:questionnaire))
  end
  
  describe 'with a questionnaire' do
    before { @questionnaire = FactoryGirl.create(:questionnaire) }

    it 'should show questionnaire' do
      get :show, :id => @questionnaire.id
      assert_response :success
    end

    it 'should edit questionnaire' do
      get :edit, :id => @questionnaire.id
      assert_response :success
    end
  
    it 'should update questionnaire' do
      # update redirects to referer
      @request.env['HTTP_REFERER'] = 'http://example.com'
      
      put :update, :id => @questionnaire.id, :questionnaire => { :title => "blooblah" }
      assert_equal "blooblah", @questionnaire.reload.title
      
      assert_redirected_to 'http://example.com'
    end
  
    it 'should destroy questionnaire' do
      old_count = Questionnaire.count
      delete :destroy, :id => @questionnaire.id
      assert_equal old_count-1, Questionnaire.count
    
      assert_redirected_to questionnaires_path
    end
  end
end
