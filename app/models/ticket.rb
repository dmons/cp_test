# frozen_string_literal: true

class Ticket < ApplicationRecord
  enum :status, [ :new, :pending, :resolved ], suffix: true, default: :new
  validates :requester_email, :requester_name, :subject, :status, presence: true
  validates_format_of :requester_email, with: URI::MailTo::EMAIL_REGEXP
  validate :resolved_status_possible, on: :update
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments, :reject_if => proc { |attributes| attributes['content'].blank? }, update_only: true


  def self.status_stats
    {'all': self.count}.merge self.group(:status).count
  end

  private
  def resolved_status_possible
    errors.add(:status, "Resolved status can't be applied without comments") if resolved_status? && comments.count == 0
  end
end
