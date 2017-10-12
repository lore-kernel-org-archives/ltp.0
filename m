From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 12 Oct 2017 15:40:41 +0300
Subject: [LTP] [PATCH 3/3] network/tst_netload: dump background netstress
	output on failure
In-Reply-To: <1507812041-2068-1-git-send-email-alexey.kodanev@oracle.com>
References: <1507812041-2068-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1507812041-2068-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fix the tests that invoke tst_netload. Add TST_NEEDS_TMPDIR flag
and remove tst_tmpdir usage.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh                          |   10 +++++++++-
 testcases/network/busy_poll/busy_poll01.sh         |    3 +--
 testcases/network/busy_poll/busy_poll02.sh         |    3 +--
 testcases/network/busy_poll/busy_poll03.sh         |    3 +--
 testcases/network/dccp/dccp01.sh                   |    2 +-
 testcases/network/dctcp/dctcp01.sh                 |    3 +--
 testcases/network/sctp/sctp01.sh                   |    2 +-
 testcases/network/stress/dccp/dccp_ipsec.sh        |    1 +
 testcases/network/stress/dccp/dccp_ipsec_vti.sh    |    1 +
 testcases/network/stress/ipsec/ipsec_lib.sh        |    2 ++
 testcases/network/stress/sctp/sctp_ipsec.sh        |    1 +
 testcases/network/stress/sctp/sctp_ipsec_vti.sh    |    1 +
 testcases/network/stress/tcp/tcp_ipsec.sh          |    1 +
 testcases/network/stress/tcp/tcp_ipsec_vti.sh      |    1 +
 testcases/network/stress/udp/udp_ipsec.sh          |    1 +
 testcases/network/stress/udp/udp_ipsec_vti.sh      |    1 +
 testcases/network/tcp_fastopen/tcp_fastopen_run.sh |    2 +-
 testcases/network/virt/geneve01.sh                 |    1 +
 testcases/network/virt/gre01.sh                    |    1 +
 testcases/network/virt/macsec01.sh                 |    1 +
 testcases/network/virt/macsec02.sh                 |    1 +
 testcases/network/virt/virt_lib.sh                 |    2 ++
 testcases/network/virt/vlan03.sh                   |    1 +
 testcases/network/virt/vxlan03.sh                  |    1 +
 24 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index cd67877..030dd9e 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -390,6 +390,11 @@ tst_wait_ipv6_dad()
 	done
 }
 
+tst_dump_rhost_cmd()
+{
+	tst_rhost_run -c "cat $TST_TMPDIR/bg.cmd"
+}
+
 # Run network load test, see 'netstress -h' for option description
 tst_netload()
 {
@@ -442,7 +447,7 @@ tst_netload()
 	s_opts="${cs_opts}${s_opts}-R $s_replies -g $port"
 
 	tst_resm TINFO "run server 'netstress $s_opts'"
-	tst_rhost_run -s -b -c "netstress $s_opts"
+	tst_rhost_run -s -B -c "netstress $s_opts"
 
 	tst_resm TINFO "check that server port in 'LISTEN' state"
 	local sec_waited=
@@ -457,6 +462,7 @@ tst_netload()
 	for sec_waited in $(seq 1 1200); do
 		tst_rhost_run -c "$sock_cmd" && break
 		if [ $sec_waited -eq 1200 ]; then
+			tst_dump_rhost_cmd
 			tst_rhost_run -c "ss -dutnp | grep $port"
 			tst_brkm TFAIL "server not in LISTEN state"
 		fi
@@ -468,12 +474,14 @@ tst_netload()
 	tst_rhost_run -c "pkill -9 netstress\$"
 
 	if [ "$expect_ret" -ne "$ret" ]; then
+		tst_dump_rhost_cmd
 		cat tst_netload.log
 		tst_brkm TFAIL "expected '$expect_res' but ret: '$ret'"
 	fi
 
 	if [ "$ret" -eq 0 ]; then
 		if [ ! -f $rfile ]; then
+			tst_dump_rhost_cmd
 			cat tst_netload.log
 			tst_brkm TFAIL "can't read $rfile"
 		fi
diff --git a/testcases/network/busy_poll/busy_poll01.sh b/testcases/network/busy_poll/busy_poll01.sh
index fb2bb52..3c30356 100755
--- a/testcases/network/busy_poll/busy_poll01.sh
+++ b/testcases/network/busy_poll/busy_poll01.sh
@@ -19,6 +19,7 @@
 
 TST_TOTAL=1
 TCID="busy_poll01"
+TST_NEEDS_TMPDIR=1
 
 . test_net.sh
 . busy_poll_lib.sh
@@ -44,8 +45,6 @@ set_busy_poll()
 	tst_rhost_run -s -c "sysctl -q -w net.core.busy_poll=$value"
 }
 
