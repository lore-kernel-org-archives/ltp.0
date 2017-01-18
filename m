From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Jan 2017 15:00:56 +0100
Subject: [LTP] [PATCH v2 1/1] network/mc_cmds: fix testing with iproute2 <=
	ss161212
Message-ID: <20170118140056.15507-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Workaround for an upstream bug in ip:
https://bugzilla.kernel.org/show_bug.cgi?id=192741

+ add whitespace in log

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
* v1->v2: omit tail
---
 testcases/network/multicast/mc_cmds/mc_cmds | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/testcases/network/multicast/mc_cmds/mc_cmds b/testcases/network/multicast/mc_cmds/mc_cmds
index 62f9e9197..cc6a8e39d 100755
--- a/testcases/network/multicast/mc_cmds/mc_cmds
+++ b/testcases/network/multicast/mc_cmds/mc_cmds
@@ -50,12 +50,16 @@ do_test()
 	ip addr show $(tst_iface) | grep -q 'MULTICAST' || \
 		tst_brkm TFAIL "Multicast not listed for $(tst_iface)"
 
-	ip maddr show $(tst_iface) | grep -q '224.0.0.1' || \
-		tst_brkm TFAIL "all-host-group for $(tst_iface) not joined"
+	ip maddr show $(tst_iface) | grep -q '224.0.0.1'
+	if [ $? -ne 0 ]; then
+		tst_resm TINFO "ip failed to detect multicast, parsing /proc/net/igmp"
+		grep "$(tst_iface)\s*:" -A 1 /proc/net/igmp | grep -q '\s010000E0\s' || \
+			tst_brkm TFAIL "all-host-group for $(tst_iface) not joined"
+	fi
 
 	# Do the ping tests: Execute ping 224.0.0.1 - Verify that the proper
 	# number of responses are returned.
-	tst_resm TINFO "Ping all-host-groups address(over default route!)"
+	tst_resm TINFO "Ping all-host-groups address (over default route!)"
 	ping -c2 224.0.0.1 > ping_out.log || \
 		tst_brkm TFAIL "No response from MC hosts to ping 224.0.0.1"
 
-- 
2.11.0

