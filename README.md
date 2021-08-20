# Project-1---sinister-six-2-thistimeitspersonal

## Description
For this project, we created Salesforce business processes for a fictional business called **Dungeons and Dragons Universe.** This business provides a paid, nationwide service that allows Users to play Dungeons and Dragons with other local Users via a location-based matching system, as well as company-provided Dungeon Masters who manage campaigns.

In terms of Salesforce functionality, Dungeons and Dragons Universe (or D&DU, for short) utilizes an org with an extensive data model, as well as several automated processes, triggers, security features, and Sales/Service Cloud features to produce a singular, coherent experience from which employees can easily manage campaigns all over the country.

## Technologies Used
- Visual Studio, ver. 1.59.0
- GitHub
- Salesforce

## Features
- Robust Experience Site for players with the following features:
   - Character Creation kit, for creating characters to use in D&D campaigns. Utilizes API calls so it always incorporates up-to-date information
   - Party Page, detailing info about the Player's current group, including fellow group members, characters, the current campaign, and their Dungeon Master
   - Campaign Page, where Players can view details about a campaign they are currently part of
   - Player Page, detailing info about individual users.
- Automatic matching system that takes players in similar locations (or "Regions") and matches them together in a Party
- Scheduling functionality for campaigns and sessions
- Custom applications and Reports/Dashboards for employees to track Campaign activity
- Different pricing models for Players to choose from, based on session frequency and whether or not they would like to play online instead of in-person.
- Reports and Dashboards highlighting DM performance, Player demand, and overall user satisfaction

To-Do
- Another styling pass on Experience Site
- Automated processes that send emails/notifications to players/DM's before a scheduled session is about to start

## Getting Started
### Salesforce Platform
- Created a new org
- Drafted an Entity Relationship Table (ERD) based on business need, and implemented it as a series of interconnected objects with security enforced.
   - The purpose of each object is explained in-depth in the "Each Object and Its Purpose" section of this repo's wiki
   - The ERD is shown in [this pdf.](https://github.com/EX-Salesforce-Training/Project-1---sinister-six-2-thistimeitspersonal/files/7022421/D.DU.ERD.pdf)
- Wrote triggers and tests for objects to initialize preliminary functionality.

### GitHub
- Created a new repository
- Created a wiki page detailing the objects used, and their purpose in the org
- Created a kanban board for team members to keep track of each other's progress
- Cloned repository into a local version using Github Desktop
- After every team member had created a local repo, each one made a branch of their own to work on individual implementations

### Visual Studio
- Installed and utilized SFDX extension
- Connected Visual Studio to local copy of repo
- Connected Visual Studio to Salesforce organization by authorizing org and utilizing login credentials to grant access

## Usage
Following the steps above, you can now utilize the database according to the business needs of your very own instance of D&DU.

Utilizing Salesforce, you can create new Users to populate your business. You can assign them a Role, according to this Role Hierarchy. ![IMG_0056](https://user-images.githubusercontent.com/86627098/130253636-9d3d3ae4-dce9-4556-abeb-cf4fbad2e473.jpg)

Afterwards, each user can be given a profile. Each one has different object/field permissions, like so:
![Field-Level Security](https://user-images.githubusercontent.com/86627098/130253799-ae015777-8ef2-4c51-9693-ac9895cae1f0.jpeg)

As Players sign up (via the Experience Site), they will be added to a queue. A Dungeon Lord will be able to close this queue and turn it into a Party. Players can utilize the Experience Site to create their own Characters to use in the Party. Once the queue is closed, and these Players are officially grouped together and assigned a DM, the Campaign begins.

Every session takes place off-platform, usually in-person at a specified location (or online using programs like Roll20), so there is no functionality in Salesforce for handling an actual session. Nonetheless, a DM can log info about each session, creating a "Session" object after each playthrough. DM's must keep their campaigns active by scheduling sessions -- if a DM leaves a campaign idle for a long enough time, their Dungeon Lord is notified.

As the playerbase grows, more DM's will be in charge of more Campaigns, allowing the userbase to grow and giving you the opportunity to expand your business.

## Contributors
- Carlo Mejia
- Jerry Laughter
- Jacob Schwartz
- Serif Korkmaz
