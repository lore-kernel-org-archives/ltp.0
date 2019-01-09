From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed,  9 Jan 2019 15:57:40 +0300
Subject: [LTP] [PATCH] lib/tst_net.sh: fix tst_set_sysctl() for non-netns
	setup
Message-ID: <1547038660-14008-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When we don't use netns setup, $rparam is empty in tst_set_sysctl(),
and tst_net_run() mistakenly set sysctl command to $rparam. This results
to the following error, $cmd is empty:

  bbr01 1 TINFO: timeout per run is 0h 20m 0s
  bbr01 1 TINFO: emulate congestion with packet loss 0.5%
  bbr01 1 TINFO: compare 'cubic' and 'bbr' congestion alg. results
  bbr01 1 TINFO: setting cubic
  bbr01 1 TBROK: tst_net_run: command not defined

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/tst_net.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 209cf9b..eca616f 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -718,9 +718,9 @@ tst_set_sysctl()
 	[ "$3" = "safe" ] && safe="-s"
 
 	local rparam=
-	[ "$TST_USE_NETNS" = "yes" ] && rparam="-e"
+	[ "$TST_USE_NETNS" = "yes" ] && rparam="-r -e"
 
-	tst_net_run $safe -r $rparam "sysctl -q -w $name=$value"
+	tst_net_run $safe $rparam "sysctl -q -w $name=$value"
 }
 
 tst_cleanup_rhost()
-- 
1.7.1

