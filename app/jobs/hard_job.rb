class HardJob
  include Sidekiq::Job

  def perform(*args)
    Rails.logger.info "======>>>>>Job working #{args}"
    # Comment.create(user_id: User.first.id, )
  end
end