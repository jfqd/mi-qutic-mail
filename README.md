# mi-qutic-mail

use [jfqd/mi-qutic.base](https://github.com/jfqd/mi-qutic-base) to create a provisionable image

## description

A qutic base mailserver-image.

## mdata variables

See [mi-qutic-base Readme](https://github.com/jfqd/mi-qutic-base/blob/master/README.md) for a list of usable metadata.

## installation

The following sample can be used to create a zone running a copy of the the mailserver image.

```
IMAGE_UUID=$(imgadm list | grep 'qutic-mail' | tail -1 | awk '{ print $1 }')
vmadm create << EOF
{
  "brand":      "joyent",
  "image_uuid": "$IMAGE_UUID",
  "alias":      "mx1",
  "hostname":   "mx1.example.com",
  "dns_domain": "example.com",
  "resolvers": [
    "80.80.80.80",
    "80.80.81.81"
  ],
  "nics": [
    {
      "interface": "net0",
      "nic_tag":   "admin",
      "ip":        "10.10.10.10",
      "gateway":   "10.10.10.1",
      "netmask":   "255.255.255.0"
    },
    {
      "interface": "net1",
      "nic_tag":   "external",
      "ip":        "20.10.10.10",
      "gateway":   "20.10.10.1",
      "netmask":   "255.255.255.0",
      "primary":   true
    }
  ],
  "max_physical_memory": 4096,
  "quota":                 20,
  "cpu_cap":              200,
  "customer_metadata": {
    "logstash_redis":        "redis://10.10.10.10:6379/0,redis://10.10.10.11:6379/0",
    "vfstab":                "storage.example.com:/export/data    -       /var/mail    nfs     -       yes     rw,bg,intr"
  }
}
EOF
```

The main configuration of all components is done via ansible and not part of this project!
You should adjust at least the following config files to your needs:

* amavisd.conf
* clamd.conf
* cluebringer.conf
* dovecot.conf
* freshclam.conf
* fail2ban/jail.local
* postfix/main.cf
* postfix/master.cf
* spamassassin/local.cf

## TODO

* Add [PostTLS](https://github.com/suenkler/PostTLS) as an option
* Add [clamav-unofficial-sigs](https://github.com/extremeshok/clamav-unofficial-sigs) as an option

## Read on

* [Outbound DANE in 15 Minuten einrichten](https://blog.sys4.de/outbound-dane-mit-postfix-de.html) (German only)
