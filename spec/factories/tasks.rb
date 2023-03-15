FactoryBot.define do
  factory :task do
    name { 'task_name' }
    content { 'test_content' }
  end

  factory :second_task,class: Task do
    name { 'test_name2' }
    content { 'test_content2' }
  end
end