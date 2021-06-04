require 'benchmark'

module ActiveRecordImporter
	class PatientLabUpdateService

		class << self

			def start_update_benchmark(unit = 0)
				Benchmark.bm(50) do |x|
					x.report("Simple Update:") { simple_update(unit) }
					x.report("Simple Update with Transaction:") { simple_update_with_transaction(unit) }
					x.report("Bulk Update with Transaction:") { bulk_update_with_transaction(unit) }
				end

				return "===== END OF BENCHMARKS ====="
			end

			def simple_update(unit = 0)
				patient_labs = PatientLab.limit(unit)

				patient_labs.each do |pl|
					pl.update(doctor_code: Faker::Code.npi)
				end
			end

			def simple_update_with_transaction(unit = 0)
				patient_labs = PatientLab.limit(unit)

				ActiveRecord::Base.transaction do
					patient_labs.each do |pl|
						pl.update(doctor_code: "#{Faker::Code.npi} - Updated with Transaction")
					end
				end
			end

			def bulk_update_with_transaction(unit = 0)
				patient_labs 	= PatientLab.limit(unit)
				data_arr 		= []

				patient_labs.each do |pl|
					pl.doctor_code 	= "#{Faker::Code.npi} - Bulk Updated with Transaction"
					data_arr 		<< pl 
				end

				ActiveRecord::Base.transaction do
					PatientLab.import data_arr, on_duplicate_key_update: [:doctor_code]
				end
			end

		end

	end
end
