# asterisk-box
A virtual box configured for Asterisk.

## Problem
Installing and maintaining an Asterisk configuration seems foreign to you, or you want to abstract it away.

## Solution
Use a VirtualBox image with Vagrant to:

1. Deploy Asterisk on a default Ubuntu 32-bit system without X.
2. Isolate your system from Asterisk and its dependencies.

## Alternatives
The following discussion is centered not on this asterisk-box's sole needs, but on the general infrastructure automation practices I wish to put in place for my projects. I provide it here because it may affect this solution in the future.

* I would have **much** preferred to abstract the box as a [Docker](http://www.docker.io) container.
	* Quick tests showed that Asterisk's default installation procedure doesn't like 64-bit systems (and most probably being run in LXC).
* Other provisioning tools might be useful, like Pallet, Ansible, Chef, or Puppet. Ansible seems to be more data-driven than Chef and Puppet.
	* Many of these tools could be used in some combinations. I suspect the winning combination for most projects in the future will imply Docker somewhere.
* I would love to benefit from [Pallet](http://palletops.com/)'s superior programmatic infrastructure automation features.
	* Pallet could certainly be integrated as a Vagrant [provisioner](http://docs.vagrantup.com/v2/provisioning/index.html) but it may be interesting to skip Vagrant and drive VirtualBox using [Pallet's VMFest](https://github.com/pallet/pallet-vmfest).
	* I suspect Pallet may be at the nearest of the intersection of the power, simplicity and focus sets, although it's definitely not yet as easy on first approach as the other tools are. Thankfully, this is not unremediable.

## Usage
### Launch the guest box
In your host system:

```shell
cd asterisk-box
vagrant up
vagrant reload # apply updated `bootstrap/secret/conf` files or VBox Guest Additions.
vagrant ssh
```

Since automated updates take quite a long time to run, you will often want to ignore them:

```shell
vagrant up --no-provision
# or
vagrant reload --no-provision
vagrant ssh
```

###  Launch Asterisk
In your guest box:

```shell
sudo asterisk -cvvv
```
## Requirements
1. [Vagrant](http://www.vagrantup.com) installed on your host system.
2. `git clone https://github.com/DanielJomphe/asterisk-box`

### Options
1. [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest) plugin installed on your host system:
	1. `vagrant plugin install vagrant-vbguest`
	2. The plugin will automatically keep up-to-date the VirtualBox Guest Additions on all your guest boxes.

### Configuration
1. Put your custom `extensions.conf` and `sip.conf` in the `bootstrap/secret/conf` directory.
	1. When you change them, reload the box to have them automatically copied over to `/etc/asterisk/conf`.

## Limitations
At present time:

1. Only the latest **certified versions** of Asterisk are automatically installed:
	* `1.8.15-cert2`
	* `11.2-cert1`
2. Only the following **configuration files** are automatically customized:
	* `extensions.conf`
	* `sip.conf`
3. Starting up Asterisk is a manual operation.

These limitations are **very** easy to remove. Just improve the `Vagrantfile` and `bootstrap/init.sh` scripts.

## Contributing
At present time, maintain your own fork.

I might later open up to Wiki updates, Issues, and Pull Requests.

## License
Copyright © 2013 Daniel Jomphe.

Distributed under the Eclipse Public License, the same as Clojure.