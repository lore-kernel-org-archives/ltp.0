From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 14 Jun 2018 15:15:57 +0200
Subject: [LTP] [PATCH 2/3] net/icmp-uni-basic.sh: Remove LINK_NUM + related
	setup
In-Reply-To: <20180614131558.18707-1-pvorel@suse.cz>
References: <20180614131558.18707-1-pvorel@suse.cz>
Message-ID: <20180614131558.18707-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LINK_NUM should not be setup in the test + some variables weren't used.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
Properly remove $LINK_NUM
---
 testcases/network/stress/icmp/icmp-uni-basic.sh | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/testcases/network/stress/icmp/icmp-uni-basic.sh b/testcases/network/stress/icmp/icmp-uni-basic.sh
index 5fe6b9b13..fc84899dd 100755
--- a/testcases/network/stress/icmp/icmp-uni-basic.sh
+++ b/testcases/network/stress/icmp/icmp-uni-basic.sh
@@ -25,8 +25,6 @@ TST_CLEANUP="tst_ipsec_cleanup"
 
 . ipsec_lib.sh
 
-LINK_NUM=${LINK_NUM:-0}
-
 # Test description
 tst_resm TINFO "Sending ICMP messages with the following conditions"
 tst_resm TINFO "- Version of IP is IPv${TST_IPV6:-4}"
@@ -40,17 +38,10 @@ if [ -n "$IPSEC_MODE" -a -n "$IPSEC_PROTO" ]; then
 	esac
 fi
 
-# name of interface of the local/remote host
-lhost_ifname=$(tst_iface lhost $LINK_NUM)
-rhost_ifname=$(tst_iface rhost $LINK_NUM)
-
-lhost_addr=$(tst_ipaddr)
-rhost_addr=$(tst_ipaddr rhost)
-
 tst_ipsec_setup
 
 PING_MAX="$IPSEC_REQUESTS"
 
-tst_ping $lhost_ifname $rhost_addr $IPSEC_SIZE_ARRAY
+tst_ping $(tst_iface) $(tst_ipaddr rhost) $IPSEC_SIZE_ARRAY
 
 tst_exit
-- 
2.17.1

