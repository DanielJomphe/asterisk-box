# asterisk-box 0.0.0
An OS preconfigured for Asterisk, ready to use in a VM (or not).

## Problem
Installing and maintaining an Asterisk configuration is time-consuming. Let's abstract most of that away.

## Solution
Use a VirtualBox image with Vagrant to:

1. Deploy Asterisk on a default terminal-only Ubuntu 32-bit system.
2. Isolate your system from Asterisk and its dependencies.

## Requirements
1. [VirtualBox](http://www.virtualbox.org/) installed on your host system.
2. [Vagrant](http://www.vagrantup.com) installed on your host system.

### Options
1. [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest) plugin installed on your host system:
	1. `vagrant plugin install vagrant-vbguest`
	2. The plugin will automatically keep up-to-date the VirtualBox Guest Additions on all your guest boxes.

### Configuration
1. Put your custom `extensions.conf` and `sip.conf` in the `conf/secret` directory.
	1. When you change them, run `configure-asterisk.sh` in the guest box to have them copied over to `/etc/asterisk/conf`.

## Usage
### Setup
In your host system:

```shell
git clone https://github.com/DanielJomphe/asterisk-box
cd asterisk-box
vagrant up
vagrant reload # apply updated VirtualBox Guest Additions
vagrant ssh # terminal access to the guest box
```
In the guest box, run one of the following options (or pass in the arguments of your choice):

```shell
install-asterisk.sh certified-asterisk 11.2    # the latest certified 11.2-X LTS,   presently 11.2-cert1
install-asterisk.sh certified-asterisk 1.8.15  # the latest certified 1.8.15-X LTS, presently 1.8.15-cert2
install-asterisk.sh asterisk 11                # the latest 11.X LTS,               presently 11.5.0
install-asterisk.sh asterisk 1.8               # the latest 1.8.X LTS,              presently 1.8.23.0

# at some point, it may ask for your country phone code (use `1` in North America)
```

Then:

```shell
configure-asterisk.sh # apply `conf/secret` files if you've put some there
```

###  Launch
In the guest box:

```shell
configure-asterisk.sh # when you want to apply updates from `conf/secret`
sudo asterisk -cvvv
```

## Limitations
At present time:

1. Only the following **configuration files** are automatically customized:
	* `extensions.conf`
	* `sip.conf`
2. Starting up Asterisk is a manual operation.

These limitations are **very** easy to remove. Just improve the `Vagrantfile` and `bootstrap/**` scripts.

## Alternatives
Some linux distributions make available Asterisk packages that might meet your needs.

The following discussion is centered not on this asterisk-box's sole needs, but on the general infrastructure automation practices I wish to put in place for my projects. I provide it here because it may affect this solution in the future.

* I would have **much** preferred to abstract the box as a [Docker](http://www.docker.io) container.
	* Quick tests showed that Asterisk's default installation procedure doesn't like 64-bit systems (and most probably being run in LXC).
* Other provisioning tools might be useful, like Pallet, Ansible, Chef, or Puppet. Ansible seems to be more data-driven than Chef and Puppet.
	* Many of these tools could be used in some combinations. I suspect the winning combination for most projects in the future will imply Docker somewhere.
* I would love to benefit from [Pallet](http://palletops.com/)'s superior programmatic infrastructure automation features.
	* Pallet could certainly be integrated as a Vagrant [provisioner](http://docs.vagrantup.com/v2/provisioning/index.html) but it may be interesting to skip Vagrant and drive VirtualBox using [Pallet's VMFest](https://github.com/pallet/pallet-vmfest).
	* I suspect Pallet may be at the nearest of the intersection of the power, simplicity and focus sets, although it's definitely not yet as easy on first approach as the other tools are. Thankfully, this is not unremediable.

## Maturity
EXPERIMENTAL.

USE AT YOUR OWN RISK.

In development. BARELY TESTED.

Subject to BREAKING CHANGES without any changelog, as v0.0.0 illustrates.

For now, there's no guarantee AT ALL that I'll ever maintain this project.

Use for your development needs.

DON'T deploy this to production.

## Contributing
At present time, maintain your own fork.

I might later open up to Wiki updates, Issues, and Pull Requests. Expect to have to sign a CA.

## License
Copyright © 2013 Daniel Jomphe.

Distributed under the Eclipse Public License, the same as Clojure.