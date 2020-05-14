# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    sender factory: :user
    recipient factory: :user
    text  { FFaker::HipsterIpsum.phrase }
  end
end
