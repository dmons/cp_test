# README

### Task description

> You are required to create a simple support ticket system.Ticket should consist of Requester details (name, email), Ticket status (new, pending, resolved), Subject, Content.
Fields name, email and subject are required, email must be a valid email and default status is "new".

> Task #1. All submitted tickets must be stored in a CSV file first.  
> Task #2. Create a rake task to read CSV file with tickets saved in #1 and insert them into the appropriate model in the database.  
> Task #3. Create a view for the manager to manage tickets in the database imported in #2. This view should allow the manager to change status or delete a ticket.  

> Bonus:
> - add option for manager to leave comments to tickets
> - resolved state can't be applied prior to posting a comment to the ticket
> - view of tickets should include filtering by fields and statistics (number of tickets in each status)  
> 
> Extra bonus:
>- make it all work with registered users by roles (different models are good enough)   
>
>Feel free to implement something a bit different.

### Setup
Any ruby version suitable for Rails 7.1. I've used Ruby 3.2.2  
`bundle install`

### Postgres setup
- create user `commpeak_tickets`
and set env var with its password   
`password: <%= ENV['COMMPEAK_TEST_DATABASE_PASSWORD'] %>`  

- run
`rake db:create && rake db:migrate && rake rake db:seed`    

### Seeded users
We have 2 roles. Signin with 
- user:user
- admin:admin
### Read data from SCV  

`rake migrate_ticket:from_csv` to upload data from file to db  


  
