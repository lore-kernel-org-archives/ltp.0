From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 Dec 2018 02:02:18 +0100
Subject: [LTP] [PATCH v3 4/6] net/dhcp: Check also default dhclient lease
	file path
In-Reply-To: <20181218010220.2446-1-pvorel@suse.cz>
References: <20181218010220.2446-1-pvorel@suse.cz>
Message-ID: <20181218010220.2446-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

/var/lib/dhclient/dhclient{6,}.leases is used on
Fedora/RHEL/CentOS/Oracle Linux (since dhcp 4.0 in 2008)
Check also default upstream path for dhclient on Linux.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/dhcp/dhcp_lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/network/dhcp/dhcp_lib.sh b/testcases/network/dhcp/dhcp_lib.sh
index b8611f49d..632b1a9b1 100755
--- a/testcases/network/dhcp/dhcp_lib.sh
+++ b/testcases/network/dhcp/dhcp_lib.sh
@@ -59,6 +59,7 @@ dhcp_lib_setup()
 	stop_dhcp || tst_brk TBROK "Failed to stop dhcp server"
 
 	dhclient_lease="/var/lib/dhclient/dhclient${TST_IPV6}.leases"
+	[ -f $dhclient_lease ] || dhclient_lease="/var/lib/dhcp/dhclient${TST_IPV6}.leases"
 	if [ -f $dhclient_lease ]; then
 		tst_res TINFO "backup dhclient${TST_IPV6}.leases"
 		mv $dhclient_lease .
-- 
2.19.2

