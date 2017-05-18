From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 May 2017 16:36:56 +0200
Subject: [LTP] [PATCH 1/1] network/mc_cmds: Use TINFO when error is caused
	by old version of ip command
Message-ID: <20170518143656.2348-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/multicast/mc_cmds/mc_cmds | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/testcases/network/multicast/mc_cmds/mc_cmds b/testcases/network/multicast/mc_cmds/mc_cmds
index 8077b1f15..d798bdf0a 100755
--- a/testcases/network/multicast/mc_cmds/mc_cmds
+++ b/testcases/network/multicast/mc_cmds/mc_cmds
@@ -46,13 +46,19 @@ setup()
 
 do_test()
 {
+	local ip_fixed_version=170220
+
 	ip addr show $(tst_iface) | grep -q 'MULTICAST' || \
 		tst_brkm TFAIL "Multicast not listed for $(tst_iface)"
 
 	ip maddr show $(tst_iface) | grep -q '224.0.0.1'
 	if [ $? -ne 0 ]; then
-		tst_resm TWARN "'ip maddr show $(tst_iface)' failed," \
-			       " parsing 'ip maddr show'"
+		[ `ip -V | cut -d's' -f3` -lt $ip_fixed_version ] && \
+			tst_resm TINFO "'ip maddr show $(tst_iface)' failed "\
+					"(caused by old ip command version, fixed in"\
+					"$ip_fixed_version), parsing 'ip maddr show'" || \
+			tst_resm TWARN "'ip maddr show $(tst_iface)' failed,"\
+					"parsing 'ip maddr show'"
 		ip maddr show | sed -ne "/\s$(tst_iface)/,/^[0-9]/p" | \
 			grep -q 224.0.0.1 || \
 			tst_brkm TFAIL "$(tst_iface) not joined 224.0.0.1"
-- 
2.12.2

