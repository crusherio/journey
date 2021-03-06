class AddAllowDeleteOptionToQuestionnaires < ActiveRecord::Migration
  def self.up
    add_column :questionnaires, :allow_delete_responses, :boolean
    Questionnaire.all(:conditions => { :is_open => true }).each do |q|
      q.allow_delete_responses = false
      q.save :validate => false
    end
  end

  def self.down
    remove_column :questionnaires, :allow_delete_responses
  end
end
