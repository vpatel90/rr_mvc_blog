# Request / Response MVC! Blog


* Run the server with `ruby bin/server.rb`
  * Please note: The server will need to be restarted every time you change your code.

* You can use the Postman app for any requests that are not `GET` or `POST` requests. Although, you can use almost all functionality through a browser


	![Image of Home Page](http://i.imgur.com/0SFahvk.png?1 =650x)



## Sending a Request
### Users
* `http://localhost:3001/users/new` Allows you to create a new user account - First Name and Last Name
	* Sorry no username support sooo, if someone else has your same first and last name you are out of luck :(
	* Creating a new account automatically logs you into that account
	* Can also be accessed via button
* `http://localhost:3001/users/new`  Allows you to login with your account
	* Several pregenerated accounts with sample posts
	* Can also be accessed via button
* `http://localhost:3001/users/id` Displays user profile for user with that id

### Posts
* `http://localhost:3001/` or `http://localhost:3001/posts`Returns all posts
* `http://localhost:3001/posts/1` Displays post at that ID
	* You can also click on Post title to view the post

* `http://localhost:3001/posts/new` Allows you to create a new blog post
* `http://localhost:3001/posts/published` Displays all published posts
* `http://localhost:3001/posts/unpublished` Displays all unpublished posts
* Unpublished Posts can be published, edited or deleted if the logged in user is the author of that post

	![Image of Unpublished Blog Page](http://i.imgur.com/qmQRmNw.png?1?1 =650x)



### Comments
* There is a comment section attached to every published post

### API
* `http://localhost:3001/api/posts` displays all posts in JSON
* `http://localhost:3001/api/posts/id` displays single posts in JSON
* Use Postman for PUT, POST and DELETE requests
* `POST http://localhost:3001/api/post`For POST - also pass 'author_fn' and 'author_ln' as parameters and system will dynamically create a user or use an existing user for that Post
* `PUT http://localhost:3001/api/post/id` PUT will require 'title' and 'body' params
