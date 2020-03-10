{
    "schemaVersion": "1.0.0",
    "class": "Device",
    "async": true,
    "webhook": "https://maniak.io/myHook",
    "label": "my BIG-IP declaration for declarative onboarding",
    "Common": {
        "class": "Tenant",
        "hostname": "${HOSTNAME}",
        "myDns": {
            "class": "DNS",
            "nameServers": [
                "${DNS_ADDRESS}"
            ],
            "search": [
                "f5.com"
            ]
        },
        "myNtp": {
            "class": "NTP",
            "servers": [
                "${NTP_ADDRESS}"
            ],
            "timezone": "Singapore"
        },
        "guestUser": {
            "class": "User",
            "userType": "regular",
            "password": "${GUEST_PASSWORD}",
            "partitionAccess": {
                "Common": {
                    "role": "guest"
                }
            }
        },
        "myProvisioning": {
            "class": "Provision",
            "ltm": "nominal",
            "afm": "nominal",
            "asm": "nominal",
            "ilx": "nominal"
       },
        "external": {
            "class": "VLAN",
            "tag": 2,
            "mtu": 1500,
            "interfaces": [
                {
                    "name": "1.1",
                    "tagged": false
                }
            ],
            "cmpHash": "dst-ip"
        },
        "internal": {
            "class": "VLAN",
            "tag": 1,
            "mtu": 1500,
            "interfaces": [
                {
                    "name": "1.2",
                    "tagged": false
                }
            ],
            "cmpHash": "dst-ip"
        },
        "internal-self": {
            "class": "SelfIp",
            "address": "10.20.0.100/24",
            "vlan": "internal",
            "allowService": "none",
            "trafficGroup": "traffic-group-local-only"
        },
        "external-self": {
            "class": "SelfIp",
            "address": "10.10.0.100/24",
            "vlan": "external",
            "allowService": "none",
            "trafficGroup": "traffic-group-local-only"
        },
        "default": {
            "class": "Route",
            "gw": "10.10.0.1",
            "network": "default",
            "mtu": 1500
        },

        "LocalDCSyslog": {
            "class": "SyslogRemoteServer",
            "host": "local-ip",
            "localIp": "172.28.68.42",
            "remotePort": 514
          },
          "DRDCSyslog": {
            "class": "SyslogRemoteServer",
            "host": "dr-ip",
            "localIp": "172.28.68.42",
            "remotePort": 514
          },
        "httpdSettings": {
            "class": "HTTPD",
            "allow": [
                "192.168.1.0/24"
            ],
            "authPamIdleTimeout": 86400,
            "maxClients": 10,
            "sslCiphersuite": [
                "ECDHE-RSA-AES128-GCM-SHA256",
                "ECDHE-RSA-AES256-GCM-SHA384",
                "ECDHE-RSA-AES128-SHA",
                "ECDHE-RSA-AES256-SHA",
                "ECDHE-RSA-AES128-SHA256",
                "ECDHE-RSA-AES256-SHA384",
                "ECDHE-ECDSA-AES128-GCM-SHA256",
                "ECDHE-ECDSA-AES256-GCM-SHA384",
                "ECDHE-ECDSA-AES128-SHA",
                "ECDHE-ECDSA-AES256-SHA",
                "ECDHE-ECDSA-AES128-SHA256",
                "ECDHE-ECDSA-AES256-SHA384",
                "AES128-GCM-SHA256",
                "AES256-GCM-SHA384",
                "AES128-SHA",
                "AES256-SHA",
                "AES128-SHA256"
            ],
            "sslProtocol": "all -SSLv2 -SSLv3 -TLSv1"
        },
        "sshSettings": {
            "class": "SSHD",
            "banner": "Welcome to the F5... dont screw it up.. Banner to display",
            "inactivityTimeout": 123,
            "ciphers": [
                "aes128-ctr",
                "aes192-ctr",
                "aes256-ctr"
            ],
            "loginGraceTime": 100,
            "MACS": [
                "hmac-sha1",
                "hmac-ripemd160",
                "hmac-md5"
            ],
            "maxAuthTries": 10,
            "maxStartups": "5",
            "protocol": 1
        },
        "configsync": {
            "class": "ConfigSync",
            "configsyncIp": "/Common/external-self/address"
        },
        "failoverAddress": {
            "class": "FailoverUnicast",
            "address": "/Common/external-self/address"
        },
        "mySnmpAgent": {
            "class": "SnmpAgent",
            "contact": "Op Center <ops@example.com>",
            "location": "Seattle, WA",
            "allowList": [
                "10.30.100.0/23",
                "10.40.100.0/23",
                "10.8.100.0/32",
                "10.30.10.100",
                "10.30.10.200"
            ]
        },
        "snmpUser1": {
            "class": "SnmpUser",
            "authentication": {
                "protocol": "sha",
                "password": "pass1W0rd!"
            },
            "privacy": {
                "protocol": "aes",
                "password": "P@ssW0rd"
            },
            "oid": ".1",
            "access": "rw"
        },
        "public": {
            "class": "SnmpCommunity",
            "ipv6": false,
            "source": "all",
            "oid": ".1",
            "access": "ro"
        },
        "snmpCommunityWithSpecialChar": {
            "class": "SnmpCommunity",
            "name": "special!community",
            "ipv6": false,
            "source": "all",
            "oid": ".1",
            "access": "ro"
        },
        "myTraps": {
            "class": "SnmpTrapEvents",
            "agentStartStop": true,
            "authentication": true,
            "device": true
        },
        "myV2SnmpDestination": {
            "class": "SnmpTrapDestination",
            "version": "2c",
            "community": "my_snmp_community",
            "destination": "10.0.10.100",
            "port": 80,
            "network": "other"
        },
        "myV3SnmpDestination": {
            "class": "SnmpTrapDestination",
            "version": "3",
            "destination": "10.0.10.1",
            "port": 80,
            "network": "other",
            "securityName": "someSnmpUser",
            "authentication": {
                "protocol": "sha",
                "password": "P@ssW0rd"
            },
            "privacy": {
                "protocol": "aes",
                "password": "P@ssW0rd"
            },
            "engineId": "0x80001f8880c6b6067fdacfb558"
        }
    }
}