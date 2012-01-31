class App
  def call(env)
    [
      200,
      { "Content-Type" => "text/plain" },
      [env["PATH_INFO"]]
    ]
  end
end

run App.new