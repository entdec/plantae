# frozen_string_literal: true

module Plantae
  class ActiveJobAdapter
    def enqueue(job)
      job.perform_now
    end

    def enqueue_at(job, timestamp)
      raise 'cannot handle jobs this far in the future' if Time.current.to_f - timestamp > 2
      job.perform_now
    end
  end
end