-tst_tmpdir
-
 busy_read_old="$(cat /proc/sys/net/core/busy_read)"
 busy_poll_old="$(cat /proc/sys/net/core/busy_poll)"
 
diff --git a/testcases/network/busy_poll/busy_poll02.sh b/testcases/network/busy_poll/busy_poll02.sh
index 7074334..4278579 100755
--- a/testcases/network/busy_poll/busy_poll02.sh
+++ b/testcases/network/busy_poll/busy_poll02.sh
@@ -19,6 +19,7 @@
 
 TST_TOTAL=1
 TCID="busy_poll02"
+TST_NEEDS_TMPDIR=1
 
 . test_net.sh
 . busy_poll_lib.sh
@@ -38,8 +39,6 @@ set_busy_poll()
 	tst_rhost_run -s -c "sysctl -q -w net.core.busy_poll=$value"
 }
 
-tst_tmpdir
-
 busy_poll_old="$(cat /proc/sys/net/core/busy_poll)"
 rbusy_poll_old=$(tst_rhost_run -c 'cat /proc/sys/net/core/busy_poll')
 
diff --git a/testcases/network/busy_poll/busy_poll03.sh b/testcases/network/busy_poll/busy_poll03.sh
index 628b1b4..80e0de3 100755
--- a/testcases/network/busy_poll/busy_poll03.sh
+++ b/testcases/network/busy_poll/busy_poll03.sh
@@ -19,6 +19,7 @@
 
 TST_TOTAL=1
 TCID="busy_poll03"
+TST_NEEDS_TMPDIR=1
 
 . test_net.sh
 . busy_poll_lib.sh
@@ -38,8 +39,6 @@ set_busy_poll()
 	tst_rhost_run -s -c "sysctl -q -w net.core.busy_poll=$value"
 }
 
-tst_tmpdir
-
 busy_poll_old="$(cat /proc/sys/net/core/busy_poll)"
 rbusy_poll_old=$(tst_rhost_run -c 'cat /proc/sys/net/core/busy_poll')
 
diff --git a/testcases/network/dccp/dccp01.sh b/testcases/network/dccp/dccp01.sh
index 2337d98..0475588 100755
--- a/testcases/network/dccp/dccp01.sh
+++ b/testcases/network/dccp/dccp01.sh
@@ -19,6 +19,7 @@
 TCID=dccp01
 TST_TOTAL=3
 TST_CLEANUP="cleanup"
+TST_NEEDS_TMPDIR=1
 
 . test_net.sh
 
@@ -30,7 +31,6 @@ cleanup()
 setup()
 {
 	tst_require_root
-	tst_tmpdir
 }
 
 test_run()
diff --git a/testcases/network/dctcp/dctcp01.sh b/testcases/network/dctcp/dctcp01.sh
index 7f98f9d..d8d4eb9 100755
--- a/testcases/network/dctcp/dctcp01.sh
+++ b/testcases/network/dctcp/dctcp01.sh
@@ -19,6 +19,7 @@
 TCID=dctcp01
 TST_TOTAL=1
 TST_CLEANUP="cleanup"
+TST_NEEDS_TMPDIR=1
 def_alg="cubic"
 prev_alg=
 
@@ -56,8 +57,6 @@ setup()
 		tst_brkm TCONF "netem doesn't support ECN"
 	fi
 
-	tst_tmpdir
-
 	prev_alg="$(sysctl -n net.ipv4.tcp_congestion_control)"
 }
 
diff --git a/testcases/network/sctp/sctp01.sh b/testcases/network/sctp/sctp01.sh
index 1d9bcb8..68a872a 100755
--- a/testcases/network/sctp/sctp01.sh
+++ b/testcases/network/sctp/sctp01.sh
@@ -19,6 +19,7 @@
 TCID=sctp01
 TST_TOTAL=3
 TST_CLEANUP="cleanup"
+TST_NEEDS_TMPDIR=1
 
 . test_net.sh
 
@@ -30,7 +31,6 @@ cleanup()
 setup()
 {
 	tst_require_root
-	tst_tmpdir
 }
 
 test_run()
