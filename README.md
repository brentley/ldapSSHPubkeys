ldapSSHPubkeys
==============

Store and Retrieve user's SSH public keys in LDAP

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

Include this in /etc/ssh/sshd_config:
      AuthorizedKeysCommand /openssh-ldap/ssh-ldap-wrapper

Note: The /openssh-ldap directory is necessary, because openssh refuses to traverse to /usr/libexec/openssh because /usr has more than 0700 permissions.  This is likely a bug and will almost certainly be addressed in a later release of openssh.
