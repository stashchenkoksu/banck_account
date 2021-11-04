# General description:
The system allows users create users, bank accounts, create money transactions in difference currencies.

## Built With <a name = "bw"></a>

- Ruby 2.6.3
- Rails 6.1.4'
- Sqlite3 1.4
- Bootstrap 5.1.0


# Getting Started <a name = "gs"></a>

To get a local copy of the repository please run the following commands on your terminal:
~~~bash
$ cd <folder>
$ git clone https://github.com/stashchenkoksu/banck_account
~~~

**Install gems with:**
~~~bash
$ bundle install
~~~

**Setup database with:**
>make sure you have postgress sql installed and running on your system
~~~bash
$ rails db:create
$ rails db:migrate
$ rails db:seed   # install sample list data
~~~

**Start server with:**
~~~bash
$ rails s
~~~

**Install project manager**
~~~bash
$ yarn or npm install
~~~

**To get reports**
~~~bash
$ rake 'reports:first_report[:user_identify_number, time_period]'
other statistic you can get edititng sorce code(
~~~

This app should be running at `http://localhost:3000/`

### Main menu actions:
1. Users (To see all users and accounts, create users, edit users)
2. Account manager(Make transaction and depositions)
3. Statistic (Get all reports)
3. Tags (Get all tags)
