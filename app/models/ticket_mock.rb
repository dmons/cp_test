# frozen_string_literal: true
require 'csv'

class TicketMock
  CSV_STORAGE_PATH = "#{Rails.root}/public"
  CSV_STORAGE_FILE = "#{CSV_STORAGE_PATH}/tickets_list.csv"
  include ActiveModel::Model
  extend ActiveModel::Naming

  attr_accessor :requester_name, :requester_email, :subject, :status, :content

  def initialize(*args)
    options = args.extract_options!
    if options[:current_user]
      self.requester_name = options[:current_user]&.name
      self.requester_email = options[:current_user]&.email
    end
    self.status = :new
    super
  end

  validates :requester_email, :requester_name, :subject, presence: true
  validates_format_of :requester_email, with: URI::MailTo::EMAIL_REGEXP

  def save
    if valid?
      headers = ["Name", "Email", "Status", "Subject", "Content", "Migrated"]
      CSV.open(CSV_STORAGE_FILE, "a+") do |csv|
        csv << headers if csv.count.eql? 0 #adding headers only at begging of file
        csv << [requester_name, requester_email, status, subject, content, nil]
      end
      true
    else
      raise StandardError.new 'Invalid data'
    end
  end
end
