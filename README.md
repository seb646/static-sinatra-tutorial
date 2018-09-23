# Ruby Sinatra Static Wesite Turotial
This tutorial demonstrates how to create a static website using Ruby's Sinatra framework. We will create a static three character selection system through Sinatra with some JavaScript functionality. At the end of this tutorial, we'll show you how to upload the project to both GitHub and Heroku. 

## Prerequisites
For this tutorial, you'll need: 

* [An AWS Cloud9 Account](https://aws.amazon.com/cloud9/)
* [A GitHub Account](https://github.com/join)
* [A Heroku Account](https://heroku.com) 

Helpful (but not required): Basic knowledge of the command line, HTML/CSS, and Ruby.

## Step 1 :: Create Your Workspace
Login to Cloud9 and click "Create a new workspace". The workspace should use the Ruby template. 

![Workspace Screenshot](https://image.ibb.co/dL8GXU/Screen_Shot_2018_09_22_at_4_08_42_PM.png)

## Step 2 :: Install Sinatra

Sinata is a lightweight Ruby web framework that helps us easily deploy our website.

To install Sinatra, we're going to use RubyGems:
	
	$ gem install sinatra

Before we create an instance of Sinatra, we need to make sure we're using Ruby 4.4.4. so that the application will be compatible with Heroku. To update Ruby, we'll use Ruby Version Manager (RVM): 

	$ rvm install 2.4.4
	$ rvm --default use 2.4.4
	$ ruby -v

## Step 3 :: Setup Sinatra 
Once Sinatra is installed, we need to create a directory to contain our project. 
	
	$ mkdir static-sinatra
	$ cd static-sinatra
	
Next, we need to create an instance of Sinatra within our project folder. To do this, we'll create and edit a file called "app.rb". 

	$ touch app.rb
	
You should see the "app.rb" file appear in the file tree to the left of the text editor. Click on the file and copy/paste the following configurations and routes:

```ruby
require 'sinatra'

set :port, 8080
set :static, true
set :bind, '0.0.0.0'

get '/' do
    "Welcome to Sinatra!" 
end	
```

This creates a local Ruby web server where Sinatra will run. This configuration is optimized for Cloud9, so if you're using another IDE and experience errors, you might want to consider changing some of the options. 

To test your instance of Sinatra, type: 

	$ ruby app.rb
	
You should see this:
![Init Sinatra](https://image.ibb.co/hhqDCU/Screen_Shot_2018_09_22_at_4_39_19_PM.png)

Congratulations, you've just created your first Sinatra web app! To terminate the process, type ```CTRL + C```. 

## Step 4 :: Create Your Website
To build a website using things like HTML/CSS and JavaScript, we'll need to configure Sinatra to use a "views" folder for templating. 

The first thing we need to do is create a folder to store our content. Within the "static-sinatra" folder, type the follwing into your colsole: 

	$ mkdir views

Next we need to change the route in "app.rb" configuration file. The route automatically searches for files within the "views" folder. Replace lines 7-9 with: 

	get '/' do
	    erb :index
	end

After that, we need to create our "layout.erb" file to use as a template for our website. ERB is a server template that allows us to embed Ruby within our HTML. For the purpose of this tutorial, we'll use Bootstrap to theme the website. 

Create the "layout.erb" file within the "views" folder: 

	$ touch layout.erb

Next, copy/paste the following into the "layout.erb" file:

```html
<html>
<head>
    <meta charset="utf-8">
    <title>Robot, Lion, Eagle</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link href="/assets/style.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
        
<body>
    <%= yield %>
       
    <script>
    $("#robot").click(function() {
        $("#robot-selected").removeClass("hidden");
        $(this).addClass("active");
        $("#lion-selected").addClass("hidden");
	$("#eagle-selected").addClass("hidden");
	$("#lion").removeClass("active");
	$("#eagle").removeClass("active");
    });
    $("#lion").click(function() {
        $("#lion-selected").removeClass("hidden");
        $(this).addClass("active");
        $("#robot-selected").addClass("hidden");
        $("#eagle-selected").addClass("hidden");
        $("#eagle").removeClass("active");
        $("#robot").removeClass("active");
    });
    $("#eagle").click(function() {
        $("#eagle-selected").removeClass("hidden");
        $(this).toggleClass("active");
        $("#lion-selected").addClass("hidden");
        $("#robot-selected").addClass("hidden");
        $("#lion").removeClass("active");
        $("#robot").removeClass("active");
    });
    $("#clear-selection").click(function() {
        $("#eagle-selected").addClass("hidden");
        $("#lion-selected").addClass("hidden");
        $("#robot-selected").addClass("hidden");
        $("#lion").removeClass("active");
        $("#robot").removeClass("active");
        $("#eagle").removeClass("active");
    });
    </script>
</body>
</html>
```

As this is a template, most of our content will exist in other files. That content carries over from other files on line 11 through the ```<%= yield %>``` tag. 

After this, we need to create the content of our website. Also within the views folder, we'll create an "index.erb" file.

	$ touch index.erb
	
Next, copy/paste the following into the "index.erb" file:

```html
<center>
  <div class="container mt-5">
    <div class="row">
      <div class="col-sm-4">
        <div class="avatar-background" id="robot">
          <img src="https://image.ibb.co/bSVKge/robot02_90810.png" class="avatar">
        </div>
        <br>
        <h2>Robot</h2>
      </div>
      <div class="col-sm-4">
        <div class="avatar-background" id="lion">
          <img src="https://image.ibb.co/dt9C1e/young_lion_97429.png" class="avatar">
        </div>
        <br>
        <h2>Lion</h2>
      </div>
      <div class="col-sm-4">
        <div class="avatar-background" id="eagle">
          <img src="https://image.ibb.co/cwxnZz/22275eagle_98734.png" class="avatar">
        </div>
        <br>
        <h2>Eagle</h2>
      </div>
    </div>
    <br><br>
    <div class="row">
      <div class="col-sm-4"></div>
      <div class="col-sm-4">
        <div class="card">
          <div class="card-body">
            Character Selected:
            <h4>
              <span id="robot-selected" class="hidden">Robot</span>
              <span id="lion-selected" class="hidden">Lion</span>
              <span id="eagle-selected" class="hidden">Eagle</span>
            </h4>
          </div>
        </div>
      </div>
      <div class="col-sm-4"></div>
    </div>
    <br><br>
    <button type="button" class="btn btn-danger" id="clear-selection">Clear Selection</button>
  </div>
</center>
```

The last thing we're going to do is create a static asset, a CSS file. For this, we'll need to create a "public" folder within "static-sinatra". The "public" folder acts as our static home directory for the application. This will be where we store things like images, documents, and CSS files. Assuming we're still in the "views" folder, type: 

	$ cd ..
	$ mkdir public
	
I like to contain things like images and CSS within a folder called "assets". So, within our public folder, we'll create an "assets" folder and a "style.css" file. (Once uploaded to a website, this folder can be viewed by going to  ```YOURSITE.com/assets ```)

	$ cd public
	$ mkdir assets
	$ cd assets 
	$ touch style.css
	
Open the "style.css" file and copy/paste the following:

 ```CSS
.avatar-background{
    background: #eee;
    padding: 50px;
    border-radius: 900px;
    width: 300px;
    height: 300px;
    transition: 0.3s;
}

.avatar-background:hover{
    box-shadow: 0 .5rem 1rem rgba(0,0,0,.15);
    transition: 0.3s;
    background: #f7f7f7;
    cursor: pointer;
}

.avatar-background.active{
    box-shadow: 0 .5rem 1rem rgba(0,0,0,.15);
    background: #d0e0ff;
}

.avatar{
    width: 200px;
}

.hidden{
    display: none;
    transition: 0.3s;
}

.visible{
    display: visible !important;
    transition: 0.3s;
}
 ```
 
We're now ready to run and test our application! Within our home "static-sinatra" folder, type:
 
 	$ ruby app.rb
 	
 You should see this: 
 
 ![Final Product](https://image.ibb.co/gnggHU/Screen_Shot_2018_09_22_at_5_40_01_PM.png)
 

## Step 5 :: Upload to GitHub
To upload our project onto GitHub, we need to first create a repository. Login to your GitHub account and navigate to https://github.com/new. Name the directory whatever you'd like, but _do not_ initialize it with a ReadMe. 

Once the directory is created, you should see this: 

 ![GitHub Init Repo](https://image.ibb.co/byPwj9/Screen_Shot_2018_09_22_at_5_33_03_PM.png)
 
Next, initialize Git for Cloud9. Within the "static-sinatra" folder, type:

	$ git init
	$ git add . 
	$ git commit -m "First commit" 
 
Then we're going to add our GitHub repository's HTTPS origin. Copy the HTTPS link from the "Quick Setup" section of GitHub and copy/paste it in the following console command:

	$ git remote add origin INSERT-LINK-HERE
	$ git remote -v
	
And finally we can now push our files to GitHUb: 

	$ git push origin master
	
You'll see a prompt for your GitHub username and password. Once authenticated, the "static-sinatra" folder and files should all be visible on GitHub! 

## Step 6 :: Deploy to Heroku
Heroku allows us to run the site on a webpage that is accessible on the web. Before we get started, we need to create a few files to configure the deployment.

First, we need a "config.ru" file. This sets basic the basic paramaters and requirements for the Sinatra application. Within the "static-sinatra" folder, type:

	$ touch config.ru
	
The "config.ru" file should contain:

```ruby
require './app'
run Sinatra::Application
```

Next, we need to greate a "Gemfile" file (case sensitive). This tells Heroku about the Gems we have installed. 

	$ bundle init

Replace the contents of "Gemfile" with:	
```ruby
source 'https://rubygems.org'
ruby '2.4.4'
gem 'sinatra'
```
Now install the Heroku gem, Heroku's CLI assets, and Node: 

	$ sudo gem install heroku
	$ curl https://cli-assets.heroku.com/install.sh | sh
	$ nvm install 8.9.1
	
We'll also need to move the files we've just installed so they're usable on our system:

	$ sudo mv /usr/local/bin/heroku /usr/local/rvm/rubies/ruby-2.4.4/bin/heroku 

The last thing we need to do is create a Procfile to tell Heroku what commands to execute on start. Type:

	$ touch Procfile
	
Copy/paste the following into your Procfile:

	web: bundle exec ruby app.rbgit add -f app.rb Gemfile Gemfile.lock config.ru
	
Before we connect, we need to remove some Cloud9 specific configuration in Sinatra. Open "app.rb" and replace the contents with:

```ruby
require 'sinatra'

get '/' do
    erb :index
end
```

We can now connect to Heroku:

	$ heroku login
	
Once you've authenticated, we can create our Heroku project: 

	$ create heroku PROJECT-NAME buildpack heroku/ruby
	
Before we push our application to Heroku, we need to tell Git stop ignoring our configuration files and then commit our changes:

	$ git add -f app.rb Gemfile Gemfile.lock config.ru Procfile
	$ git commit -am "heroku commit"
	
And finally we can push our Sinatra web app to Heroku:

	$ git push heroku master 
