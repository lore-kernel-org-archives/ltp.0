From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 21 Dec 2016 13:57:48 +0300
Subject: [LTP] [COMMITTED][PATCH] test_net.sh: bring loopback interface up
	in netns setup
Message-ID: <1482317868-11137-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is needed for SSH stress tests that setup port forwarding.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index f5321d7..9154c92 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -26,6 +26,7 @@ init_ltp_netspace()
 		ROD ip net add ltp_ns
 		ROD ip li add name ltp_ns_veth1 type veth peer name ltp_ns_veth2
 		ROD ip li set dev ltp_ns_veth1 netns ltp_ns
+		ROD ip netns exec ltp_ns ip li set lo up
 	fi
 
 	LHOST_IFACES=${LHOST_IFACES:-"ltp_ns_veth2"}
-- 
1.7.1

