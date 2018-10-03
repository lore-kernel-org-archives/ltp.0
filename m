From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  3 Oct 2018 17:37:55 +0200
Subject: [LTP] [PATCH 4/5] net/dhcp: Pass lease file location to dhcpd via
	-lf
In-Reply-To: <20181003153756.3825-1-pvorel@suse.cz>
References: <20181003153756.3825-1-pvorel@suse.cz>
Message-ID: <20181003153756.3825-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

and create it with touch. This fixes error when lease file was missing
in default directory (/var/lib/dhcp/) or directory was not writable:

    dhcpd_tests 1 TINFO: starting DHCPv4 server on ltp_veth0
    dhcpd -4 ltp_veth0 > tst_dhcpd.err 2>&1
    Internet Systems Consortium DHCP Server 4.3.3
    Copyright 2004-2015 Internet Systems Consortium.
    All rights reserved.
    For info, please visit https://www.isc.org/software/dhcp/
    Not searching LDAP since ldap-server, ldap-port and ldap-base-dn were not specified in the config file
    Config file: /etc/dhcpd.conf
    Database file: /var/lib/dhcp/db/dhcpd.leases
    PID file: /var/run/dhcpd.pid
    Can't open lease database /var/lib/dhcp/db/dhcpd.leases: No such file or directory --
      check for failed database rewrite attempt!
    Please read the dhcpd.leases manual page if you
    don't know what to do about this.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/dhcp/dhcpd_tests.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/network/dhcp/dhcpd_tests.sh b/testcases/network/dhcp/dhcpd_tests.sh
index 0f53db66e..29d688551 100755
--- a/testcases/network/dhcp/dhcpd_tests.sh
+++ b/testcases/network/dhcp/dhcpd_tests.sh
@@ -29,7 +29,8 @@ setup_dhcpd_conf()
 
 start_dhcpd()
 {
-	dhcpd -$TST_IPVER $iface0 > tst_dhcpd.err 2>&1
+	touch tst_hdcpd.lease
+	dhcpd -lf tst_hdcpd.lease -$TST_IPVER $iface0 > tst_dhcpd.err 2>&1
 	if [ $? -ne 0 ]; then
 		cat tst_dhcpd.err
 		tst_brk TBROK "Failed to start dhcpd"
-- 
2.19.0