diff --git a/testcases/network/stress/dccp/dccp_ipsec.sh b/testcases/network/stress/dccp/dccp_ipsec.sh
index db5a30e..6c39fa3 100755
--- a/testcases/network/stress/dccp/dccp_ipsec.sh
+++ b/testcases/network/stress/dccp/dccp_ipsec.sh
@@ -18,6 +18,7 @@
 
 TCID=dccp_ipsec
 TST_TOTAL=3
+TST_NEEDS_TMPDIR=1
 TST_CLEANUP="tst_ipsec_cleanup"
 
 . ipsec_lib.sh
diff --git a/testcases/network/stress/dccp/dccp_ipsec_vti.sh b/testcases/network/stress/dccp/dccp_ipsec_vti.sh
index 7c8da7b..878f88c 100755
--- a/testcases/network/stress/dccp/dccp_ipsec_vti.sh
+++ b/testcases/network/stress/dccp/dccp_ipsec_vti.sh
@@ -18,6 +18,7 @@
 
 TCID=dccp_ipsec_vti
 TST_TOTAL=3
+TST_NEEDS_TMPDIR=1
 TST_CLEANUP="tst_ipsec_cleanup"
 
 . ipsec_lib.sh
diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index e05edee..ca30d8d 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -119,6 +119,8 @@ tst_ipsec_cleanup()
 		ip li del $cleanup_vti 2>/dev/null
 		tst_rhost_run -c "ip li del $cleanup_vti 2>/dev/null"
 	fi
+
+	[ "$TST_NEEDS_TMPDIR" = 1 ] && tst_rmdir
 }
 
 ipsec_set_algoline()
diff --git a/testcases/network/stress/sctp/sctp_ipsec.sh b/testcases/network/stress/sctp/sctp_ipsec.sh
index bd4f349..0b60238 100755
--- a/testcases/network/stress/sctp/sctp_ipsec.sh
+++ b/testcases/network/stress/sctp/sctp_ipsec.sh
@@ -18,6 +18,7 @@
 
 TCID=sctp_ipsec
 TST_TOTAL=3
+TST_NEEDS_TMPDIR=1
 TST_CLEANUP="tst_ipsec_cleanup"
 
 . ipsec_lib.sh
diff --git a/testcases/network/stress/sctp/sctp_ipsec_vti.sh b/testcases/network/stress/sctp/sctp_ipsec_vti.sh
index 6ac6e21..ddb4784 100755
--- a/testcases/network/stress/sctp/sctp_ipsec_vti.sh
+++ b/testcases/network/stress/sctp/sctp_ipsec_vti.sh
@@ -18,6 +18,7 @@
 
 TCID=sctp_ipsec_vti
 TST_TOTAL=3
+TST_NEEDS_TMPDIR=1
 TST_CLEANUP="tst_ipsec_cleanup"
 
 . ipsec_lib.sh
diff --git a/testcases/network/stress/tcp/tcp_ipsec.sh b/testcases/network/stress/tcp/tcp_ipsec.sh
index e75f672..aeb33d6 100755
--- a/testcases/network/stress/tcp/tcp_ipsec.sh
+++ b/testcases/network/stress/tcp/tcp_ipsec.sh
@@ -18,6 +18,7 @@
 
 TCID=tcp_ipsec
 TST_TOTAL=3
+TST_NEEDS_TMPDIR=1
 TST_CLEANUP="tst_ipsec_cleanup"
 
 max_requests=10
diff --git a/testcases/network/stress/tcp/tcp_ipsec_vti.sh b/testcases/network/stress/tcp/tcp_ipsec_vti.sh
index 4ed520b..a793ef6 100755
--- a/testcases/network/stress/tcp/tcp_ipsec_vti.sh
+++ b/testcases/network/stress/tcp/tcp_ipsec_vti.sh
@@ -18,6 +18,7 @@
 
 TCID=tcp_ipsec_vti
 TST_TOTAL=3
+TST_NEEDS_TMPDIR=1
 TST_CLEANUP="tst_ipsec_cleanup"
 
 max_requests=10
diff --git a/testcases/network/stress/udp/udp_ipsec.sh b/testcases/network/stress/udp/udp_ipsec.sh
index 2debaef..ef9c31e 100755
--- a/testcases/network/stress/udp/udp_ipsec.sh
+++ b/testcases/network/stress/udp/udp_ipsec.sh
@@ -18,6 +18,7 @@
 
 TCID=udp_ipsec
 TST_TOTAL=3
