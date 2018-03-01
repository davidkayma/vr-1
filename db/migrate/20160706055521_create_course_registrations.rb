class CreateCourseRegistrations < ActiveRecord::Migration
  def change
    create_table :course_registrations do |t|
      t.references :course
      t.references :user
      t.integer :user_role
      t.boolean :approval_status

      t.timestamps null: false
    end
  end
end
