From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  6 Oct 2016 16:48:59 +0300
Subject: [LTP] [PATCH] network/busy_poll: TCONF if driver doesn't support
	busy-poll feature
Message-ID: <1475761739-14380-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/busy_poll/busy_poll01.sh |    3 +++
 testcases/network/busy_poll/busy_poll02.sh |    3 +++
 testcases/network/busy_poll/busy_poll03.sh |    3 +++
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/testcases/network/busy_poll/busy_poll01.sh b/testcases/network/busy_poll/busy_poll01.sh
index 8faa569..985c11d 100755
--- a/testcases/network/busy_poll/busy_poll01.sh
+++ b/testcases/network/busy_poll/busy_poll01.sh
@@ -52,6 +52,9 @@ if [ ! -f "/proc/sys/net/core/busy_read" -a \
 	tst_brkm TCONF "busy poll not configured, CONFIG_NET_RX_BUSY_POLL"
 fi
 
+ethtool --show-features $(tst_iface) | grep -q 'busy-poll.*on' || \
+	tst_brkm TCONF "busy poll not supported by driver"
+
 set_busy_poll()
 {
 	local value=${1:-"0"}
diff --git a/testcases/network/busy_poll/busy_poll02.sh b/testcases/network/busy_poll/busy_poll02.sh
index cd69ed2..28f476d 100755
--- a/testcases/network/busy_poll/busy_poll02.sh
+++ b/testcases/network/busy_poll/busy_poll02.sh
@@ -48,6 +48,9 @@ if [ ! -f "/proc/sys/net/core/busy_read" -a \
 	tst_brkm TCONF "busy poll not configured, CONFIG_NET_RX_BUSY_POLL"
 fi
 
+ethtool --show-features $(tst_iface) | grep -q 'busy-poll.*on' || \
+	tst_brkm TCONF "busy poll not supported by driver"
+
 set_busy_poll()
 {
 	local value=${1:-"0"}
diff --git a/testcases/network/busy_poll/busy_poll03.sh b/testcases/network/busy_poll/busy_poll03.sh
index 7e405ee..cc0e0db 100755
--- a/testcases/network/busy_poll/busy_poll03.sh
+++ b/testcases/network/busy_poll/busy_poll03.sh
@@ -42,6 +42,9 @@ if [ ! -f "/proc/sys/net/core/busy_read" -a \
 	tst_brkm TCONF "busy poll not configured, CONFIG_NET_RX_BUSY_POLL"
 fi
 
+ethtool --show-features $(tst_iface) | grep -q 'busy-poll.*on' || \
+	tst_brkm TCONF "busy poll not supported by driver"
+
 set_busy_poll()
 {
 	local value=${1:-"0"}
-- 
1.7.1

