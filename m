From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 30 Jan 2017 17:02:39 +0300
Subject: [LTP] [PATCH] tst_netload: new options and improvemnts
Message-ID: <1485784959-31864-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Add getopts parsing, make them transparent to 'netstress' tool

* cat 'netstress' output only on failure (not expected result)

* remove 'ping' type, ICMP traffic can be generated with tst_ping()

* tst_netload() sets TPASS/TFAIL flags depending on '-e' parameter --
  expected result.

* allow to overwrite most significant parameters with environment
  variables:
  'TST_NETLOAD_CLN_NUMBER' -- number of clients,
  'TST_NETLOAD_CLN_REQUESTS' -- client requests,
  'TST_NETLOAD_MAX_SRV_REPLIES' -- max server replies after which
  TCP connection will be closed.

Apply new usage in tests and virt_lib.sh. Change max_requests
parameter from 3 to 20 in virt_lib.sh. This will double the speed
of virt* tests but relative performance results should stay much
the same:

vxlan03 3 TINFO : run server 'netstress -R 3 -g 56792'
vxlan03 3 TINFO : check that server port in 'LISTEN' state
vxlan03 3 TINFO : run client 'netstress -l -H fd00:1:1:1::1 -a 2 -r 500000 -d res_ipv4 -g 56792'
vxlan03 3 TPASS : netstress passed, time spent '20049' ms
vxlan03 4 TINFO : time lan(20049) vxlan IPv4(33529) and IPv6(32828) ms
vxlan03 4 TINFO : IP4 vxlan over IP6 slower by 67 %
vxlan03 4 TINFO : IP6 vxlan over IP6 slower by 63 %

  vs:

vxlan03 3 TINFO : run server 'netstress -R 20 -g 20201'
vxlan03 3 TINFO : check that server port in 'LISTEN' state
vxlan03 3 TINFO : run client 'netstress -l -H fd00:1:1:1::1 -a 2 -r 500000 -d res_ipv4 -g 20201'
vxlan03 3 TPASS : netstress passed, time spent '9477' ms
vxlan03 4 TINFO : time lan(9477) vxlan IPv4(16811) and IPv6(16572) ms
vxlan03 4 TINFO : IP4 vxlan over IP6 slower by 77 %
vxlan03 4 TINFO : IP6 vxlan over IP6 slower by 74 %

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh                          |  132 ++++++++++++--------
 testcases/network/busy_poll/busy_poll01.sh         |   11 +--
 testcases/network/busy_poll/busy_poll02.sh         |   11 +--
 testcases/network/busy_poll/busy_poll03.sh         |    5 +-
 testcases/network/dctcp/dctcp01.sh                 |   18 +--
 testcases/network/tcp_fastopen/tcp_fastopen_run.sh |   26 ++---
 testcases/network/virt/geneve01.sh                 |    4 -
 testcases/network/virt/gre01.sh                    |    8 --
 testcases/network/virt/virt_lib.sh                 |   43 +++----
 testcases/network/virt/vlan03.sh                   |    8 --
 testcases/network/virt/vxlan03.sh                  |    8 --
 11 files changed, 110 insertions(+), 164 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 37cc939..dcb84ba 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -296,66 +296,88 @@ tst_wait_ipv6_dad()
 	done
 }
 
