docker-baikal
======

A basic dockerised Baikal server for CardDAV and CalDAV sharing of
contacts and calendars.

This install supports a full install of Baikal with no email service
configured (deliberately). Once the service has been started and made
accessible, Baikal's own administration interface handles
authentication and permissions.

Deployment
------

Configure the domain for your server by changing the HOSTNAME variable
in the `Dockerfile`. This is the only configuration required outside
of the web interface.

To build and run the container, simply run `make`. To run an already
built instance and skip building, run `make run`.

This install deliberately avoids setting up HTTPS. The service that
this container runs exposes the service on port 8080 by default with
the assumption that it will be reverse proxied to by another
server with TLS configured. An example apache configuration is
provided in the `examples` directory.

Storage
-----

Volatile storage containing the admin configuration and the sqlite
database is mounted from the `/storage` directory. These files are
sensitive and should be protected appropriately.

Backup
-----
A very simple backup script suitable for dropping into
/etc/cron.weekly or similar can be found in `baikal-backup.cron`.
