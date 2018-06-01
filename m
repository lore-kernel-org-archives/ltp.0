From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  1 Jun 2018 13:49:52 +0200
Subject: [LTP] [PATCH 3/7] net/dns: Replace $ipver by $TST_IPVER from
	tst_net.sh
In-Reply-To: <20180601114956.17265-1-pvorel@suse.cz>
References: <20180601114956.17265-1-pvorel@suse.cz>
Message-ID: <20180601114956.17265-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

NOTE: remote tests still use $ip_ver, as IP version is passed to
them as $1.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/dns/dns-stress | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/testcases/network/stress/dns/dns-stress b/testcases/network/stress/dns/dns-stress
index c0c397d4e..2c8d8a91f 100755
--- a/testcases/network/stress/dns/dns-stress
+++ b/testcases/network/stress/dns/dns-stress
@@ -45,8 +45,6 @@ common_setup()
 	tst_require_root
 	tst_check_cmds named dig
 
-	ipver=${TST_IPV6:-'4'}
-
 	if [ "$TST_IPV6" ]; then
 		record="AAAA"
 		net="fd00:cafe"
@@ -165,10 +163,10 @@ start_named()
 	chmod 770 .
 	chmod 660 ./*
 
-	port=$(tst_get_unused_port ipv${ipver} dgram)
+	port=$(tst_get_unused_port ipv${TST_IPVER} dgram)
 
 	tst_resm TINFO "Start named daemon, port $port"
-	named -$ipver -c named.conf -p $port || \
+	named -$TST_IPVER -c named.conf -p $port || \
 		tst_brkm TBROK "Failed to run named daemon"
 
 	# Make sure named.pid is created.
@@ -182,7 +180,7 @@ test01()
 {
 	tst_resm TINFO "Handling name lookup queries '$NS_TIMES' times"
 
-	tst_rhost_run -s -c "dns-stress01-rmt $ipver $(tst_ipaddr) $port \
+	tst_rhost_run -s -c "dns-stress01-rmt $TST_IPVER $(tst_ipaddr) $port \
 		$DOMAIN $MIN_ID $MAX_ID $NS_TIMES"
 
 	tst_resm TPASS "Test is finished successfully"
@@ -192,7 +190,7 @@ test02()
 {
 	tst_resm TINFO "Handling reverse lookup queries '$NS_TIMES' times"
 
-	tst_rhost_run -s -c "dns-stress02-rmt $ipver $(tst_ipaddr) $port $net \
+	tst_rhost_run -s -c "dns-stress02-rmt $TST_IPVER $(tst_ipaddr) $port $net \
 		$MIN_ID $MAX_ID $NS_TIMES"
 
 	tst_resm TPASS "Test is finished successfully"
@@ -200,7 +198,7 @@ test02()
 
 common_setup
 
-setup_$ipver
+setup_$TST_IPVER
 
 start_named
 
-- 
2.16.3

