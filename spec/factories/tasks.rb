FactoryBot.define do
  factory :task do
    name { 'task_name' }
    content { 'test_content' }
    deadline { '2023-03-10' }
    status { '着手中' }
    priority { '高' }
  end

  factory :second_task,class: Task do
    name { 'test_name2' }
    content { 'test_content2' }
    deadline { '2023-03-11' }
    status {'未着手'}
    priority { '中' }
  end
end