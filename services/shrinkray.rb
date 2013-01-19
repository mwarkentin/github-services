require 'pp'

class Service::Shrinkray < Service
  url "http://shrinkray.io"
  logo_url "http://shrinkrayio.s3.amazonaws.com/logo.png"

  # mwarkentin on GitHub is pinged for any bugs with the Hook code.
  maintained_by :github => 'mwarkentin'

  # Support channels for user-level Hook problems (service failure,
  # misconfigured
  supported_by :email => 'michael@shrinkray.io',
    :twitter => 'mwarkentin'

  def receive_push
    print "Received push...\n"
    print "\n\ndata:\n"
    data.each { |datum| pp "#{datum}" }
    print "\n\npayload:\n"
    payload.each { |payload| pp "#{payload}" }
    print "\n\ncommits:\n"
    payload["commits"].each do |commit|
      print "commit: #{commit.id}\n"
      print "files added:\n"
      commit["added"].each { |file| print "* #{file}\n" }
      print "files modified:\n"
      commit["modified"].each { |file| print "* #{file}\n"}
    end
  end
end
