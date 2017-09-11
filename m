From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 11 Sep 2017 17:11:04 +0200
Subject: [LTP] [PATCH 1/1] network/stress: Fix using undefined variables in
	interface tests
Message-ID: <20170911151104.30692-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a regression introduced in 364df04c8 ("network/stress: Add
library helper for stress testing")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
I'm sorry to introduce this bug.
---
 testcases/network/stress/interface/if-addr-adddel    | 4 ++--
 testcases/network/stress/interface/if-addr-addlarge  | 4 ++--
 testcases/network/stress/interface/if-mtu-change     | 4 ++--
 testcases/network/stress/interface/if-route-adddel   | 4 ++--
 testcases/network/stress/interface/if-route-addlarge | 4 ++--
 testcases/network/stress/interface/if-updown         | 4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/testcases/network/stress/interface/if-addr-adddel b/testcases/network/stress/interface/if-addr-adddel
index 3b1ab50bb..4a0501e09 100644
--- a/testcases/network/stress/interface/if-addr-adddel
+++ b/testcases/network/stress/interface/if-addr-adddel
@@ -21,11 +21,11 @@ TST_TOTAL=2
 
 TST_CLEANUP="netstress_cleanup"
 
+. test_net_stress.sh
+
 # The interval of the check interface activity
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
 
-. test_net_stress.sh
-
 test_body()
 {
 	local cmd_type=$1
diff --git a/testcases/network/stress/interface/if-addr-addlarge b/testcases/network/stress/interface/if-addr-addlarge
index c3cdb8fa9..a81cf6129 100644
--- a/testcases/network/stress/interface/if-addr-addlarge
+++ b/testcases/network/stress/interface/if-addr-addlarge
@@ -21,11 +21,11 @@ TST_TOTAL=2
 
 TST_CLEANUP="netstress_cleanup"
 
+. test_net_stress.sh
+
 # The interval of the check interface activity
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($IP_TOTAL / 20))}
 
-. test_net_stress.sh
-
 test_body()
 {
 	local cmd_type=$1
diff --git a/testcases/network/stress/interface/if-mtu-change b/testcases/network/stress/interface/if-mtu-change
index 3658f69ce..15293c4a9 100644
--- a/testcases/network/stress/interface/if-mtu-change
+++ b/testcases/network/stress/interface/if-mtu-change
@@ -21,11 +21,11 @@ TST_TOTAL=2
 
 TST_CLEANUP="do_cleanup"
 
+. test_net_stress.sh
+
 # The interval of the mtu change [second]
 CHANGE_INTERVAL=${CHANGE_INTERVAL:-5}
 
-. test_net_stress.sh
-
 # The array of the value which MTU is changed into sequentially
 # 552 - net.ipv4.route.min_pmtu
 CHANGE_VALUES="784 1142 552 1500 552 1500 552 748 552 1142 1500"
diff --git a/testcases/network/stress/interface/if-route-adddel b/testcases/network/stress/interface/if-route-adddel
index 64366fc52..8c1dfeee2 100644
--- a/testcases/network/stress/interface/if-route-adddel
+++ b/testcases/network/stress/interface/if-route-adddel
@@ -21,10 +21,10 @@ TST_TOTAL=2
 
 TST_CLEANUP="netstress_cleanup"
 
-CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
-
 . test_net_stress.sh
 
+CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
+
 test_body()
 {
 	local cmd_type=$1
diff --git a/testcases/network/stress/interface/if-route-addlarge b/testcases/network/stress/interface/if-route-addlarge
index b7e6952c2..eee0959c8 100644
--- a/testcases/network/stress/interface/if-route-addlarge
+++ b/testcases/network/stress/interface/if-route-addlarge
@@ -21,10 +21,10 @@ TST_TOTAL=2
 
 TST_CLEANUP="netstress_cleanup"
 
-CHECK_INTERVAL=${CHECK_INTERVAL:-$(($ROUTE_TOTAL / 20))}
-
 . test_net_stress.sh
 
+CHECK_INTERVAL=${CHECK_INTERVAL:-$(($ROUTE_TOTAL / 20))}
+
 test_body()
 {
 	local cmd_type=$1
diff --git a/testcases/network/stress/interface/if-updown b/testcases/network/stress/interface/if-updown
index 5ab54a1f8..264331adb 100644
--- a/testcases/network/stress/interface/if-updown
+++ b/testcases/network/stress/interface/if-updown
@@ -21,10 +21,10 @@ TST_TOTAL=2
 
 TST_CLEANUP="netstress_cleanup"
 
-CHECK_INTERVAL=${CHECK_INTERVAL:-$(($IF_UPDOWN_TIMES / 20))}
-
 . test_net_stress.sh
 
+CHECK_INTERVAL=${CHECK_INTERVAL:-$(($IF_UPDOWN_TIMES / 20))}
+
 test_body()
 {
 	local cmd_type=$1
-- 
2.14.1

