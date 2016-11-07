
module UsingLog
  @match_num = 0
  @login_num = 0
  @m_mutex = Mutex.new
  @l_mutex = Mutex.new
  
  @timeout = 2
  
  extend ConcernGeneral
  
  instance_variables.each do |val|    
    singleton_class.send("attr_reader",val.to_s.delete("@").to_sym)
  end
  
  class << self
    def match_num=(val)        
      th = Thread.new do
        @m_mutex.synchronize {@match_num = val}
      end
      unless th.join(@timeout)
        write_error_log("Method 'UsingLog.match_num=' timeout.")
      end
    end
    
    def login_num=(val)
      th = Thread.new do
        @l_mutex.synchronize {@login_num = val}
      end
      unless th.join(@timeout)
        write_error_log("Method 'UsingLog.login_num=' timeout.")
      end
    end
    
  end
end

=begin
module UsingLog
  @login_num = 0
  @match_num = 0
  instance_variables.each do |val|    
    singleton_class.send("attr_accessor",val.to_s.delete("@").to_sym)
  end
end
=end
