class Friendship < ActiveRecord::Base
  after_initialize :set_defaults, unless: :persisted?
  after_update :create_inverse, if: :inverse_record_nil?
  after_destroy :destroy_inverse

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def set_defaults
    self.confirmed = false if confirmed.nil?
  end

  def create_inverse
    Friendship.create(user: friend, friend: user, confirmed: confirmed)
  end

  def update_inverse
    ir = inverse_record
    return if ir.confirmed == confirmed

    ir.confirmed = confirmed
    ir.save
  end

  def destroy_inverse
    ir = inverse_record
    return if ir.nil?

    ir.destroy
  end

  def inverse_record_nil?
    inverse_record.nil?
  end

  def inverse_record
    Friendship.where(user: friend, friend: user).first
  end
end
