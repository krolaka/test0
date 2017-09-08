class Message < ApplicationRecord
  belongs_to :tx_user, class_name: 'User', foreign_key: 'txuser_id'
  belongs_to :rx_user, class_name: 'User', foreign_key: 'rxuser_id'

  def self.get_messages current_user, opponent_id
    sql_string = 'txuser_id = ? AND rxuser_id = ? OR txuser_id = ? AND rxuser_id = ?'
    Message.where(sql_string, opponent_id, current_user, current_user, opponent_id)
  end

  def mark_as_read
    update(read: true)
  end

end