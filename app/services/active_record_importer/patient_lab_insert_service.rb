require 'benchmark'

module ActiveRecordImporter
	class PatientLabInsertService

		class << self

			def start_insert_benchmark(unit = 0)
				Benchmark.bm(50) do |x|
					x.report("Simple Insert:") { simple_insert(unit) }
					x.report("Simple Insert with Transaction:") { simple_insert_with_transaction(unit) }
					x.report("Bulk Insert with Transaction:") { bulk_insert_with_transaction(unit) }
					x.report("Final Optimised Bulk Insert:") { optimised_bulk_insert(unit) }
				end

				return "===== END OF BENCHMARKS ====="
			end

			def simple_insert(unit = 0)
				unit.to_i.times do |i|
					pl = PatientLab.new(
						name: Faker::Name.name,
						doctor_code: Faker::Code.npi
					)

					pl.save
				end
			end

			def simple_insert_with_transaction(unit = 0)
				ActiveRecord::Base.transaction do
					unit.to_i.times do |i|
						pl = PatientLab.new(
							name: Faker::Name.name,
							doctor_code: Faker::Code.npi
						)

						pl.save
					end
				end
			end

			def bulk_insert_with_transaction(unit = 0)
				data_arr = []

				ActiveRecord::Base.transaction do
					unit.to_i.times do |i|
						data_arr << PatientLab.new(
							name: Faker::Name.name,
							doctor_code: Faker::Code.npi
						)
					end

					PatientLab.import data_arr
				end
			end

			def optimised_bulk_insert(unit = 0)
				data_arr = []

				ActiveRecord::Base.transaction do
					unit.to_i.times do |i|
						data_arr << PatientLab.new(
							name: Faker::Name.name,
							doctor_code: Faker::Code.npi
						)
					end

					PatientLab.import data_arr, validate: false, on_duplicate_key_ignore: true
				end
			end

		end

	end
end