-# tst_netload ADDR [FILE] [TYPE] [OPTS]
-# Run network load test
-# ADDR: IP address
-# FILE: file with result time
-# TYPE: PING or TFO (TCP traffic)
-# OPTS: additional options
+# Run network load test, see 'netstress -h' for option description
 tst_netload()
 {
-	local ip_addr="$1"
-	local rfile="${2:-netload.res}"
-	local type="${3:-TFO}"
-	local addopts="${@:4}"
+	local rfile="tst_netload.res"
+	local expect_res="pass"
 	local ret=0
-	clients_num="${clients_num:-2}"
-	client_requests="${client_requests:-500000}"
-	max_requests="${max_requests:-3}"
-
-	case "$type" in
-	PING)
-		local ipv6=
-		echo "$ip_addr" | grep ":" > /dev/null
-		[ $? -eq 0 ] && ipv6=6
-		tst_resm TINFO "run ping${ipv6} test with rhost '$ip_addr'..."
-		local res=
-		res=$(ping${ipv6} -f -c $client_requests $ip_addr -w 600 2>&1)
-		[ $? -ne 0 ] && return 1
-		echo $res | sed -nE 's/.*time ([0-9]+)ms.*/\1/p' > $rfile
-	;;
-	TFO)
-		local port=
-		port="$(tst_rhost_run -c 'tst_get_unused_port ipv6 stream')"
-		[ $? -ne 0 ] && tst_brkm TBROK "failed to get unused port"
-
-		tst_resm TINFO "run netstress with '$ip_addr', port '$port'"
-		tst_rhost_run -s -b -c "netstress -R $max_requests \
-			-g $port $addopts"
-
-		# check that netstress on rhost in 'Listening' state
-		local sec_waited=
-		for sec_waited in $(seq 1 60); do
-			tst_rhost_run -c "ss -lutn | grep -q $port" && break
-			if [ $sec_waited -eq 60 ]; then
-				tst_resm TINFO "rhost not in LISTEN state"
-				return 1
-			fi
-			sleep 1
-		done
-
-		# run local tcp client
-		netstress -a $clients_num -r $client_requests -l -H $ip_addr\
-			 -g $port -d $rfile $addopts || ret=1
-
-		if [ $ret -eq 0 -a ! -f $rfile ]; then
-			tst_brkm TBROK "can't read $rfile"
+
+	# common options for client and server
+	local cs_opts=
+
+	local c_num="${TST_NETLOAD_CLN_NUMBER:-2}"
+	local c_requests="${TST_NETLOAD_CLN_REQUESTS:-500000}"
+	local c_opts=
+
+	# number of server replies after which TCP connection is closed
+	local s_replies="${TST_NETLOAD_MAX_SRV_REPLIES:-500000}"
+	local s_opts=
+
+	OPTIND=0
+	while getopts :a:H:d:n:N:r:R:b:t:Ufe: opt; do
+		case "$opt" in
+		a) c_num="$OPTARG" ;;
+		H) c_opts="${c_opts}-H $OPTARG " ;;
+		d) rfile="$OPTARG" ;;
+		n) c_opts="${c_opts}-n $OPTARG " ;;
+		N) c_opts="${c_opts}-N $OPTARG " ;;
+		r) c_requests="$OPTARG" ;;
+		R) s_replies="$OPTARG" ;;
+		b) cs_opts="${cs_opts}-b $OPTARG " ;;
+		t) cs_opts="${cs_opts}-t $OPTARG " ;;
+		U) cs_opts="${cs_opts}-U " ;;
+		f) cs_opts="${cs_opts}-f " ;;
+
+		e) expect_res="$OPTARG" ;;
+		*) tst_brkm TBROK "tst_netload: unknown option: $OPTARG" ;;
+		esac
+	done
+	OPTIND=0
+
+	local expect_ret=0
+	[ "$expect_res" != "pass" ] && expect_ret=1
+
+	local port="$(tst_rhost_run -c 'tst_get_unused_port ipv6 stream')"
+	[ $? -ne 0 ] && tst_brkm TBROK "failed to get unused port"
+
+	tst_rhost_run -c "pkill -9 netstress\$"
+
+	c_opts="${cs_opts}${c_opts}-a $c_num -r $c_requests -d $rfile -g $port"
+	s_opts="${cs_opts}${s_opts}-R $s_replies -g $port"
+
+	tst_resm TINFO "run server 'netstress $s_opts'"
+	tst_rhost_run -s -b -c "netstress $s_opts"
+
+	tst_resm TINFO "check that server port in 'LISTEN' state"
+	local sec_waited=
+	for sec_waited in $(seq 1 600); do
+		tst_rhost_run -c "ss -lutn | grep -q $port" && break
+		if [ $sec_waited -eq 600 ]; then
+			tst_rhost_run -c "ss -utnp | grep $port"
+			tst_brkm TFAIL "server not in LISTEN state"
 		fi
