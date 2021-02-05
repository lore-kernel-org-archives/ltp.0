From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  5 Feb 2021 16:10:13 +0100
Subject: [LTP] [PATCH 2/4] net/multicast: Move API variables from setup to
 tests
In-Reply-To: <20210205151015.7465-1-pvorel@suse.cz>
References: <20210205151015.7465-1-pvorel@suse.cz>
Message-ID: <20210205151015.7465-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It's more readable to have variables in the test,
than mixing it in the test and in mcast-lib.sh.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../multicast/grp-operation/mcast-group-multiple-socket.sh    | 4 ++++
 .../stress/multicast/grp-operation/mcast-group-same-group.sh  | 4 ++++
 .../multicast/grp-operation/mcast-group-single-socket.sh      | 4 ++++
 .../multicast/grp-operation/mcast-group-source-filter.sh      | 4 ++++
 testcases/network/stress/multicast/grp-operation/mcast-lib.sh | 3 ---
 .../network/stress/multicast/packet-flood/mcast-pktfld01.sh   | 3 +++
 .../network/stress/multicast/packet-flood/mcast-pktfld02.sh   | 3 +++
 .../network/stress/multicast/query-flood/mcast-queryfld01.sh  | 2 ++
 .../network/stress/multicast/query-flood/mcast-queryfld02.sh  | 2 ++
 .../network/stress/multicast/query-flood/mcast-queryfld03.sh  | 2 ++
 .../network/stress/multicast/query-flood/mcast-queryfld04.sh  | 2 ++
 .../network/stress/multicast/query-flood/mcast-queryfld05.sh  | 2 ++
 .../network/stress/multicast/query-flood/mcast-queryfld06.sh  | 2 ++
 13 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/testcases/network/stress/multicast/grp-operation/mcast-group-multiple-socket.sh b/testcases/network/stress/multicast/grp-operation/mcast-group-multiple-socket.sh
index 2780a8d7c..e4cafc27d 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-group-multiple-socket.sh
+++ b/testcases/network/stress/multicast/grp-operation/mcast-group-multiple-socket.sh
@@ -19,7 +19,11 @@
 #
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
+TST_NEEDS_ROOT=1
+TST_NEEDS_TMPDIR=1
 TST_SETUP="do_setup"
+TST_CLEANUP="mcast_cleanup"
+TST_TESTFUNC="do_test"
 . mcast-lib.sh
 
 do_setup()
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-group-same-group.sh b/testcases/network/stress/multicast/grp-operation/mcast-group-same-group.sh
index 01fc95a1a..28c68c807 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-group-same-group.sh
+++ b/testcases/network/stress/multicast/grp-operation/mcast-group-same-group.sh
@@ -19,7 +19,11 @@
 #
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
+TST_NEEDS_ROOT=1
+TST_NEEDS_TMPDIR=1
 TST_SETUP="mcast_setup_normal"
+TST_CLEANUP="mcast_cleanup"
+TST_TESTFUNC="do_test"
 . mcast-lib.sh
 
 do_test()
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-group-single-socket.sh b/testcases/network/stress/multicast/grp-operation/mcast-group-single-socket.sh
index 6e26ff52d..780eaf13c 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-group-single-socket.sh
+++ b/testcases/network/stress/multicast/grp-operation/mcast-group-single-socket.sh
@@ -19,7 +19,11 @@
 #
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
+TST_NEEDS_ROOT=1
+TST_NEEDS_TMPDIR=1
 TST_SETUP="do_setup"
+TST_CLEANUP="mcast_cleanup"
+TST_TESTFUNC="do_test"
 . mcast-lib.sh
 
 do_setup()
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-group-source-filter.sh b/testcases/network/stress/multicast/grp-operation/mcast-group-source-filter.sh
index 65fff0f63..4c5a6e4c7 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-group-source-filter.sh
+++ b/testcases/network/stress/multicast/grp-operation/mcast-group-source-filter.sh
@@ -19,7 +19,11 @@
 #
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
+TST_NEEDS_ROOT=1
+TST_NEEDS_TMPDIR=1
 TST_SETUP="mcast_setup_normal"
+TST_CLEANUP="mcast_cleanup"
+TST_TESTFUNC="do_test"
 . mcast-lib.sh
 
 do_test()
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-lib.sh b/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
index 52a90ca50..851aadd5b 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
+++ b/testcases/network/stress/multicast/grp-operation/mcast-lib.sh
@@ -6,9 +6,6 @@
 #
 # Setup script for multicast stress tests.
 
-TST_CLEANUP="mcast_cleanup"
-TST_TESTFUNC="do_test"
-TST_NEEDS_TMPDIR=1
 . tst_net_stress.sh
 
 mcast_setup4()
diff --git a/testcases/network/stress/multicast/packet-flood/mcast-pktfld01.sh b/testcases/network/stress/multicast/packet-flood/mcast-pktfld01.sh
index 29798c84c..37af5d354 100755
--- a/testcases/network/stress/multicast/packet-flood/mcast-pktfld01.sh
+++ b/testcases/network/stress/multicast/packet-flood/mcast-pktfld01.sh
@@ -8,7 +8,10 @@
 # a single socket, then receiving a large number of UDP packets at the socket
 
 TST_NEEDS_ROOT=1
+TST_NEEDS_TMPDIR=1
 TST_SETUP="mcast_setup_normal"
