require 'faker'

MACHINES = 10_000.times.map { SecureRandom.uuid }
METRIC_DATA = [
  {category: 'os_version', values: -> { Faker::App.semantic_version }},
  {category: 'ram_usage', values: -> { Random.rand(128) }},
  {category: 'cpu_usage', values: -> { Random.rand(100.0).round(2) }},
  {category: 'powershell_version', values: %w(5.1.14393.0 5.1.14300.1000 5.0.10586.494 5.0.10586.122 5.0.10586.117 5.0.10586.63 5.0.10586.51 5.0.10514.6 5.0.10018.0 5.0.9883.0 4.0 3.0 2.0)},
  {category: 'syncro_live_connectable', values: -> {(Random.rand * Random.rand > Random.rand).to_s }},
  {category: 'remote_logins', values: -> { Random.rand(50) }},
  {category: 'updates_enabled', values: -> {(Random.rand * Random.rand > Random.rand).to_s }},
  {category: 'windows_defender_enabled', values: -> {(Random.rand * Random.rand > Random.rand).to_s }},
  {category: 'last_updated', values: %w(2019-09-28 2019-10-14 2019-09-21 2019-10-02 2019-09-19 2019-09-20 2019-10-06 2019-10-05 2019-09-22 2019-10-10 2019-10-07 2019-09-18 2019-10-03 2019-09-29 2019-10-04 2019-09-14 2019-09-23 2019-10-08 2019-09-27 2019-09-17 2019-09-25 2019-09-24 2019-10-11 2019-09-26 2019-09-16 2019-10-12 2019-10-13 2019-10-01 2019-09-30 2019-10-09 2019-09-15)},
  {category: 'average_ping', values: -> { Random.rand(1500) }}
]

def run_experiment(id: nil)
  base_category_name &= "#{id}-"
  10_000.times do
    MACHINES.each do |machine_id|
      METRIC_DATA.each do |metric|
        category = "#{base_category_name}#{metric[:category]}"
        value = metric[:values].respond_to?(:sample) ? metric[:values].sample : metric[:values].call
        Metric.create(category: category, value: value, machine_id: machine_id)
      end
    end
  end
end

10.times do
  run_experiment
end
