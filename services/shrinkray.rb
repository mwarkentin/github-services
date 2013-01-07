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
  end
end
