class CreatePatientLabs < ActiveRecord::Migration[5.1]
  def change
    create_table :patient_labs do |t|
      t.string :name
      t.string :doctor_code

      t.timestamps
    end
  end
end
