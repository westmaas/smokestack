class JobVPC < Job

  @queue=:vpc

  def self.perform(id)
    5.times do 
      begin
        job=JobVPC.find(id)
        JobVPC.run_job(job)
        break
      rescue ActiveRecord::RecordNotFound
        sleep 5
      end
    end
  end

  after_create :handle_after_create
  def handle_after_create
    AsyncExec.run_job(JobVPC, self.id)
  end

end
