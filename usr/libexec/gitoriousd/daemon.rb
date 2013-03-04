require "pathname"
module Gitoriousd
  module Daemon
    def pidfile_path
      libexec_dir = Pathname(__FILE__).dirname
      application_name = libexec_dir.basename.to_s
      script_name = @name
      slash_root = libexec_dir + "../../../"
      run_dir = slash_root + "var/run/#{application_name}"
      "#{run_dir}/#{script_name}.pid"
    end

    def write_pidfile(pid)
      File.open(pidfile_path,"w") {|f| f.write(pid.to_s)}
    end

    def daemonize_app
      if RUBY_VERSION < "1.9"
        exit if fork
        Process.setsid
        exit if fork
        Dir.chdir "/"
        STDIN.reopen "/dev/null"
        STDOUT.reopen "/dev/null", "a"
        STDERR.reopen "/dev/null", "a"
      else
        Process.daemon
      end
      write_pidfile(Process.pid)
      yield
    end

    def write_to_log_file(message)
      File.open("/tmp/#{@name}.log","a") {|f| f.puts message}
    end
  end
end