+		tst_sleep 100ms
+	done
+
+	tst_resm TINFO "run client 'netstress -l $c_opts'"
+	netstress -l $c_opts > tst_netload.log 2>&1 || ret=1
+	tst_rhost_run -c "pkill -9 netstress\$"
 
-		tst_rhost_run -c "pkill -9 netstress\$"
-	;;
-	*) tst_brkm TBROK "invalid net_load type '$type'" ;;
-	esac
+	if [ "$expect_ret" -ne "$ret" ]; then
+		cat tst_netload.log
+		tst_brkm TFAIL "expected '$expect_res' but ret: '$ret'"
+	fi
+
+	if [ "$ret" -eq 0 ]; then
+		if [ ! -f $rfile ]; then
+			cat tst_netload.log
+			tst_brkm TFAIL "can't read $rfile"
+		fi
+		tst_resm TPASS "netstress passed, time spent '$(cat $rfile)' ms"
+	else
+		tst_resm TPASS "netstress failed as expected"
+	fi
 
 	return $ret
 }
diff --git a/testcases/network/busy_poll/busy_poll01.sh b/testcases/network/busy_poll/busy_poll01.sh
index 73a900e..fb2bb52 100755
--- a/testcases/network/busy_poll/busy_poll01.sh
+++ b/testcases/network/busy_poll/busy_poll01.sh
@@ -20,18 +20,11 @@
 TST_TOTAL=1
 TCID="busy_poll01"
 
