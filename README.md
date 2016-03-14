# hubot-aws
**Save AWS credentials as environment variables:**
```
echo 'export AWS_KEY="KEY"
export AWS_SECRET="SECRET"
export AWS_KEYNAME="hubot"
export AWS_KEYPATH="~/.ssh/hubot.pem"' >> ~/.bashrc
```

**Change JabberID and JabberPassword to match your Hipchat credentials:**
```
vi systemd/myhubot-dev
vi systemd/myhubot-prod
```

**Install vagrant-aws plugin and add dummy box:**
```
vagrant plugin install vagrant-aws
vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box
```

**Start provision of development environment:**
```
vagrant up dev --provider virtualbox
```

**Start provision of production environment:**
```
vagrant up prod --provider aws
```
