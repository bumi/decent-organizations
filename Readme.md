# Collection of resources for decent organizations

decent organizations is a directory of tools and general resources for decent organizatons. 
Think of a "producthunt.com" like website that allows us to discover, share and discuss any related links/resources around the topic of decent organizations.


## Installation

### Requirements

* Ruby (some recent version)
* PostgreSQL (some recent version)

### Getting Started

    $ cp config/database.yml.sample config/database.yml
    $ vim config/database.yml # edit your local config if required
    $ bundle install
    $ rake db:create 
    $ rake db:migrate
    $ rails server


## Features

### Browse entries




### Adding new entries

Our aim is to build an open directory to collaboratively share and collect resources.  
It should be possible for everybody to easily contribute new content.  
Adding entries does not require any signup and any new submission is directly published; there will be no review process; anybody can edit any content - wiki style WTF!

Content has the following attributes:

* Title 
* Description
* URLs: one URL is required but entries can link to multiple resources
* Categories: one or more categories

### Editing entries

It should be possible for anybody to edit content. 
For the initial release we do not story the history of the changes. 

### Voting / Rating

In order to rank and list the entries by "importance" it should be possible to up and down vote any entry. 
In order to up/down vote an entry a user has to provide a short reason for the vote.  
By providing a reason for the voting we can collect more content and the thoughts of contributors and make it a bit harder to simply randomly vote on anything. 

### RSS feed


## What are decent organizations?

Very good question. We are trying to figure that out ourselves, here are some of our thoughts so far:

We humans cannot solve systemic problems - like inequality, unsustainable growth, unfair labor, or climate change - with linear thinking in hierarchical organizations. That's where decent organizations come in.

* Decent organizations put humans first - in why, what and how they operate.
* Decent organizations are or strive to be decentralized.
* Decent organizations discuss what "decent" means.

What do you think? We would love to hear from you and collaborate with you - especially if you disagree!