+TST_NEEDS_TMPDIR=1
 TST_CLEANUP="tst_ipsec_cleanup"
 
 . ipsec_lib.sh
diff --git a/testcases/network/stress/udp/udp_ipsec_vti.sh b/testcases/network/stress/udp/udp_ipsec_vti.sh
index 39bf94f..c6d76c1 100755
--- a/testcases/network/stress/udp/udp_ipsec_vti.sh
+++ b/testcases/network/stress/udp/udp_ipsec_vti.sh
@@ -18,6 +18,7 @@
 
 TCID=udp_ipsec_vti
 TST_TOTAL=3
+TST_NEEDS_TMPDIR=1
 TST_CLEANUP="tst_ipsec_cleanup"
 
 . ipsec_lib.sh
diff --git a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
index d0341cd..5ca8c56 100755
--- a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
+++ b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
@@ -27,6 +27,7 @@ max_requests=3
 
 TST_TOTAL=1
 TCID="tcp_fastopen"
+TST_NEEDS_TMPDIR=1
 
 . test_net.sh
 
@@ -71,7 +72,6 @@ fi
 
 trap "tst_brkm TBROK 'test interrupted'" INT
 TST_CLEANUP="cleanup"
-tst_tmpdir
 
 tst_resm TINFO "using old TCP API and set tcp_fastopen to '0'"
 tst_netload -H $(tst_ipaddr rhost) -a $clients_num -r $client_requests \
diff --git a/testcases/network/virt/geneve01.sh b/testcases/network/virt/geneve01.sh
index 658ef8d..18694f0 100755
--- a/testcases/network/virt/geneve01.sh
+++ b/testcases/network/virt/geneve01.sh
@@ -18,6 +18,7 @@
 
 TCID=geneve01
 TST_TOTAL=1
+TST_NEEDS_TMPDIR=1
 
 virt_type="geneve"
 start_id=16700000
diff --git a/testcases/network/virt/gre01.sh b/testcases/network/virt/gre01.sh
index fe36fd0..5fa7783 100755
--- a/testcases/network/virt/gre01.sh
+++ b/testcases/network/virt/gre01.sh
@@ -22,6 +22,7 @@
 
 TCID=gre01
 TST_TOTAL=1
+TST_NEEDS_TMPDIR=1
 
 . test_net.sh
 
diff --git a/testcases/network/virt/macsec01.sh b/testcases/network/virt/macsec01.sh
index 7ef1d96..02865b4 100755
--- a/testcases/network/virt/macsec01.sh
+++ b/testcases/network/virt/macsec01.sh
@@ -20,6 +20,7 @@
 
 TCID=macsec01
 TST_TOTAL=16
+TST_NEEDS_TMPDIR=1
 
 virt_type="macsec"
 VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-100}
diff --git a/testcases/network/virt/macsec02.sh b/testcases/network/virt/macsec02.sh
index 5034d6a..fe6cb68 100755
--- a/testcases/network/virt/macsec02.sh
+++ b/testcases/network/virt/macsec02.sh
@@ -20,6 +20,7 @@
 
 TCID=macsec02
 TST_TOTAL=16
+TST_NEEDS_TMPDIR=1
 
 virt_type="macsec"
 VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-100}
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 87f030a..b1342da 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -92,6 +92,8 @@ cleanup_vifaces()
 	for vx in $viface; do
 		ip link delete $vx
 	done
+
+	[ "$TST_NEEDS_TMPDIR" = 1 ] && tst_rmdir
 }
 
 virt_cleanup_rmt()
diff --git a/testcases/network/virt/vlan03.sh b/testcases/network/virt/vlan03.sh
index 4d6a257..51471a0 100755
--- a/testcases/network/virt/vlan03.sh
+++ b/testcases/network/virt/vlan03.sh
@@ -25,6 +25,7 @@
 
 TCID=vlan03
 TST_TOTAL=6
+TST_NEEDS_TMPDIR=1
 
 virt_type="vlan"
 
diff --git a/testcases/network/virt/vxlan03.sh b/testcases/network/virt/vxlan03.sh
index f9b44c9..d4583e2 100755
--- a/testcases/network/virt/vxlan03.sh
+++ b/testcases/network/virt/vxlan03.sh
@@ -25,6 +25,7 @@
 
 TCID=vxlan03
 TST_TOTAL=4
+TST_NEEDS_TMPDIR=1
 
 virt_type="vxlan"
 start_id=16700000
-- 
1.7.1

