From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 10 Nov 2016 15:05:37 +0100
Subject: [LTP] [PATCH 1/1] network: mc_cmds: fix error message
Message-ID: <20161110140537.7339-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/multicast/mc_cmds/mc_cmds | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/multicast/mc_cmds/mc_cmds b/testcases/network/multicast/mc_cmds/mc_cmds
index 4848ab6..62f9e91 100755
--- a/testcases/network/multicast/mc_cmds/mc_cmds
+++ b/testcases/network/multicast/mc_cmds/mc_cmds
@@ -51,7 +51,7 @@ do_test()
 		tst_brkm TFAIL "Multicast not listed for $(tst_iface)"
 
 	ip maddr show $(tst_iface) | grep -q '224.0.0.1' || \
-		tst_brkm TFAIL "all-host-group for $IFNAME not joined"
+		tst_brkm TFAIL "all-host-group for $(tst_iface) not joined"
 
 	# Do the ping tests: Execute ping 224.0.0.1 - Verify that the proper
 	# number of responses are returned.
-- 
2.10.2

