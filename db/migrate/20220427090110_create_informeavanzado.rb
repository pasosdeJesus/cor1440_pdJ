class CreateInformeavanzado < ActiveRecord::Migration[7.0]
  include Sip::SqlHelper

  def up
    create_table :heb412_gen_informeavanzado do |t|
      t.string :titulo, limit: 256, null: false
      t.date :fechaini
      t.date :fechafin

      t.timestamps
    end
    cambiaCotejacion('heb412_gen_informeavanzado', 'titulo', 256, 'es_co_utf_8')
  end

  def down
    remove_table :heb412_gen_informeavanzado
  end
end