-# tst_netload() parameters
-clients_num=2
-client_requests=500000
-# num of requests after which TCP connection is closed
-max_requests=500000
-
 . test_net.sh
 . busy_poll_lib.sh
 
 cleanup()
 {
-	tst_rhost_run -c "pkill -9 netstress\$"
 	tst_rmdir
 
 	sysctl -q -w net.core.busy_read=$busy_read_old
@@ -65,9 +58,7 @@ trap "tst_brkm TBROK 'test interrupted'" INT
 for x in 50 0; do
 	tst_resm TINFO "set low latency busy poll to $x"
 	set_busy_poll $x
-	tst_netload $(tst_ipaddr rhost) res_$x TFO || \
-		tst_brkm TBROK "netload() failed"
-	tst_resm TINFO "time spent is '$(cat res_$x)' ms"
+	tst_netload -H $(tst_ipaddr rhost) -d res_$x
 done
 
 poll_cmp=$(( 100 - ($(cat res_50) * 100) / $(cat res_0) ))
diff --git a/testcases/network/busy_poll/busy_poll02.sh b/testcases/network/busy_poll/busy_poll02.sh
index 3fc731d..7074334 100755
--- a/testcases/network/busy_poll/busy_poll02.sh
+++ b/testcases/network/busy_poll/busy_poll02.sh
@@ -20,18 +20,11 @@
 TST_TOTAL=1
 TCID="busy_poll02"
 
-# tst_netload() parameters
-clients_num=2
-client_requests=500000
-# num of requests after which TCP connection is closed
-max_requests=500000
-
 . test_net.sh
 . busy_poll_lib.sh
 
 cleanup()
 {
-	tst_rhost_run -c "pkill -9 netstress\$"
 	tst_rmdir
 
 	sysctl -q -w net.core.busy_poll=$busy_poll_old
@@ -56,9 +49,7 @@ trap "tst_brkm TBROK 'test interrupted'" INT
 for x in 50 0; do
 	tst_resm TINFO "set low latency busy poll to $x per socket"
 	set_busy_poll $x
-	tst_netload $(tst_ipaddr rhost) res_$x TFO -b $x || \
-		tst_brkm TBROK "netload() failed"
-	tst_resm TINFO "time spent is '$(cat res_$x)' ms"
+	tst_netload -H $(tst_ipaddr rhost) -d res_$x -b $x
 done
 
 poll_cmp=$(( 100 - ($(cat res_50) * 100) / $(cat res_0) ))
diff --git a/testcases/network/busy_poll/busy_poll03.sh b/testcases/network/busy_poll/busy_poll03.sh
index 8414aee..4ab93dc 100755
--- a/testcases/network/busy_poll/busy_poll03.sh
+++ b/testcases/network/busy_poll/busy_poll03.sh
@@ -25,7 +25,6 @@ TCID="busy_poll03"
 
 cleanup()
 {
-	tst_rhost_run -c "pkill -9 netstress\$"
 	tst_rmdir
 
 	sysctl -q -w net.core.busy_poll=$busy_poll_old
@@ -50,9 +49,7 @@ trap "tst_brkm TBROK 'test interrupted'" INT
 for x in 50 0; do
 	tst_resm TINFO "set low latency busy poll to $x per socket"
 	set_busy_poll $x
-	tst_netload $(tst_ipaddr rhost) res_$x TFO -b $x -U || \
-		tst_brkm TBROK "netload() failed"
-	tst_resm TINFO "time spent is '$(cat res_$x)' ms"
+	tst_netload -H $(tst_ipaddr rhost) -d res_$x -b $x -U
 done
 
 poll_cmp=$(( 100 - ($(cat res_50) * 100) / $(cat res_0) ))
diff --git a/testcases/network/dctcp/dctcp01.sh b/testcases/network/dctcp/dctcp01.sh
index 5c401ce..d7407dd 100755
--- a/testcases/network/dctcp/dctcp01.sh
+++ b/testcases/network/dctcp/dctcp01.sh
@@ -70,23 +70,13 @@ test_run()
 
 	set_cong_alg "$def_alg"
 
-	tst_netload $(tst_ipaddr rhost) tfo_res TFO
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "test with '$def_alg' has failed"
-		return
-	fi
-	local res0="$(cat tfo_res)"
-	tst_resm TINFO "$def_alg time '$res0' ms"
+	tst_netload -H $(tst_ipaddr rhost)
+	local res0="$(cat tst_netload.res)"
 
 	set_cong_alg "dctcp"
 
-	tst_netload $(tst_ipaddr rhost) tfo_res TFO
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "test with 'dctcp' has failed"
-		return
-	fi
-	local res1="$(cat tfo_res)"
-	tst_resm TINFO "dctcp time '$res1' ms"
+	tst_netload -H $(tst_ipaddr rhost)
+	local res1="$(cat tst_netload.res)"
 
 	local per=$(( $res0 * 100 / $res1 - 100 ))
 
diff --git a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
index 9d0ce35..d0341cd 100755
--- a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
+++ b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
@@ -30,8 +30,6 @@ TCID="tcp_fastopen"
 
 . test_net.sh
 
-tfo_result="netload.res"
-
 while getopts :hu:sr:p:n:R:6 opt; do
 	case "$opt" in
 	h)
@@ -58,17 +56,9 @@ done
 
 cleanup()
 {
-	tst_resm TINFO "cleanup..."
-	tst_rhost_run -c "pkill -9 netstress\$"
 	tst_rmdir
 }
 
-read_result_file()
-{
-	[ ! -f $tfo_result ] && echo "-1"
-	[ -r $tfo_result ] && cat $tfo_result || echo "-1"
-}
-
 tst_require_root
 
 if tst_kvcmp -lt "3.7"; then
@@ -83,15 +73,15 @@ trap "tst_brkm TBROK 'test interrupted'" INT
 TST_CLEANUP="cleanup"
 tst_tmpdir
 
-tst_resm TINFO "using old TCP API"
-tst_netload $(tst_ipaddr rhost) $tfo_result TFO
-time_tfo_off=$(read_result_file)
-[ "$time_tfo_off" = "-1" ] && tst_brkm TFAIL "failed to find result file"
+tst_resm TINFO "using old TCP API and set tcp_fastopen to '0'"
+tst_netload -H $(tst_ipaddr rhost) -a $clients_num -r $client_requests \
+	-R $max_requests -t 0
+time_tfo_off=$(cat tst_netload.res)
 
-tst_resm TINFO "using new TCP API"
-tst_netload $(tst_ipaddr rhost) $tfo_result TFO -f -t 3
-time_tfo_on=$(read_result_file)
-[ "$time_tfo_on" = "-1" ] && tst_brkm TFAIL "failed to find result file"
+tst_resm TINFO "using new TCP API and set tcp_fastopen to '3'"
+tst_netload -H $(tst_ipaddr rhost)  -a $clients_num -r $client_requests \
+	-R $max_requests -f -t 3
+time_tfo_on=$(cat tst_netload.res)
 
 tfo_cmp=$(( 100 - ($time_tfo_on * 100) / $time_tfo_off ))
 
diff --git a/testcases/network/virt/geneve01.sh b/testcases/network/virt/geneve01.sh
index 7d15098..5140db8 100755
--- a/testcases/network/virt/geneve01.sh
+++ b/testcases/network/virt/geneve01.sh
@@ -36,10 +36,6 @@ cleanup()
 {
 	cleanup_vifaces
 	tst_rhost_run -c "ip link delete ltp_v0 2>/dev/null"
-	if [ "$net_load" = "TFO" ]; then
-		tst_rhost_run -c "pkill -9 netstress\$"
-		pkill -9 "netstress\$"
-	fi
 }
 TST_CLEANUP="cleanup"
 
diff --git a/testcases/network/virt/gre01.sh b/testcases/network/virt/gre01.sh
index 6aecbeb..cb90c68 100755
--- a/testcases/network/virt/gre01.sh
+++ b/testcases/network/virt/gre01.sh
@@ -34,17 +34,9 @@ cleanup()
 {
 	cleanup_vifaces
 	tst_rhost_run -c "ip link delete ltp_v0 2>/dev/null"
-	if [ "$net_load" = "TFO" ]; then
-		tst_rhost_run -c "pkill -9 netstress\$"
-		pkill -9 "netstress\$"
-	fi
 }
 TST_CLEANUP="cleanup"
 
-if [ "$net_load" = "TFO" ]; then
-	tst_check_cmds "netstress"
-fi
-
 if [ -z $ip_local -o -z $ip_remote ]; then
 	tst_brkm TBROK "you must specify IP address"
 fi
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index cb27293..6036b42 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -38,16 +38,15 @@ ip_virt_remote="192.168.124.2"
 ip6_virt_remote="fe80::381c:c0ff:fea8:7c02"
 mac_virt_remote="3A:1C:C0:A8:7C:02"
 
-clients_num=2
-client_requests=500000
-max_requests=3
-net_load="TFO"
-
 # Max performance loss (%) for virtual devices during network load
 VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-80}
 vxlan_dstport=0
 
-while getopts :hsx:i:r:c:R:p:n:l:t:d:6 opt; do
+clients_num=2
+client_requests=500000
+max_requests=20
+
+while getopts :hsx:i:r:c:R:p:n:t:d:6 opt; do
 	case "$opt" in
 	h)
 		echo "Usage:"
