require "test_helper"

class QuestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @quest = quests(:one)
  end

  test "should get index" do
    get quests_url
    assert_response :success
  end

  test "should create quest" do
    assert_difference("Quest.count") do
      post quests_url, params: { quest: { activity: @quest.activity } }
    end

    assert_redirected_to quests_path
  end

  test "should destroy quest" do
    assert_difference("Quest.count", -1) do
      delete quest_url(@quest)
    end

    assert_redirected_to quests_url
  end

  test "should toggle status" do
    original_status = @quest.status
    patch toggle_status_quest_url(@quest)
    assert_redirected_to quests_path
    @quest.reload
    assert_not_equal original_status, @quest.status
  end

  test "should not create quest with invalid data" do
    assert_no_difference("Quest.count") do
      post quests_url, params: { quest: { activity: "" } }
    end

    assert_response :unprocessable_entity
  end
end
