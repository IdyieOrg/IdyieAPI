class IdyieLlmService
  include HTTParty
  base_uri "#{ENV.fetch('IDYIE_LLM_URL') || 'http://idyie-llm-application:9090'}/api"

  def initialize
    @headers = { 'Content-Type' => 'application/json' }
  end

  def get(endpoint)
    self.class.get(endpoint, headers: @headers)
  end

  def post(endpoint, body)
    self.class.post(endpoint, headers: @headers, body: body.to_json)
  end
end
