require 'rest-client'
require 'json_expressions/rspec'

RSpec.describe 'Posts' do
	it 'a GET request for all posts returns a 200 response' do
		result_posts = RestClient.get('http://jsonplaceholder.typicode.com/posts')
		expect(result_posts.code).to eql(200)
	end

  it 'a GET request to /posts will return all posts' do
		expected_data = JSON.parse(IO.read('./specs/api/requests/all_posts.json'))
		result_all_posts = RestClient.get('http://jsonplaceholder.typicode.com/posts')
		expect(result_all_posts).to match_json_expression(expected_data)
	end

	it 'a GET request for an invalid post returns a 404 response' do
		result_invalid = RestClient.get('http://jsonplaceholder.typicode.com/posts/invalid') { |response, request, result| result }
		expect(result_invalid.code).to eq("404")
	end

	it 'a GET request for a specific post returns that post (posts/1)' do
		expected_data = JSON.parse(IO.read('./specs/api/requests/post1.json'))
		result_post1 = RestClient.get('http://jsonplaceholder.typicode.com/posts/1')
		expect(result_post1).to match_json_expression(expected_data)
	end

	it 'a POST request for a post will create a new post and return a 201 response (/posts)' do
		post_response = RestClient.post('http://jsonplaceholder.typicode.com/posts', {
    	title: 'foo',
    	body: 'bar',
    	userId: 1
  	})
  	expect(post_response.code).to eq(201)
	end

	it 'a PATCH request will update a post and return a 200 response (/posts/1)' do
		patch_response = RestClient.patch('http://jsonplaceholder.typicode.com/posts/1', {
    	title: 'Fooo'
  	})
  	expect(patch_response.code).to eq(200)
  end
end
