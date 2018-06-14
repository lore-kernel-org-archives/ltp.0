From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 14 Jun 2018 19:04:57 +0300
Subject: [LTP] [PATCH 4/4] network/busy_poll: check that we changed sysctl
	knobs in cleanup
In-Reply-To: <1528992297-23920-1-git-send-email-alexey.kodanev@oracle.com>
References: <1528992297-23920-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1528992297-23920-4-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/busy_poll/busy_poll01.sh |   13 ++++++++-----
 testcases/network/busy_poll/busy_poll02.sh |    6 ++++--
 testcases/network/busy_poll/busy_poll03.sh |    6 ++++--
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/testcases/network/busy_poll/busy_poll01.sh b/testcases/network/busy_poll/busy_poll01.sh
index 1749e52..0023f6c 100755
--- a/testcases/network/busy_poll/busy_poll01.sh
+++ b/testcases/network/busy_poll/busy_poll01.sh
@@ -8,11 +8,14 @@
 
 cleanup()
 {
-	sysctl -q -w net.core.busy_read=$busy_read_old
-	sysctl -q -w net.core.busy_poll=$busy_poll_old
-
-	tst_rhost_run -c "sysctl -q -w net.core.busy_read=$rbusy_read_old"
-	tst_rhost_run -c "sysctl -q -w net.core.busy_poll=$rbusy_poll_old"
+	[ -n "$busy_read_old" ] && \
+		sysctl -q -w net.core.busy_read=$busy_read_old
+	[ -n "$busy_poll_old" ] && \
+		sysctl -q -w net.core.busy_poll=$busy_poll_old
+	[ -n "$rbusy_read_old" ] && \
+		tst_rhost_run -c "sysctl -q -w net.core.busy_read=$rbusy_read_old"
+	[ -n "$rbusy_poll_old" ] && \
+		tst_rhost_run -c "sysctl -q -w net.core.busy_poll=$rbusy_poll_old"
 }
 
 set_busy_poll()
diff --git a/testcases/network/busy_poll/busy_poll02.sh b/testcases/network/busy_poll/busy_poll02.sh
index d0083c2..1f25b73 100755
--- a/testcases/network/busy_poll/busy_poll02.sh
+++ b/testcases/network/busy_poll/busy_poll02.sh
@@ -8,8 +8,10 @@
 
 cleanup()
 {
-	sysctl -q -w net.core.busy_poll=$busy_poll_old
-	tst_rhost_run -c "sysctl -q -w net.core.busy_poll=$rbusy_poll_old"
+	[ -n "$busy_poll_old" ] && \
+		sysctl -q -w net.core.busy_poll=$busy_poll_old
+	[ -n "$rbusy_poll_old" ] && \
+		tst_rhost_run -c "sysctl -q -w net.core.busy_poll=$rbusy_poll_old"
 }
 
 set_busy_poll()
diff --git a/testcases/network/busy_poll/busy_poll03.sh b/testcases/network/busy_poll/busy_poll03.sh
index b55e220..3c70299 100755
--- a/testcases/network/busy_poll/busy_poll03.sh
+++ b/testcases/network/busy_poll/busy_poll03.sh
@@ -10,8 +10,10 @@ TST_TEST_DATA="udp udp_lite"
 
 cleanup()
 {
-	sysctl -q -w net.core.busy_poll=$busy_poll_old
-	tst_rhost_run -c "sysctl -q -w net.core.busy_poll=$rbusy_poll_old"
+	[ -n "$busy_poll_old" ] && \
+		sysctl -q -w net.core.busy_poll=$busy_poll_old
+	[ -n "$rbusy_poll_old" ] && \
+		tst_rhost_run -c "sysctl -q -w net.core.busy_poll=$rbusy_poll_old"
 }
 
 set_busy_poll()
-- 
1.7.1