+TST_CLEANUP="mcast_cleanup"
+TST_TESTFUNC="do_test"
 . mcast-lib.sh
 
 MCAST_LCMD="ns-mcast_receiver"
diff --git a/testcases/network/stress/multicast/packet-flood/mcast-pktfld02.sh b/testcases/network/stress/multicast/packet-flood/mcast-pktfld02.sh
index 2c356917a..330722124 100755
--- a/testcases/network/stress/multicast/packet-flood/mcast-pktfld02.sh
+++ b/testcases/network/stress/multicast/packet-flood/mcast-pktfld02.sh
@@ -9,7 +9,10 @@
 # packets at each socket
 
 TST_NEEDS_ROOT=1
+TST_NEEDS_TMPDIR=1
 TST_SETUP="mcast_setup_normal"
+TST_CLEANUP="mcast_cleanup"
+TST_TESTFUNC="do_test"
 . mcast-lib.sh
 
 MCAST_LCMD="ns-mcast_receiver"
diff --git a/testcases/network/stress/multicast/query-flood/mcast-queryfld01.sh b/testcases/network/stress/multicast/query-flood/mcast-queryfld01.sh
index d472a0c54..faa1c08ef 100755
--- a/testcases/network/stress/multicast/query-flood/mcast-queryfld01.sh
+++ b/testcases/network/stress/multicast/query-flood/mcast-queryfld01.sh
@@ -10,6 +10,8 @@
 TST_NEEDS_ROOT=1
 TST_NEEDS_TMPDIR=1
 TST_SETUP="mcast_setup_normal"
+TST_CLEANUP="mcast_cleanup"
+TST_TESTFUNC="do_test"
 . mcast-lib.sh
 
 do_test()
diff --git a/testcases/network/stress/multicast/query-flood/mcast-queryfld02.sh b/testcases/network/stress/multicast/query-flood/mcast-queryfld02.sh
index 199a8a016..66012a6f3 100755
--- a/testcases/network/stress/multicast/query-flood/mcast-queryfld02.sh
+++ b/testcases/network/stress/multicast/query-flood/mcast-queryfld02.sh
@@ -11,6 +11,8 @@
 TST_NEEDS_ROOT=1
 TST_NEEDS_TMPDIR=1
 TST_SETUP="mcast_setup_normal"
+TST_CLEANUP="mcast_cleanup"
+TST_TESTFUNC="do_test"
 . mcast-lib.sh
 
 do_test()
diff --git a/testcases/network/stress/multicast/query-flood/mcast-queryfld03.sh b/testcases/network/stress/multicast/query-flood/mcast-queryfld03.sh
index 2ea22605f..8ab9af544 100755
--- a/testcases/network/stress/multicast/query-flood/mcast-queryfld03.sh
+++ b/testcases/network/stress/multicast/query-flood/mcast-queryfld03.sh
@@ -11,6 +11,8 @@
 TST_NEEDS_ROOT=1
 TST_NEEDS_TMPDIR=1
 TST_SETUP="mcast_setup_normal"
+TST_CLEANUP="mcast_cleanup"
+TST_TESTFUNC="do_test"
 . mcast-lib.sh
 
 SRC_ADDR_IPV4="10.10.10.1"
diff --git a/testcases/network/stress/multicast/query-flood/mcast-queryfld04.sh b/testcases/network/stress/multicast/query-flood/mcast-queryfld04.sh
index dd341d7a3..5947562f1 100755
--- a/testcases/network/stress/multicast/query-flood/mcast-queryfld04.sh
+++ b/testcases/network/stress/multicast/query-flood/mcast-queryfld04.sh
@@ -10,6 +10,8 @@
 TST_NEEDS_ROOT=1
 TST_NEEDS_TMPDIR=1
 TST_SETUP="mcast_setup_normal"
+TST_CLEANUP="mcast_cleanup"
+TST_TESTFUNC="do_test"
 . mcast-lib.sh
 
 do_test()
diff --git a/testcases/network/stress/multicast/query-flood/mcast-queryfld05.sh b/testcases/network/stress/multicast/query-flood/mcast-queryfld05.sh
index c73fca460..3c064842f 100755
--- a/testcases/network/stress/multicast/query-flood/mcast-queryfld05.sh
+++ b/testcases/network/stress/multicast/query-flood/mcast-queryfld05.sh
@@ -11,6 +11,8 @@
 TST_NEEDS_ROOT=1
 TST_NEEDS_TMPDIR=1
 TST_SETUP="mcast_setup_normal"
+TST_CLEANUP="mcast_cleanup"
+TST_TESTFUNC="do_test"
 . mcast-lib.sh
 
 do_test()
diff --git a/testcases/network/stress/multicast/query-flood/mcast-queryfld06.sh b/testcases/network/stress/multicast/query-flood/mcast-queryfld06.sh
index ee7b5016f..bda064f7d 100755
--- a/testcases/network/stress/multicast/query-flood/mcast-queryfld06.sh
+++ b/testcases/network/stress/multicast/query-flood/mcast-queryfld06.sh
@@ -11,6 +11,8 @@
 TST_NEEDS_ROOT=1
 TST_NEEDS_TMPDIR=1
 TST_SETUP="mcast_setup_normal"
+TST_CLEANUP="mcast_cleanup"
+TST_TESTFUNC="do_test"
 . mcast-lib.sh
 
 SRC_ADDR_IPV4=10.10.10.1
-- 
2.30.0

