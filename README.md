sufia
=====

Vagrant box with test Sufia installation

Installation
------------

Clone the repository into a directory.

Create a `config/secrets.yml` file containing:
```yaml
development:
  secret_key_base: SECRET-KEY
  ldap_host: ldaphost.myorganisation.org
  ldap_base: ou=People,dc=myorganisation,dc=org
```
and customise the `ldap_host` and `ldap_base` settings as required.

In the directory, run 

```bash
vagrant up
```

This will take quite a while to install the first time.

Once it has installed, use 

```bash
vagrant ssh
```

to log into the server, then:

```bash
cd /opt/sufia
rails server --binding=0.0.0.0
```

You should then be able to access Fedora and Solr at http://localhost:8983/ and Sufia at http://localhost:3000/ .

If, during the initial vagrant up, you see an error message about the users table already existing; or you get a 503 error when you access Sufia, try exiting rails then:
```bash
rake jetty:stop
rm db/development.sqlite3
rake db:migrate
rake jetty:start
```


Running on subsequent occasions
-------------------------------

On later runs, you will need to login with
```bash
vagrant ssh
```
then run
```bash
cd /opt/sufia
rake jetty:start
rails server --binding=0.0.0.0
```
(Note the additional rake step - this is done for you on the first deploy).
