class CompetitorPriceSyncJob
  include Sidekiq::Job

  def perform
    CompetitorPricingSyncService.new.call
  end
end
