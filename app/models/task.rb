class Task < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :content, presence: true
  enum status:{未着手:0,着手中:1,完了:2}
  scope :sort_deadline, -> {order(deadline: :asc)}
  enum priority:{高:0,中:1,低:2}
  scope :sort_priority, -> {order(priority: :asc)}

  scope :search_name, -> (name){where('name LIKE ?', "%#{name}%")}
  scope :search_status, -> (status){where(status: status)}
  scope :search_name_status, -> (name, status){where('name LIKE ?',"%#{name}%").where(status: status)}
  scope :search_label, ->(label_title) { Label.find_by(label_title: label_title).tasks }
  #scope :search_label, -> (label_ids){ where(id: TaskLabel.where(label_id: label_ids).pluck(:task_id)) if label_ids.present?}
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels, source: :label
end