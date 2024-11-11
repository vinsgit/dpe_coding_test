require 'sidekiq/cron/job'

Sidekiq.configure_server do |config|
  if File.exist?(Rails.root.join('config', 'schedule.yml'))
    schedule = YAML.load_file(Rails.root.join('config', 'schedule.yml'))
    schedule.each do |job_name, job_details|
      cron_job = Sidekiq::Cron::Job.new(job_details)
      cron_job.save
    end
  end
end