@@ -60,7 +59,6 @@ while getopts :hsx:i:r:c:R:p:n:l:t:d:6 opt; do
 		echo "R n      num of reqs, after which conn.closed in TCP perf"
 		echo "p x      x and x + 1 are ports in TCP perf"
 		echo "n x      virtual network 192.168.x"
-		echo "l x      network load: x is PING or TFO(netstress)"
 		echo "t x      performance threshold, default is 60%"
 		echo "d x      VxLAN destination address, 'uni' or 'multi'"
 		echo "6        run over IPv6"
@@ -77,7 +75,6 @@ while getopts :hsx:i:r:c:R:p:n:l:t:d:6 opt; do
 		ip_virt_local="192.168.${OPTARG}.1"
 		ip_virt_remote="192.168.${OPTARG}.2"
 	;;
-	l) net_load=$OPTARG ;;
 	t) VIRT_PERF_THRESHOLD=$OPTARG ;;
 	d) vxlan_dst_addr=$OPTARG ;;
 	6) # skip, test_net library already processed it
@@ -255,31 +252,27 @@ vxlan_setup_subnet_multi()
 
 virt_compare_netperf()
 {
-	local ret=0
-	local expected_result=${1:-"pass"}
+	local ret1="pass"
+	local ret2="pass"
+	local expect_res="${1:-pass}"
 
-	tst_netload $ip_virt_remote res_ipv4 $net_load || ret=1
-	tst_netload ${ip6_virt_remote}%ltp_v0 res_ipv6 $net_load || ret=1
+	tst_netload -H $ip_virt_remote -a $clients_num -R $max_requests \
+		-r $client_requests -d res_ipv4 -e $expect_res || ret1="fail"
+
+	tst_netload -H ${ip6_virt_remote}%ltp_v0 -a $clients_num \
+		-R $max_requests -r $client_requests -d res_ipv6 \
+		-e $expect_res || ret2="fail"
 
 	ROD_SILENT "ip link delete ltp_v0"
 	tst_rhost_run -s -c "ip link delete ltp_v0"
 
-	if [ "$ret" -eq 1 ]; then
-		if [ "$expected_result" = "pass" ]; then
-			tst_resm TFAIL "Test with virtual iface failed"
-		else
-			tst_resm TPASS "Test failed as expected"
-		fi
-		return
-	fi
+	[ "$ret1" = "fail" -o "$ret2" = "fail" ] && return
+
 	local vt="$(cat res_ipv4)"
 	local vt6="$(cat res_ipv6)"
 
-	tst_netload $ip_remote res_ipv4 $net_load
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "Test with $ip_remote failed"
-		return
-	fi
+	tst_netload -H $ip_remote -a $clients_num -R $max_requests \
+		-r $client_requests -d res_ipv4
 
 	local lt="$(cat res_ipv4)"
 	tst_resm TINFO "time lan($lt) $virt_type IPv4($vt) and IPv6($vt6) ms"
diff --git a/testcases/network/virt/vlan03.sh b/testcases/network/virt/vlan03.sh
index 894d214..0d259e1 100755
--- a/testcases/network/virt/vlan03.sh
+++ b/testcases/network/virt/vlan03.sh
@@ -35,17 +35,9 @@ cleanup()
 {
 	cleanup_vifaces
 	tst_rhost_run -c "ip link delete ltp_v0 2>/dev/null"
-	if [ "$net_load" = "TFO" ]; then
-		tst_rhost_run -c "pkill -9 netstress\$"
-		pkill -9 "netstress\$"
-	fi
 }
 TST_CLEANUP="cleanup"
 
-if [ "$net_load" = "TFO" ]; then
-	tst_check_cmds "netstress"
-fi
-
 if [ -z $ip_local -o -z $ip_remote ]; then
 	tst_brkm TBROK "you must specify IP address"
 fi
diff --git a/testcases/network/virt/vxlan03.sh b/testcases/network/virt/vxlan03.sh
index 191576e..d1c0afb 100755
--- a/testcases/network/virt/vxlan03.sh
+++ b/testcases/network/virt/vxlan03.sh
@@ -46,17 +46,9 @@ cleanup()
 {
 	cleanup_vifaces
 	tst_rhost_run -c "ip link delete ltp_v0 2>/dev/null"
-	if [ "$net_load" = "TFO" ]; then
-		tst_rhost_run -c "pkill -9 netstress\$"
-		pkill -9 "netstress\$"
-	fi
 }
 TST_CLEANUP="cleanup"
 
-if [ "$net_load" = "TFO" ]; then
-	tst_check_cmds "netstress"
-fi
-
 if [ -z $ip_local -o -z $ip_remote ]; then
 	tst_brkm TBROK "you must specify IP address"
 fi
-- 
1.7.1

