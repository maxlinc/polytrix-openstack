require 'polytrix'

Polytrix.validate 'Identity Authenticate Token', suite: 'Identity', sample: 'authenticate token' do |challenge|
  detected_services = challenge.plugin_data[:pacto][:detected_services]
  expect(detected_services).to include 'Cloud Identity :: Authenticate for Admin API'
end

# Will have a better system for this in the future
pacto_expectations = YAML::load(File.read("pacto_expectations.yml"))
# pacto_coverage = Hashie::Mash.new

Polytrix.configuration.default_validator_callback = proc{ |challenge|
  result = challenge[:result]
  expect(result.execution_result.exitstatus).to eq(0)

  # expected_services = begin
  #   challenge[:plugin_data]['pacto']['expected_services'] || []
  # rescue
  #   []
  # end
  expected_services = pacto_expectations[challenge.name] || []

  detected_services = begin
    challenge[:plugin_data]['pacto']['detected_services'] || []
  rescue
    []
  end

  expected_services.each do |service|
    expect(Pacto).to have_validated_service 'ignored_namespace', service
    # expect(detected_services).to include service
  end

  # pacto_coverage[challenge.name] ||= Hashie::Mash.new
  # pacto_coverage[challenge.name][example.description] = detected_services.uniq

  # File.open("reports/pacto_coverage.yml", 'wb') do |f| f.write YAML::dump pacto_coverage.to_hash end
}