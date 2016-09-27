From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 27 Sep 2016 13:06:42 +0300
Subject: [LTP] [PATCH 2/3] network: update tests with new name: tcp_fastopen
	-> netstress
In-Reply-To: <1474970803-24241-1-git-send-email-alexey.kodanev@oracle.com>
References: <1474970803-24241-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1474970803-24241-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/busy_poll/busy_poll01.sh         |    2 +-
 testcases/network/busy_poll/busy_poll02.sh         |    2 +-
 testcases/network/busy_poll/busy_poll03.sh         |    2 +-
 testcases/network/stress/interface/if-addr-adddel  |    2 +-
 .../network/stress/interface/if-addr-addlarge      |    2 +-
 testcases/network/stress/interface/if-lib.sh       |    8 ++++----
 testcases/network/stress/interface/if-mtu-change   |    2 +-
 testcases/network/stress/interface/if-route-adddel |    2 +-
 .../network/stress/interface/if-route-addlarge     |    2 +-
 testcases/network/stress/ssh/ssh-stress            |    4 ++--
 testcases/network/stress/ssh/ssh-stress03-rmt      |    2 +-
 testcases/network/tcp_fastopen/tcp_fastopen_run.sh |    8 ++++----
 testcases/network/virt/gre01.sh                    |    8 ++++----
 testcases/network/virt/virt_lib.sh                 |    2 +-
 testcases/network/virt/vlan03.sh                   |    8 ++++----
 testcases/network/virt/vxlan03.sh                  |    8 ++++----
 16 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/testcases/network/busy_poll/busy_poll01.sh b/testcases/network/busy_poll/busy_poll01.sh
