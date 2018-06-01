From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  1 Jun 2018 13:49:55 +0200
Subject: [LTP] [PATCH 6/7] net/ssh: Replace $ipver by $TST_IPVER from
	tst_net.sh
In-Reply-To: <20180601114956.17265-1-pvorel@suse.cz>
References: <20180601114956.17265-1-pvorel@suse.cz>
Message-ID: <20180601114956.17265-7-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

NOTE: remote tests still use $ip_ver, as IP version is passed to
them as $1.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/ssh/ssh-stress | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/testcases/network/stress/ssh/ssh-stress b/testcases/network/stress/ssh/ssh-stress
index 00b47c27f..afedaaa49 100644
--- a/testcases/network/stress/ssh/ssh-stress
+++ b/testcases/network/stress/ssh/ssh-stress
@@ -48,16 +48,14 @@ setup()
 	tst_require_root
 	tst_check_cmds pkill sshd ssh od
 
-	ipver=${TST_IPV6:-"4"}
-
 	# Get the sshd command with absolute path
 	SSHD=$(which sshd)
 	test "$SSHD" || tst_brkm TBROK "sshd daemon is not found"
 
-	check_icmpv${ipver}_connectivity $(tst_iface) $(tst_ipaddr rhost) || \
+	check_icmpv${TST_IPVER}_connectivity $(tst_iface) $(tst_ipaddr rhost) || \
 		tst_brkm TBROK "Failed to ping to $(tst_ipaddr rhost)"
 
-	port=$(tst_rhost_run -c "tst_get_unused_port ipv${ipver} stream")
+	port=$(tst_rhost_run -c "tst_get_unused_port ipv${TST_IPVER} stream")
 
 	tst_tmpdir
 
@@ -108,7 +106,7 @@ test01()
 {
 	tst_resm TINFO "Creating '$CONNECTION_TOTAL' ssh sessions"
 
-	tst_rhost_run -s -c "ssh-stress01-rmt $ipver $(tst_ipaddr) \
+	tst_rhost_run -s -c "ssh-stress01-rmt $TST_IPVER $(tst_ipaddr) \
 		$rconfig $CONNECTION_TOTAL"
 
 	tst_resm TPASS "Test is finished successfully"
@@ -119,7 +117,7 @@ test02()
 	tst_resm TINFO "Log in/out by many clients asynchronously"
 	tst_resm TINFO "'$CONNECTION_TOTAL' clients, time $NS_DURATION sec"
 
-	tst_rhost_run -s -c "ssh-stress02-rmt $ipver $(tst_ipaddr) \
+	tst_rhost_run -s -c "ssh-stress02-rmt $TST_IPVER $(tst_ipaddr) \
 		$rconfig $CONNECTION_TOTAL $NS_DURATION"
 
 	tst_resm TPASS "Test is finished successfully"
@@ -130,11 +128,11 @@ test03()
 	tst_resm TINFO "Forwarding TCP traffic with $NS_TIMES requests"
 
 	# Run a TCP traffic server
-	port=$(tst_get_unused_port ipv${ipver} stream)
+	port=$(tst_get_unused_port ipv${TST_IPVER} stream)
 
 	netstress -R 3 -g $port > tcp_server.log 2>&1 &
 
-	tst_rhost_run -s -c "ssh-stress03-rmt $ipver $(tst_ipaddr) \
+	tst_rhost_run -s -c "ssh-stress03-rmt $TST_IPVER $(tst_ipaddr) \
 		$rconfig $port $NS_TIMES"
 
 	tst_resm TPASS "Test is finished successfully"
-- 
2.16.3

