require 'csv'

namespace :import do
  desc "Import customers from CSV file"

  task customer: :environment do
    CSV.foreach('./data/customers.csv', headers:true) do |row|
      Customer.create(row.to_h)
    end
  end

end
