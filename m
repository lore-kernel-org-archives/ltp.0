From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 12 Apr 2018 19:09:11 +0300
Subject: [LTP] [PATCH 1/2] lib/tst_net.sh: don't init ltp_ns if custom is
	used
Message-ID: <1523549352-1794-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We can define our own LTP_NETNS with custom setup, don't setup
the default one in that particular case.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/tst_net.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index bbef12a..53f6277 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -103,7 +103,7 @@ init_ltp_netspace()
 
 	local pid=
 
-	if [ ! -f /var/run/netns/ltp_ns ]; then
+	if [ ! -f /var/run/netns/ltp_ns -a -z "$LTP_NETNS" ]; then
 		ROD ip li add name ltp_ns_veth1 type veth peer name ltp_ns_veth2
 		pid="$(ROD ns_create net,mnt)"
 		mkdir -p /var/run/netns
@@ -112,6 +112,8 @@ init_ltp_netspace()
 		ROD ns_exec $pid net,mnt mount -t sysfs none /sys
 		ROD ns_ifmove ltp_ns_veth1 $pid
 		ROD ns_exec $pid net,mnt ip li set lo up
+	else
+		tst_res_ TINFO "using not default LTP netns: '$LTP_NETNS'"
 	fi
 
 	LHOST_IFACES="${LHOST_IFACES:-ltp_ns_veth2}"
-- 
1.7.1

