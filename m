From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 25 Jan 2017 17:21:39 +0300
Subject: [LTP] [PATCH 1/2] test_net.sh: add tst_set_sysctl()
Message-ID: <1485354100-24769-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It can handle the case when sysctl is not namespaceified.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 37cc939..43a1d59 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -390,6 +390,27 @@ tst_ping()
 	return $ret
 }
 
+# tst_set_sysctl NAME VALUE [safe]
+# It can handle netns case when sysctl not namespaceified.
+tst_set_sysctl()
+{
+	local name="$1"
+	local value="$2"
+	local safe=
+	[ "$3" = "safe" ] && safe="-s" || safe=""
+
+	local add_opt=
+	[ "$TST_USE_NETNS" = "yes" ] && add_opt="-e"
+
+	if [ "$safe" ]; then
+		ROD sysctl -qw $name=$value
+	else
+		sysctl -qw $name=$value
+	fi
+
+	tst_rhost_run $safe -c "sysctl -qw $add_opt $name=$value"
+}
+
 # Management Link
 [ -z "$RHOST" ] && TST_USE_NETNS="yes"
 export RHOST="$RHOST"
-- 
1.7.1

