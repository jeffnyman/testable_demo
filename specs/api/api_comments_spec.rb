require 'rest-client'
require 'json_expressions/rspec'

RSpec.describe 'Comments' do
	it 'a GET request for all comments returns a 200 response' do
		result_posts = RestClient.get('http://jsonplaceholder.typicode.com/comments')
		expect(result_posts.code).to eql(200)
	end

	it 'a GET request to /comments will return all comments' do
		expected_data = JSON.parse(IO.read('./specs/api/requests/all_comments.json'))
		result_all_posts = RestClient.get('http://jsonplaceholder.typicode.com/comments')
		expect(result_all_posts).to match_json_expression(expected_data)
	end

	it 'a GET request for an invalid comment returns a 404 response' do
		result_invalid = RestClient.get('http://jsonplaceholder.typicode.com/comments/invalid') { |response, request, result| result }
		expect(result_invalid.code).to eql("404")
	end

	it 'a GET request for all comments for a given post can be returned (posts/1/comments)' do
		expected_data = JSON.parse(IO.read('./specs/api/requests/post1_comments.json'))
		result_post1_comments = RestClient.get('http://jsonplaceholder.typicode.com/posts/1/comments')
		expect(result_post1_comments).to match_json_expression(expected_data)
	end
end
