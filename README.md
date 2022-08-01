# **Fantasy Football League**

The Fantasy Football League is a web application where a user can create/manage football teams. Multiple seasons can be created. Each season consists of many games. Standings for each season are generated automatically based on the result of the games.

### **Prerequisites**

To run this game, installation of `ruby` and `bundler` are required. You’ll also need a modern browser to be able to interact with the application.

### **How to Install**

Clone the repository in your local machine with the following command:

    `git clone git@github.com:saadrumon/fantasy-football-league.git`

Then go inside the project directory using terminal and install required packages as follow:

    `cd fantasy-football-league && bundle install`

Install javascript packages using yarn.

    `yarn install`

Now, copy the .env.sample file into .env file. Insert appropriate values in the .env file.

    `cp .env.sample .env && nano .env`

### How it Works

Navigate inside the project directory and run database creation and migration commands.

    `rails db:create && rails db:migrate`

Run the seed files to popultate data for Player and Team models.

    `rails db:seed`

Start the application server.

    `rails s`

Open the browser and hit the following url to check out the application:

    `https://www.getpostman.com/collections/b2245e4f66e034013bfd`
