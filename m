From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 17 Oct 2019 16:04:10 +0200
Subject: [LTP] [COMMITTED][PATCH] tst_net.sh: Don't require root when netns
 was setup externally
Message-ID: <20191017140410.6810-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ also don't require ip in that case.
+ remove unneeded '='

Fixes: e38d7c439 ("test_net.sh: Check for ip command")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 4be1bc0fc..2741d9bca 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -108,12 +108,12 @@ tst_require_root_()
 
 init_ltp_netspace()
 {
-	tst_test_cmds ip
-	tst_require_root_
-
-	local pid=
+	local pid
 
 	if [ ! -f /var/run/netns/ltp_ns -a -z "$LTP_NETNS" ]; then
+		tst_test_cmds ip
+		tst_require_root_
+
 		ROD ip li add name ltp_ns_veth1 type veth peer name ltp_ns_veth2
 		pid="$(ROD ns_create net,mnt)"
 		mkdir -p /var/run/netns
-- 
2.23.0

