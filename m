From: Hangbin Liu <haliu@redhat.com>
Date: Thu, 17 Mar 2016 18:04:14 +0800
Subject: [LTP] [PATCHv3 1/3] lib/test_net.sh: add tst_ping() to check icmp
	connectivity
In-Reply-To: <1458209056-18829-1-git-send-email-haliu@redhat.com>
References: <1458209056-18829-1-git-send-email-haliu@redhat.com>
Message-ID: <1458209056-18829-2-git-send-email-haliu@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Hangbin Liu <haliu@redhat.com>
---
 testcases/lib/test_net.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 418fed3..da82ed9 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -314,3 +314,22 @@ tst_netload()
 
 	return $ret
 }
+
+# tst_ping [IFACE] [ADDR] [SIZE]
+# Check icmp connectivity
+# IFACE: source interface name
+# ADDR: destination IPv4 or IPv6 address
+# SIZE: message size
+tst_ping()
+{
+	# The max number of ICMP echo request
+	PING_MAX=${PING_MAX:-"10"}
+
+	local src_iface=${1:-"$(tst_iface)"}
+	local dst_addr=${2:-"$(tst_ipaddr rhost)"}
+	# ping cmd use 56 as default message size
+	local msg_size=${3:-"56"}
+
+	ping$TST_IPV6 -I $src_iface -c $PING_MAX $dst_addr -s $msg_size > \
+		/dev/null 2>&1
+}
-- 
2.5.0

