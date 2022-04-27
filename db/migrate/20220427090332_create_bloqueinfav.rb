class CreateBloqueinfav < ActiveRecord::Migration[7.0]
  def change
    create_table :heb412_gen_bloqueinfav do |t|
      t.integer :informeavanzado_id, null: false
      t.string :bloque, limit: 128, null: false
      t.string :parametros, limit: 512
      t.integer :posicion

      t.timestamps
    end
    add_foreign_key :heb412_gen_bloqueinfav, :heb412_gen_informeavanzado,
      column: :informeavanzado_id
  end
end