index 2d48339..8faa569 100755
--- a/testcases/network/busy_poll/busy_poll01.sh
+++ b/testcases/network/busy_poll/busy_poll01.sh
@@ -31,7 +31,7 @@ max_requests=500000
 
 cleanup()
 {
-	tst_rhost_run -c "pkill -9 tcp_fastopen\$"
+	tst_rhost_run -c "pkill -9 netstress\$"
 	tst_rmdir
 
 	sysctl -q -w net.core.busy_read=$busy_read_old
diff --git a/testcases/network/busy_poll/busy_poll02.sh b/testcases/network/busy_poll/busy_poll02.sh
index 40dff7e..cd69ed2 100755
--- a/testcases/network/busy_poll/busy_poll02.sh
+++ b/testcases/network/busy_poll/busy_poll02.sh
@@ -31,7 +31,7 @@ max_requests=500000
 
 cleanup()
 {
-	tst_rhost_run -c "pkill -9 tcp_fastopen\$"
+	tst_rhost_run -c "pkill -9 netstress\$"
 	tst_rmdir
 
 	sysctl -q -w net.core.busy_poll=$busy_poll_old
diff --git a/testcases/network/busy_poll/busy_poll03.sh b/testcases/network/busy_poll/busy_poll03.sh
index 6102e98..7e405ee 100755
--- a/testcases/network/busy_poll/busy_poll03.sh
+++ b/testcases/network/busy_poll/busy_poll03.sh
@@ -25,7 +25,7 @@ TCID="busy_poll03"
 
 cleanup()
 {
-	tst_rhost_run -c "pkill -9 tcp_fastopen\$"
+	tst_rhost_run -c "pkill -9 netstress\$"
 	tst_rmdir
 
 	sysctl -q -w net.core.busy_poll=$busy_poll_old
diff --git a/testcases/network/stress/interface/if-addr-adddel b/testcases/network/stress/interface/if-addr-adddel
index 5a88b2f..0a069ef 100644
--- a/testcases/network/stress/interface/if-addr-adddel
+++ b/testcases/network/stress/interface/if-addr-adddel
@@ -83,7 +83,7 @@ test_body()
 		cnt=$(($cnt + 1))
 
 		# Check the background TCP traffic
-		pgrep -x tcp_fastopen > /dev/null || make_background_tcp_traffic
+		pgrep -x netstress > /dev/null || make_background_tcp_traffic
 
 		case $cmd_type in
 		if_cmd)
diff --git a/testcases/network/stress/interface/if-addr-addlarge b/testcases/network/stress/interface/if-addr-addlarge
index f90be73..a6b841d 100644
--- a/testcases/network/stress/interface/if-addr-addlarge
+++ b/testcases/network/stress/interface/if-addr-addlarge
@@ -96,7 +96,7 @@ test_body()
 		check_connectivity $cnt || return
 
 		# Check the background TCP traffic
-		pgrep -x tcp_fastopen > /dev/null || make_background_tcp_traffic
+		pgrep -x netstress > /dev/null || make_background_tcp_traffic
 
 		case $cmd_type in
 		if_cmd)
diff --git a/testcases/network/stress/interface/if-lib.sh b/testcases/network/stress/interface/if-lib.sh
index 6d7bb0d..363c18d 100644
--- a/testcases/network/stress/interface/if-lib.sh
+++ b/testcases/network/stress/interface/if-lib.sh
@@ -35,16 +35,16 @@ setup()
 cleanup()
 {
 	# Stop the background TCP traffic
-	pkill -13 -x tcp_fastopen
-	tst_rhost_run -c "pkill -13 -x tcp_fastopen"
+	pkill -13 -x netstress
+	tst_rhost_run -c "pkill -13 -x netstress"
 	tst_restore_ipaddr
 }
 
 make_background_tcp_traffic()
 {
 	port=$(tst_get_unused_port ipv${ipver} stream)
-	tcp_fastopen -R 3 -g $port > /dev/null 2>&1 &
-	tst_rhost_run -b -c "tcp_fastopen -l -H $(tst_ipaddr) -g $port"
+	netstress -R 3 -g $port > /dev/null 2>&1 &
+	tst_rhost_run -b -c "netstress -l -H $(tst_ipaddr) -g $port"
 }
 
 check_connectivity()
diff --git a/testcases/network/stress/interface/if-mtu-change b/testcases/network/stress/interface/if-mtu-change
index 06411f5..6c6ac25 100644
--- a/testcases/network/stress/interface/if-mtu-change
+++ b/testcases/network/stress/interface/if-mtu-change
@@ -75,7 +75,7 @@ test_body()
 		check_connectivity $cnt || return
 
 		# Check the background TCP traffic
-		pgrep -x tcp_fastopen > /dev/null || make_background_tcp_traffic
+		pgrep -x netstress > /dev/null || make_background_tcp_traffic
 	done
 
 	tst_resm TINFO "check connectivity through $iface"
diff --git a/testcases/network/stress/interface/if-route-adddel b/testcases/network/stress/interface/if-route-adddel
index a9e999f..ac15b5e 100644
--- a/testcases/network/stress/interface/if-route-adddel
+++ b/testcases/network/stress/interface/if-route-adddel
@@ -79,7 +79,7 @@ test_body()
 		check_connectivity $cnt || return
 
 		# Check the background TCP traffic
-		pgrep -x tcp_fastopen > /dev/null || make_background_tcp_traffic
+		pgrep -x netstress > /dev/null || make_background_tcp_traffic
 
 		cnt=$(($cnt + 1))
 	done
diff --git a/testcases/network/stress/interface/if-route-addlarge b/testcases/network/stress/interface/if-route-addlarge
index 8f177f8..43a0599 100644
--- a/testcases/network/stress/interface/if-route-addlarge
+++ b/testcases/network/stress/interface/if-route-addlarge
@@ -87,7 +87,7 @@ test_body()
 		check_connectivity $cnt || return
 
 		# Check the background TCP traffic
-		pgrep -x tcp_fastopen > /dev/null || make_background_tcp_traffic
+		pgrep -x netstress > /dev/null || make_background_tcp_traffic
 
 		cnt=$(($cnt + 1))
 		y=$(($y + 1))
diff --git a/testcases/network/stress/ssh/ssh-stress b/testcases/network/stress/ssh/ssh-stress
index 7960627..3fdb5c2 100644
--- a/testcases/network/stress/ssh/ssh-stress
+++ b/testcases/network/stress/ssh/ssh-stress
@@ -34,7 +34,7 @@ cleanup()
 {
 	# Stop the ssh daemon
 	test -s sshd.pid && kill $(cat sshd.pid)
-	pkill 'tcp_fastopen$'
+	pkill 'netstress$'
 	tst_rmdir
 	[ "$rtmpdir" ] && tst_rhost_run -c "rm -rf $rtmpdir"
 	TMPDIR=
@@ -131,7 +131,7 @@ test03()
 	# Run a TCP traffic server
 	port=$(tst_get_unused_port ipv${ipver} stream)
 
-	tcp_fastopen -R 3 -g $port > tcp_server.log 2>&1 &
+	netstress -R 3 -g $port > tcp_server.log 2>&1 &
 
 	tst_rhost_run -s -c "ssh-stress03-rmt $ipver $(tst_ipaddr) \
 		$rconfig $port $NS_TIMES"
diff --git a/testcases/network/stress/ssh/ssh-stress03-rmt b/testcases/network/stress/ssh/ssh-stress03-rmt
index a5b7af0..44077ec 100644
--- a/testcases/network/stress/ssh/ssh-stress03-rmt
+++ b/testcases/network/stress/ssh/ssh-stress03-rmt
@@ -57,7 +57,7 @@ case $ip_ver in
 esac
 
 # Start the TCP traffic clients
-tcp_fastopen -r $requests -l -H $localhost -g $lport > /dev/null
+netstress -r $requests -l -H $localhost -g $lport > /dev/null
 ret=$?
 
 # Stop the ssh port forwarding
diff --git a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
index 45bc742..d9dc400 100755
--- a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
+++ b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
@@ -61,7 +61,7 @@ done
 cleanup()
 {
 	tst_resm TINFO "cleanup..."
-	tst_rhost_run -c "pkill -9 tcp_fastopen\$"
+	tst_rhost_run -c "pkill -9 netstress\$"
 	rm -f $tfo_result
 }
 
@@ -84,17 +84,17 @@ read_result_file()
 run_client_server()
 {
 	# kill tcp server on remote machine
-	tst_rhost_run -c "pkill -9 tcp_fastopen\$"
+	tst_rhost_run -c "pkill -9 netstress\$"
 
 	port=$(tst_rhost_run -c "tst_get_unused_port ipv6 stream")
 	[ $? -ne 0 ] && tst_brkm TBROK "failed to get unused port"
 
 	# run tcp server on remote machine
-	tst_rhost_run -s -b -c "tcp_fastopen -R $max_requests $1 -g $port"
+	tst_rhost_run -s -b -c "netstress -R $max_requests $1 -g $port"
 	sleep $bind_timeout
 
 	# run local tcp client
-	tcp_fastopen -a $clients_num -r $client_requests -l \
+	netstress -a $clients_num -r $client_requests -l \
 		-H $(tst_ipaddr rhost) $1 -g $port -d $tfo_result
 	[ "$?" -ne 0 ] && tst_brkm TBROK "Last test has failed"
 
diff --git a/testcases/network/virt/gre01.sh b/testcases/network/virt/gre01.sh
index f43d4e2..6aecbeb 100755
--- a/testcases/network/virt/gre01.sh
+++ b/testcases/network/virt/gre01.sh
@@ -18,7 +18,7 @@
 #
 # It requires remote host. Test will setup IPv4 and IPv6 virtual
 # tunnel between two hosts, then will compare TCP performance
-# with and without GRE using ping or tcp_fastopen test.
+# with and without GRE using ping or netstress test.
 
 TCID=gre01
 TST_TOTAL=1
@@ -35,14 +35,14 @@ cleanup()
 	cleanup_vifaces
 	tst_rhost_run -c "ip link delete ltp_v0 2>/dev/null"
 	if [ "$net_load" = "TFO" ]; then
-		tst_rhost_run -c "pkill -9 tcp_fastopen\$"
-		pkill -9 "tcp_fastopen\$"
+		tst_rhost_run -c "pkill -9 netstress\$"
+		pkill -9 "netstress\$"
 	fi
 }
 TST_CLEANUP="cleanup"
 
 if [ "$net_load" = "TFO" ]; then
-	tst_check_cmds "tcp_fastopen"
+	tst_check_cmds "netstress"
 fi
 
 if [ -z $ip_local -o -z $ip_remote ]; then
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 2246d0d..ee6488c 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -60,7 +60,7 @@ while getopts :hsx:i:r:c:R:p:n:l:t:d:6 opt; do
 		echo "R n      num of reqs, after which conn.closed in TCP perf"
 		echo "p x      x and x + 1 are ports in TCP perf"
 		echo "n x      virtual network 192.168.x"
-		echo "l x      network load: x is PING or TFO(tcp_fastopen)"
+		echo "l x      network load: x is PING or TFO(netstress)"
 		echo "t x      performance threshold, default is 60%"
 		echo "d x      VxLAN destination address, 'uni' or 'multi'"
 		echo "6        run over IPv6"
diff --git a/testcases/network/virt/vlan03.sh b/testcases/network/virt/vlan03.sh
index b0577ae..894d214 100755
--- a/testcases/network/virt/vlan03.sh
+++ b/testcases/network/virt/vlan03.sh
@@ -18,7 +18,7 @@
 #
 # Test-case 1: It requires remote host. Test will setup IPv4 and IPv6 virtual
 #              sub-nets between two hosts, then will compare TCP performance
-#              with and without VLAN using ping or tcp_fastopen test.
+#              with and without VLAN using ping or netstress test.
 #
 # Test-case 2: The same as above but must fail, because VLAN allows
 #              to communicate only within the same VLAN segment.
@@ -36,14 +36,14 @@ cleanup()
 	cleanup_vifaces
 	tst_rhost_run -c "ip link delete ltp_v0 2>/dev/null"
 	if [ "$net_load" = "TFO" ]; then
-		tst_rhost_run -c "pkill -9 tcp_fastopen\$"
-		pkill -9 "tcp_fastopen\$"
+		tst_rhost_run -c "pkill -9 netstress\$"
+		pkill -9 "netstress\$"
 	fi
 }
 TST_CLEANUP="cleanup"
 
 if [ "$net_load" = "TFO" ]; then
-	tst_check_cmds "tcp_fastopen"
+	tst_check_cmds "netstress"
 fi
 
 if [ -z $ip_local -o -z $ip_remote ]; then
diff --git a/testcases/network/virt/vxlan03.sh b/testcases/network/virt/vxlan03.sh
index 055dfee..191576e 100755
--- a/testcases/network/virt/vxlan03.sh
+++ b/testcases/network/virt/vxlan03.sh
@@ -18,7 +18,7 @@
 #
 # Test-case 1: It requires remote host. Test will setup IPv4 and IPv6 virtual
 #              sub-nets between two hosts, then will compare TCP performance
-#              with and without VxLAN using ping or tcp_fastopen test.
+#              with and without VxLAN using ping or netstress test.
 #
 # Test-case 2: The same as above but must fail, because VXLAN allows
 #              to communicate only within the same VXLAN segment.
@@ -47,14 +47,14 @@ cleanup()
 	cleanup_vifaces
 	tst_rhost_run -c "ip link delete ltp_v0 2>/dev/null"
 	if [ "$net_load" = "TFO" ]; then
-		tst_rhost_run -c "pkill -9 tcp_fastopen\$"
-		pkill -9 "tcp_fastopen\$"
+		tst_rhost_run -c "pkill -9 netstress\$"
+		pkill -9 "netstress\$"
 	fi
 }
 TST_CLEANUP="cleanup"
 
 if [ "$net_load" = "TFO" ]; then
-	tst_check_cmds "tcp_fastopen"
+	tst_check_cmds "netstress"
 fi
 
 if [ -z $ip_local -o -z $ip_remote ]; then
-- 
1.7.1

