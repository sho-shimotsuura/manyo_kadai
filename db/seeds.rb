User.create!(name: "admin", email: 'admin@gmail.com', password: '111111', password_confirmation: '111111', admin: true)

10.times do |n|
  User.create!(
    email: "test#{n + 1}@gmail.com",
    name: "テスト#{n + 1}",
    password: "password#{n + 1}",
    password_confirmation: "password#{n + 1}",
    admin: false
  )
end

10.times do |n|
  Task.create!(
    name: "name#{n + 1}",
    content: "content#{n + 1}",
    deadline: "2023-01-01",
    status: "未着手",
    priority: "高",
    user_id: n + 1
  )
end

10.times do |n|
  Label.create!(
    label_title: "ラベル#{n + 1}"
  )
end

10.times do |n|
  TaskLabel.create!(
    task_id: n + 1,
    label_id: n + 1
  )
end