MACHINES = 20_000.times.map { SecureRandom.uuid }
METRIC_DATA = [
  { category: 'powershell_version', values: %w(5.1.14393.0 5.1.14300.1000 5.0.10586.494 5.0.10586.122 5.0.10586.117 5.0.10586.63 5.0.10586.51 5.0.10514.6 5.0.10018.0 5.0.9883.0 4.0 3.0 2.0) },
  { category: 'syncro_live_connectable', values: ->{(Random.rand * Random.rand > Random.rand).to_s} },
  { category: 'windows_update_version', values: %w(1809 1803 1709 1703 1607 1511).map { |s| "windows_10_#{s}"} },
]

def run_experiment(id: nil)
  base_category_name &= "#{id}-"
  100_000.times do
    METRIC_DATA.each do |metric|
      category = "#{base_category_name}#{metric[:category]}"
      value = metric[:values].respond_to?(:sample) ? metric[:values].sample : metric[:values].call
      machine_id = MACHINES.sample
      Metric.create(category: category, value: value, machine_id: machine_id)
    end

  end
end
