From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed,  8 Feb 2017 18:07:36 +0300
Subject: [LTP] [PATCH 1/3] test_net: add tst_icmp() which use
	ns-icmpv4|6-sender
Message-ID: <1486566458-18921-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index d3fbbf0..90dce0b 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -416,6 +416,48 @@ tst_ping()
 	return $ret
 }
 
+# tst_icmp -t TIMEOUT -s MESSAGE_SIZE_ARRAY OPTS
+# TIMEOUT: total time for the test in seconds
+# OPTS: additional options for ns-icmpv4|6-sender tool
+tst_icmp()
+{
+	local timeout=1
+	local msg_sizes=56
+	local opts=
+	local num=
+	local ret=0
+	local ver="${TST_IPV6:-4}"
+
+	OPTIND=0
+	while getopts :t:s: opt; do
+		case "$opt" in
+		t) timeout="$OPTARG" ;;
+		s) msg_sizes="$OPTARG" ;;
+		*) opts="-$OPTARG $opts" ;;
+		esac
+	done
+	OPTIND=0
+
+	local num=$(echo "$msg_sizes" | wc -w)
+	timeout="$(($timeout / $num))"
+	[ "$timeout" -eq 0 ] && timeout=1
+
+	opts="${opts}-I $(tst_iface) -S $(tst_ipaddr) -D $(tst_ipaddr rhost) "
+	opts="${opts}-M $(tst_hwaddr rhost) -t $timeout"
+
+	for size in $msg_sizes; do
+		ns-icmpv${ver}_sender -s $size $opts
+		ret=$?
+		if [ $ret -eq 0 ]; then
+			tst_resm TPASS "'ns-icmpv${ver}_sender -s $size $opts' pass"
+		else
+			tst_resm TFAIL "'ns-icmpv${ver}_sender -s $size $opts' fail"
+			break
+		fi
+	done
+	return $ret
+}
+
 # tst_set_sysctl NAME VALUE [safe]
 # It can handle netns case when sysctl not namespaceified.
 tst_set_sysctl()
-- 
1.7.1

