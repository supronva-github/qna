class GistService
  GIST_ID_REGEXP = /[^\/]+$/.freeze

  def initialize(gist_address, client: nil)
    @gist_address = gist_address
    @client = client || GitHubClient.new
  end

  def call
    @client.gist(gist_id)
  end

  private

  def gist_id
    GIST_ID_REGEXP.match(@gist_address).to_s
  end
end
