From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 31 May 2021 15:53:13 +0200
Subject: [LTP] [PATCH 1/2] network/busy_poll: Fix tests in namespaced env
Message-ID: <20210531135314.5067-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/network/busy_poll/busy_poll01.sh | 15 ++++++---------
 testcases/network/busy_poll/busy_poll02.sh |  7 +++----
 testcases/network/busy_poll/busy_poll03.sh |  7 +++----
 3 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/testcases/network/busy_poll/busy_poll01.sh b/testcases/network/busy_poll/busy_poll01.sh
index d306d1be8..0be4c5f96 100755
--- a/testcases/network/busy_poll/busy_poll01.sh
+++ b/testcases/network/busy_poll/busy_poll01.sh
@@ -21,22 +21,19 @@ cleanup()
 set_busy_poll()
 {
 	local value=${1:-"0"}
-	ROD_SILENT sysctl -q -w net.core.busy_read=$value
-	ROD_SILENT sysctl -q -w net.core.busy_poll=$value
-
-	tst_rhost_run -s -c "sysctl -q -w net.core.busy_read=$value"
-	tst_rhost_run -s -c "sysctl -q -w net.core.busy_poll=$value"
+	tst_set_sysctl net.core.busy_read $value safe
+	tst_set_sysctl net.core.busy_poll $value safe
 }
 
 setup()
 {
 	busy_poll_check_config
 
-	busy_read_old="$(cat /proc/sys/net/core/busy_read)"
-	busy_poll_old="$(cat /proc/sys/net/core/busy_poll)"
+	busy_read_old="$(sysctl -n net.core.busy_read)"
+	busy_poll_old="$(sysctl -n net.core.busy_poll)"
 
-	rbusy_read_old=$(tst_rhost_run -c 'cat /proc/sys/net/core/busy_read')
-	rbusy_poll_old=$(tst_rhost_run -c 'cat /proc/sys/net/core/busy_poll')
+	rbusy_read_old=$(tst_rhost_run -c 'sysctl -ne net.core.busy_read')
+	rbusy_poll_old=$(tst_rhost_run -c 'sysctl -ne net.core.busy_poll')
 }
 
 test()
diff --git a/testcases/network/busy_poll/busy_poll02.sh b/testcases/network/busy_poll/busy_poll02.sh
index d02aa7342..ec275bec9 100755
--- a/testcases/network/busy_poll/busy_poll02.sh
+++ b/testcases/network/busy_poll/busy_poll02.sh
@@ -17,16 +17,15 @@ cleanup()
 set_busy_poll()
 {
 	local value=${1:-"0"}
-	ROD_SILENT sysctl -q -w net.core.busy_poll=$value
-	tst_rhost_run -s -c "sysctl -q -w net.core.busy_poll=$value"
+	tst_set_sysctl net.core.busy_poll $value safe
 }
 
 setup()
 {
 	busy_poll_check_config
 
-	busy_poll_old="$(cat /proc/sys/net/core/busy_poll)"
-	rbusy_poll_old=$(tst_rhost_run -c 'cat /proc/sys/net/core/busy_poll')
+	busy_poll_old="$(sysctl -n net.core.busy_poll)"
+	rbusy_poll_old=$(tst_rhost_run -c 'sysctl -ne net.core.busy_poll')
 }
 
 test()
diff --git a/testcases/network/busy_poll/busy_poll03.sh b/testcases/network/busy_poll/busy_poll03.sh
index f6f1ac134..ccdb8308a 100755
--- a/testcases/network/busy_poll/busy_poll03.sh
+++ b/testcases/network/busy_poll/busy_poll03.sh
@@ -19,16 +19,15 @@ cleanup()
 set_busy_poll()
 {
 	local value=${1:-"0"}
-	ROD_SILENT sysctl -q -w net.core.busy_poll=$value
-	tst_rhost_run -s -c "sysctl -q -w net.core.busy_poll=$value"
+	tst_set_sysctl net.core.busy_poll $value safe
 }
 
 setup()
 {
 	busy_poll_check_config
 
-	busy_poll_old="$(cat /proc/sys/net/core/busy_poll)"
-	rbusy_poll_old=$(tst_rhost_run -c 'cat /proc/sys/net/core/busy_poll')
+	busy_poll_old="$(sysctl -n /proc/sys/net/core/busy_poll)"
+	rbusy_poll_old=$(tst_rhost_run -c 'sysctl -ne /proc/sys/net/core/busy_poll')
 }
 
 test()
-- 
2.31.1

