# frozen_string_literal: true

require 'csv'

namespace :migrate_ticket do
  desc "Load data from CSV file to app's DB"
  task from_csv: :environment do
    unless File.exist?(TicketMock::CSV_STORAGE_FILE)
      puts '='*80
      abort "CSV file not found at path #{TicketMock::CSV_STORAGE_FILE}. \nAdd tickets at webpage!"
    end
      csv_out=[]
      count=0
      CSV.foreach(TicketMock::CSV_STORAGE_FILE, headers: true, header_converters: :symbol) do |row|
        unless row[:migrated]
          ticket = Ticket.create do |t|
            t.requester_name = row[:name]
            t.requester_email = row[:email]
            t.subject = row[:subject]
            t.status = row[:status]
            t.content = row[:content]
          end

          if ticket
            row[:migrated] = true
            count += 1
          end
        end
        csv_out << row
      end

      CSV.open("#{TicketMock::CSV_STORAGE_PATH}/updated.csv", "wb") do |row|
        row << csv_out.first&.headers
        csv_out.each do |out|
          row << out
        end
      end
      #Update records in original storage with 'migrated=true' flags
      FileUtils.mv "#{TicketMock::CSV_STORAGE_PATH}/updated.csv", TicketMock::CSV_STORAGE_FILE, :force => true

      p "------------------------------------------------"
      p "Migrated #{count} ticket(s) from csv to database"
      p "------------------------------------------------"

  end
end
