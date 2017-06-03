From: Petr Vorel <pvorel@suse.cz>
Date: Sat,  3 Jun 2017 14:00:15 +0200
Subject: [LTP] [RFC PATCH v6 04/11] network/stress: Use correct reporting
	function
In-Reply-To: <20170603120022.13415-1-pvorel@suse.cz>
References: <20170603120022.13415-1-pvorel@suse.cz>
Message-ID: <20170603120022.13415-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

as tst_info dosn't exist.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip01 | 2 +-
 testcases/network/stress/route/route4-rmmod                     | 2 +-
 testcases/network/stress/route/route6-rmmod                     | 2 +-
 testcases/network/stress/tcp/multi-diffip/tcp4-multi-diffip01   | 2 +-
 testcases/network/stress/udp/multi-diffip/udp4-multi-diffip01   | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip01 b/testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip01
index ad2da16b0..fe70f0041 100644
--- a/testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip01
+++ b/testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip01
@@ -177,7 +177,7 @@ while [ $ipaddr_pair_num -lt $IP_TOTAL_FOR_TCPIP ]; do
     x=`expr $ipaddr_pair_num \/ 255 % 255`
     y=`expr $ipaddr_pair_num % 255`
     if [ $x -ge 255 ]; then
-	tst_info TINFO "This script cannot add more than $ipaddr_pair_num addresses"
+	tst_resm TINFO "This script cannot add more than $ipaddr_pair_num addresses"
 	break
     fi
 
diff --git a/testcases/network/stress/route/route4-rmmod b/testcases/network/stress/route/route4-rmmod
index 11c9711ad..36c8c970d 100644
--- a/testcases/network/stress/route/route4-rmmod
+++ b/testcases/network/stress/route/route4-rmmod
@@ -121,7 +121,7 @@ do_setup()
     # Check the local host has ethtool utility
     which ethtool >/dev/null
     if [ $? -ne 0 ]; then
-	tst_info TBROK "This test case requires ethtool utility"
+	tst_resm TBROK "This test case requires ethtool utility"
 	exit $TST_TOTAL
     fi
 
diff --git a/testcases/network/stress/route/route6-rmmod b/testcases/network/stress/route/route6-rmmod
index 164cf2663..640cc065f 100644
--- a/testcases/network/stress/route/route6-rmmod
+++ b/testcases/network/stress/route/route6-rmmod
@@ -117,7 +117,7 @@ do_setup()
     # Check the local host has ethtool utility
     which ethtool >/dev/null
     if [ $? -ne 0 ]; then
-	tst_info TBROK "This test case requires ethtool utility"
+	tst_resm TBROK "This test case requires ethtool utility"
 	exit $TST_TOTAL
     fi
 
diff --git a/testcases/network/stress/tcp/multi-diffip/tcp4-multi-diffip01 b/testcases/network/stress/tcp/multi-diffip/tcp4-multi-diffip01
index 8b9652c9f..999597735 100644
--- a/testcases/network/stress/tcp/multi-diffip/tcp4-multi-diffip01
+++ b/testcases/network/stress/tcp/multi-diffip/tcp4-multi-diffip01
@@ -205,7 +205,7 @@ while [ $ipaddr_pair_num -lt $IP_TOTAL_FOR_TCPIP ]; do
     x=`expr $ipaddr_pair_num \/ 255 % 255`
     y=`expr $ipaddr_pair_num % 255`
     if [ $x -ge 255 ]; then
-	tst_info TINFO "This script cannot add more than $ipaddr_pair_num addresses"
+	tst_resm TINFO "This script cannot add more than $ipaddr_pair_num addresses"
 	break
     fi
 
diff --git a/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip01 b/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip01
index 33d226515..63783d16e 100644
--- a/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip01
+++ b/testcases/network/stress/udp/multi-diffip/udp4-multi-diffip01
@@ -171,7 +171,7 @@ while [ $ipaddr_pair_num -lt $IP_TOTAL_FOR_TCPIP ]; do
     x=`expr $ipaddr_pair_num \/ 255 % 255`
     y=`expr $ipaddr_pair_num % 255`
     if [ $x -ge 255 ]; then
-	tst_info TINFO "This script cannot add more than $ipaddr_pair_num addresses"
+	tst_resm TINFO "This script cannot add more than $ipaddr_pair_num addresses"
 	break
     fi
 
-- 
2.12.2

