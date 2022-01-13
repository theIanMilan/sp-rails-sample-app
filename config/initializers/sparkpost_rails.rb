SparkPostRails.configure do |c|
  c.api_key = ENV['SPARK_POST_API_KEY']
  c.inline_css = true
  c.html_content_only = true
end
