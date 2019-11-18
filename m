From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 18 Nov 2019 13:42:38 +0300
Subject: [LTP] [PATCH v2] lib/tst_net.sh: use SO_BINDTODEVICE in
 tst_netload()
Message-ID: <20191118104238.15044-1-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since we have the information about the device, enable the
auto usage of the option, when starting netstress.

It can be disabled with TST_NETLOAD_BINDTODEVICE=0 even if
'-D' option is passed to tst_netload().

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---

v2: * Added fixes for vti based tests and mpls
    * Control the usage with TST_NETLOAD_BINDTODEVICE

 testcases/lib/tst_net.sh                        | 10 +++++++++-
 testcases/network/mpls/mpls_lib.sh              |  2 +-
 testcases/network/stress/dccp/dccp_ipsec_vti.sh |  2 +-
 testcases/network/stress/sctp/sctp_ipsec_vti.sh |  2 +-
 testcases/network/stress/tcp/tcp_ipsec_vti.sh   |  3 ++-
 testcases/network/stress/udp/udp_ipsec_vti.sh   |  2 +-
 6 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 5e44ebdb2..5c619e358 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -641,6 +641,7 @@ tst_netload()
 	# number of server replies after which TCP connection is closed
 	local s_replies="${TST_NETLOAD_MAX_SRV_REPLIES:-500000}"
 	local s_opts=
+	local bind_to_device=1
 
 	if [ ! "$TST_NEEDS_TMPDIR" = 1 ]; then
 		tst_brk_ TBROK "Using tst_netload requires setting TST_NEEDS_TMPDIR=1"
@@ -668,7 +669,8 @@ tst_netload()
 		f) cs_opts="${cs_opts}-f " ;;
 		F) cs_opts="${cs_opts}-F " ;;
 		e) expect_res="$OPTARG" ;;
-		D) cs_opts="${cs_opts}-D $OPTARG " ;;
+		D) [ "$TST_NETLOAD_BINDTODEVICE" = 1 ] && cs_opts="${cs_opts}-D $OPTARG "
+		   bind_to_device=0 ;;
 		*) tst_brk_ TBROK "tst_netload: unknown option: $OPTARG" ;;
 		esac
 	done
@@ -676,6 +678,11 @@ tst_netload()
 
 	[ "$setup_srchost" = 1 ] && s_opts="${s_opts}-S $hostopt "
 
+	if [ "$bind_to_device" = 1 -a "$TST_NETLOAD_BINDTODEVICE" = 1 ]; then
+		c_opts="${c_opts}-D $(tst_iface) "
+		s_opts="${s_opts}-D $(tst_iface rhost) "
+	fi
+
 	local expect_ret=0
 	[ "$expect_res" != "pass" ] && expect_ret=3
 
@@ -891,6 +898,7 @@ fi
 
 export TST_NETLOAD_CLN_REQUESTS="${TST_NETLOAD_CLN_REQUESTS:-10000}"
 export TST_NETLOAD_CLN_NUMBER="${TST_NETLOAD_CLN_NUMBER:-2}"
+export TST_NETLOAD_BINDTODEVICE="${TST_NETLOAD_BINDTODEVICE:-1}"
 export HTTP_DOWNLOAD_DIR="${HTTP_DOWNLOAD_DIR:-/var/www/html}"
 export FTP_DOWNLOAD_DIR="${FTP_DOWNLOAD_DIR:-/var/ftp}"
 export FTP_UPLOAD_DIR="${FTP_UPLOAD_DIR:-/var/ftp/pub}"
diff --git a/testcases/network/mpls/mpls_lib.sh b/testcases/network/mpls/mpls_lib.sh
index 84b323615..4ac79950e 100755
--- a/testcases/network/mpls/mpls_lib.sh
+++ b/testcases/network/mpls/mpls_lib.sh
@@ -8,7 +8,7 @@ TST_NEEDS_ROOT=1
 TST_NEEDS_DRIVERS="mpls_router mpls_iptunnel mpls_gso"
 TST_NEEDS_CMDS="sysctl modprobe"
 TST_TEST_DATA="icmp tcp udp"
-
+TST_NETLOAD_BINDTODEVICE=0
 . tst_net.sh
 
 mpls_cleanup()
diff --git a/testcases/network/stress/dccp/dccp_ipsec_vti.sh b/testcases/network/stress/dccp/dccp_ipsec_vti.sh
index 5c8f78249..24c28fbde 100755
--- a/testcases/network/stress/dccp/dccp_ipsec_vti.sh
+++ b/testcases/network/stress/dccp/dccp_ipsec_vti.sh
@@ -16,7 +16,7 @@ do_test()
 	local rand_opt="$(echo $2 | cut -d'R' -f2)"
 
 	[ "$2" != "$rand_opt" ] && opts="-A $rand_opt"
-	tst_netload -H $ip_rmt_tun -T dccp $opts -r $IPSEC_REQUESTS
+	tst_netload -H $ip_rmt_tun -T dccp $opts -r $IPSEC_REQUESTS -D $tst_vti
 }
 
 tst_run
diff --git a/testcases/network/stress/sctp/sctp_ipsec_vti.sh b/testcases/network/stress/sctp/sctp_ipsec_vti.sh
index fe6135ac2..9c5747121 100755
--- a/testcases/network/stress/sctp/sctp_ipsec_vti.sh
+++ b/testcases/network/stress/sctp/sctp_ipsec_vti.sh
@@ -17,7 +17,7 @@ do_test()
 
 	[ "$2" != "$rand_opt" ] && opts="-A $rand_opt"
 	tst_netload -H $ip_rmt_tun -T sctp $opts -r $IPSEC_REQUESTS \
-		-S $ip_loc_tun
+		-S $ip_loc_tun -D $tst_vti
 }
 
 tst_run
diff --git a/testcases/network/stress/tcp/tcp_ipsec_vti.sh b/testcases/network/stress/tcp/tcp_ipsec_vti.sh
index 118db547a..41ab1ca98 100755
--- a/testcases/network/stress/tcp/tcp_ipsec_vti.sh
+++ b/testcases/network/stress/tcp/tcp_ipsec_vti.sh
@@ -18,7 +18,8 @@ do_test()
 	local rand_opt="$(echo $2 | cut -d'R' -f2)"
 
 	[ "$2" != "$rand_opt" ] && opts="-A $rand_opt"
-	tst_netload -H $ip_rmt_tun $opts -r $IPSEC_REQUESTS -R $max_requests
+	tst_netload -H $ip_rmt_tun $opts -r $IPSEC_REQUESTS \
+		    -R $max_requests -D $tst_vti
 }
 
 tst_run
diff --git a/testcases/network/stress/udp/udp_ipsec_vti.sh b/testcases/network/stress/udp/udp_ipsec_vti.sh
index 2afe70eee..d9a1e33af 100755
--- a/testcases/network/stress/udp/udp_ipsec_vti.sh
+++ b/testcases/network/stress/udp/udp_ipsec_vti.sh
@@ -19,7 +19,7 @@ do_test()
 
 	[ $1 -eq 2 ] && type="udp_lite"
 	[ "$2" != "$rand_opt" ] && opts="-A $rand_opt"
-	tst_netload -H $ip_rmt_tun -T $type $opts -r $IPSEC_REQUESTS
+	tst_netload -H $ip_rmt_tun -T $type $opts -r $IPSEC_REQUESTS -D $tst_vti
 }
 
 tst_run
-- 
2.20.1

