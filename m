From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 29 May 2018 16:43:04 +0300
Subject: [LTP] [PATCH] network/virt: correctly set virt test options for
	vxlan and geneve
Message-ID: <1527601384-15981-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Define the options only for the tests that are really use them.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/virt/geneve01.sh |    2 ++
 testcases/network/virt/virt_lib.sh |    3 ---
 testcases/network/virt/vxlan01.sh  |    2 ++
 testcases/network/virt/vxlan02.sh  |    2 ++
 testcases/network/virt/vxlan03.sh  |    2 ++
 5 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/testcases/network/virt/geneve01.sh b/testcases/network/virt/geneve01.sh
index 0cc117f..1385604 100755
--- a/testcases/network/virt/geneve01.sh
+++ b/testcases/network/virt/geneve01.sh
@@ -19,6 +19,8 @@
 TCID=geneve01
 TST_TOTAL=1
 TST_NEEDS_TMPDIR=1
+TST_OPTS="hi:d:"
+TST_PARSE_ARGS=virt_lib_parse_args
 
 virt_type="geneve"
 start_id=16700000
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 00978a0..06c9950 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -48,9 +48,6 @@ virt_lib_parse_args()
 	esac
 }
 
-TST_OPTS="hi:d:"
-TST_PARSE_ARGS=virt_lib_parse_args
-
 TST_USE_LEGACY_API=1
 . tst_net.sh
 
diff --git a/testcases/network/virt/vxlan01.sh b/testcases/network/virt/vxlan01.sh
index 1a301e5..6195b00 100755
--- a/testcases/network/virt/vxlan01.sh
+++ b/testcases/network/virt/vxlan01.sh
@@ -21,6 +21,8 @@
 
 TCID=vxlan01
 TST_TOTAL=5
+TST_OPTS="hi:d:"
+TST_PARSE_ARGS=virt_lib_parse_args
 
 virt_type="vxlan"
 start_id=16700000
diff --git a/testcases/network/virt/vxlan02.sh b/testcases/network/virt/vxlan02.sh
index 66d48ba..a93e780 100755
--- a/testcases/network/virt/vxlan02.sh
+++ b/testcases/network/virt/vxlan02.sh
@@ -22,6 +22,8 @@
 
 TCID=vxlan02
 TST_TOTAL=1
+TST_OPTS="hi:d:"
+TST_PARSE_ARGS=virt_lib_parse_args
 
 virt_type="vxlan"
 start_id=16700000
diff --git a/testcases/network/virt/vxlan03.sh b/testcases/network/virt/vxlan03.sh
index 94eee71..37a172e 100755
--- a/testcases/network/virt/vxlan03.sh
+++ b/testcases/network/virt/vxlan03.sh
@@ -26,6 +26,8 @@
 TCID=vxlan03
 TST_TOTAL=4
 TST_NEEDS_TMPDIR=1
+TST_OPTS="hi:d:"
+TST_PARSE_ARGS=virt_lib_parse_args
 
 virt_type="vxlan"
 start_id=16700000
-- 
1.7.1

