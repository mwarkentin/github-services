class Service::Obs < Service::HttpPost
  string :url, :token, :project, :package

  white_list :url, :project, :package

  default_events :push

  url "https://build.opensuse.org"
  logo_url "https://github.com/openSUSE/obs-landing/blob/gh-pages/images/obs-logo.png"

  maintained_by :github => 'adrianschroeter'

  supported_by :web => 'https://www.openbuildservice.org/support/',
    :email => 'buildservice-opensuse@opensuse.org'

  def receive_push
    # required
    token = required_config_value('token')
    url = config_value('url')
    url = "https://api.opensuse.org:443" if url.blank?

    # optional. The token may set the package container already.
    project = config_value('project')
    package = config_value('package')

    if token.match(/^[A-Za-z0-9+\/=]+$/) == nil
      # token is not base64
      raise_config_error "Invalid token"
    end

    http.ssl[:verify] = false
    http.headers['Authorization'] = "Token #{token}"

    url = "#{url}/trigger/runservice"
    unless project.blank? or package.blank?
      url << "?project=#{CGI.escape(project)}&package=#{CGI.escape(package)}"
    end
    deliver url
  end
end