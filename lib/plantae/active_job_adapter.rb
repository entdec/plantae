# frozen_string_literal: true

module Plantae
  class ActiveJobAdapter
    def enqueue(job)
      ActiveJob::Base.execute(job.serialize)
    end

    def enqueue_at(job, timestamp)
      raise 'cannot handle jobs this far in the future' if Time.current.to_f - timestamp > 2
      ActiveJob::Base.execute(job.serialize)
    end
  end
end
