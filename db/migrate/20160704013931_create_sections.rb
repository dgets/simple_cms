class CreateSections < ActiveRecord::Migration
  #def change
  #  create_table :sections do |t|

  #    t.timestamps null: false
  #  end
  #end

  #def up
  #  create table :subjects do |t|
  #    t.string "name"
  #    t.integer "position"
  #    t.boolean "visible", :default => false
  #    t.timestamps
  #  end
  #end

  #def down
  #  drop_table :subjects
  #end

  def change
    create_table :sections do |t|
      t.integer "page_id"
      # same as: t.references :page
      t.string "name"
      t.integer "position"
      t.boolean "visible", :default => false
      t.string "content_type"
      t.text "content"
      t.timestamps
    end

    add_index("sections", "page_id")

  end

end
