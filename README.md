ldapSSHPubkeys
==============

Store and Retrieve user's SSH public keys in LDAP


Automation
----------
Dumping Puppet code here now. Format later.

      file {
      "/etc/ssh/ldap.conf":
	  ensure => link,
	  target => '/etc/ldap.conf';
      "/openssh-ldap":
	  ensure => directory,
	  mode	 => 0700;
      "/openssh-ldap/ssh-ldap-wrapper":
	  ensure => link,
	  target => "/usr/libexec/openssh/ssh-ldap-wrapper";
      }

Client Setup
------------
* for EL5, build/install newer OpenSSH RPM that supports remote key retrieval.
* for EL6, ensure openssh-ldap RPM is installed (included in the distro)

Include this in /etc/ssh/sshd_config:

      AuthorizedKeysCommand /openssh-ldap/ssh-ldap-wrapper

Note: 
The /openssh-ldap directory is necessary, because openssh refuses to traverse to /usr/libexec/openssh because /usr has more than 0700 permissions.  This is likely a bug and will almost certainly be addressed in a later release of openssh.

LDAP Server Setup
-----------------
* Add openssh-lpk-sun.schema to your LDAP Server's schema definitions
* Extend your users' schemas to include objectClass: ldapPublicKey
* add keys to your users' accounts (see ldap-sshkeyadd in my ldap-management-tools repo)

Note: This objectclass is intentionally *not* self service to avoid someone compromising an account and maliciously pushing a bogus key. I also restrict users to a single key to support key deactivation in the event of key loss.  The schema, however, does permit multiple keys on accounts.
