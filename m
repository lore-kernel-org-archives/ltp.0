From: Hangbin Liu <haliu@redhat.com>
Date: Mon,  7 Mar 2016 15:14:41 +0800
Subject: [LTP] [PATCH 1/3] lib/test_net.sh: add tst_ping() to check icmp
	connectivity
In-Reply-To: <1457334883-11086-1-git-send-email-haliu@redhat.com>
References: <1457334883-11086-1-git-send-email-haliu@redhat.com>
Message-ID: <1457334883-11086-2-git-send-email-haliu@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Hangbin Liu <haliu@redhat.com>
---
 testcases/lib/test_net.sh | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 418fed3..f75e78e 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -314,3 +314,40 @@ tst_netload()
 
 	return $ret
 }
+
+# tst_ping IFACE ADDR [SIZE]
+# Check icmp connectivity
+# IFACE: source interface name
+# ADDR: destination IPv4 or IPv6 address
+# SIZE: message size
+tst_ping()
+{
+	# The max number of ICMP echo request
+	PING_MAX=${PING_MAX:-"10"}
+
+	# Check the arguments
+	if [ $# -lt 2 ]; then
+		tst_resm TBROK "tst_ping src_iface dest_ipv4/6_addr [msg_size]"
+		return 1
+	fi
+
+	local src_iface=$1
+	local dst_addr=$2
+	# ping cmd use 56 as default message size
+	local msg_size=${3:-"56"}
+
+	if echo $dst_addr | grep ":"; then
+		local PING="ping6"
+		TST_IPV6=6
+	else
+		local PING="ping"
+	fi
+
+	if [ "$dst_addr" == "$(tst_ipaddr)" ]; then
+		tst_rhost_run -c "$PING -I $src_iface -c $PING_MAX $dst_addr \
+			-s $msg_size > /dev/null 2>&1"
+	else
+		$PING -I $src_iface -c $PING_MAX $dst_addr -s $msg_size > \
+			/dev/null 2>&1
+	fi
+}
-- 
2.5.0

