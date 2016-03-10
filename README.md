#Introduction

This repository contains the puppet manifests and the VagrantFile that can be used to set up a local environment to run a basic django configued box.  

#Get Started

The first step to get started clone this repository:

`git clone https://github.com/motatoes/vagrant-puppet-django`

The next step is to edit the `VagrantFile` and edit the following lines to match your settings:

```
"username" => "youruser",
# Use openssl -1 to generate this password hash
"password" => "passhash",
"projectname" => "cool_project"
```

Finally, you run the following command to create the VM:

```
vagrant up
```


If all goes well your VM should be created and provisioned successfully. You can login to your new developement VM using:

```
vagrant ssh
```

This will open a shell with the user vagrant, you probably want to switch the user to the username used to create for your project:

```
su youruser
password:
Repeat password:
vagrant@youruser~ 
cd ~/
```

Finally you can activate the virtualenv environment before starting your django project

```
source virtualenvs/yourproject/bin/activate
(yourproject) vagrant@youruser~
```


And that should be it! Enjoy


# To do
- Make the manifest more modular through the user of `puppet modules`

# Contribution

- Submit an issue if you face problems settings up the environment of if you have a feature request

# TODO

- [] During provisioning create a postgres database called ${username} and grant the user ${username} all permissions to this database
- [] Make the puppet manifest modular by create a module for each component and 'including'
