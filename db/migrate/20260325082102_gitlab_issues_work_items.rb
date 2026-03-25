class GitlabIssuesWorkItems < ActiveRecord::Migration[8.1]
  def up
    # gitlab cambio URLs de issues por work_items
    execute <<-SQL
      UPDATE cor1440_gen_actividad 
        SET urlcaso=REPLACE(urlcaso, '/issues/', '/work_items/')
        WHERE urlcaso LIKE 'https://gitlab%/issues/%';
    SQL
  end

  def down
    execute <<-SQL
      UPDATE cor1440_gen_actividad 
        SET urlcaso=REPLACE(urlcaso, '/work_items/', '/issues/')
        WHERE urlcaso LIKE 'https://gitlab%/work_items/%';
    SQL

  end
end
