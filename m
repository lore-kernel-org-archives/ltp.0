From: Hangbin Liu <haliu@redhat.com>
Date: Fri,  8 Apr 2016 18:12:47 +0800
Subject: [LTP] [PATCHv4 1/3] lib/test_net.sh: add tst_ping() to check icmp
	connectivity
In-Reply-To: <1460110369-30134-1-git-send-email-haliu@redhat.com>
References: <1460110369-30134-1-git-send-email-haliu@redhat.com>
Message-ID: <1460110369-30134-2-git-send-email-haliu@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Hangbin Liu <liuhangbin@gmail.com>

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 testcases/lib/test_net.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 418fed3..dd05f91 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -314,3 +314,34 @@ tst_netload()
 
 	return $ret
 }
+
+# tst_ping [IFACE] [SRC ADDR] [DST ADDR] [MESSAGE SIZE ARREY]
+# Check icmp connectivity
+# IFACE: source interface name
+# SRC ADDR: source IPv4 or IPv6 address
+# DST ADDR: destination IPv4 or IPv6 address
+# MESSAGE SIZE ARREY: message size arrey
+tst_ping()
+{
+	# The max number of ICMP echo request
+	PING_MAX=${PING_MAX:-"10"}
+
+	local src_iface=${1:-"$(tst_iface)"}
+	local dst_addr=${2:-"$(tst_ipaddr rhost)"}
+	local msg_sizes=${@:3}
+	local ret=0
+
+	# ping cmd use 56 as default message size
+	for size in ${msg_sizes:-"56"}; do
+		ping$TST_IPV6 -I $src_iface -c $PING_MAX $dst_addr \
+			-s $size > /dev/null 2>&1
+		ret=$?
+		if [ $ret -eq 0 ]; then
+			tst_resm TINFO "tst_ping IPv${TST_IPV6:-4} msg_size $size pass"
+		else
+			tst_resm TINFO "tst_ping IPv${TST_IPV6:-4} msg_size $size fail"
+			break
+		fi
+	done
+	return $ret
+}
-- 
2.5.0

