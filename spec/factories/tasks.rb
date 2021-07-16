FactoryBot.define do
  factory :task do
    title {Faker::Artist.name}
    content {Faker::Lorem.paragraph(10)}
    due_date {7.days.from_now}
  end

  trait :task_early do
    due_date {3.days.from_now}
  end
  trait :task_late do
    due_date {30.days.from_now}
  end

  trait :task_medium do
    priority {1}
  end
  trait :task_low do
    priority {0}
  end
end