From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 16 Jun 2017 03:56:52 +0200
Subject: [LTP] [RFC PATCH v6 2/2] network/dhcp: Fix netns after removing
	kernel module
In-Reply-To: <20170616015652.11169-1-pvorel@suse.cz>
References: <20170616015652.11169-1-pvorel@suse.cz>
Message-ID: <20170616015652.11169-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/dhcp/dhcp_lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/dhcp/dhcp_lib.sh b/testcases/network/dhcp/dhcp_lib.sh
index 85f9b88bf..eb502efbd 100755
--- a/testcases/network/dhcp/dhcp_lib.sh
+++ b/testcases/network/dhcp/dhcp_lib.sh
@@ -82,7 +82,7 @@ cleanup()
 	[ $veth_added ] && ip li del $iface0
 
 	if [ -z $veth_loaded ]; then
-		lsmod | grep -q '^veth ' && rmmod veth
+		lsmod | grep -q '^veth ' && { rmmod veth; reset_ltp_netspace; }
 	fi
 
 	tst_rmdir
-- 
2.12.2

