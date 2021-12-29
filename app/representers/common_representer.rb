class CommonRepresenter
  def initialize(code: 200, message: "success", data: nil, meta: [])
    @code = code
    @message = message
    @data = data
    @meta = meta
  end

  def as_json
    {
        code: code,
        message: message,
        data: data,
        current_page: meta[0],
        per_page: meta[1],
        total_page: meta[2],
        total_count: meta[3]
    }
  end

  private
  attr_reader :data, :code, :message, :meta
end