From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 23 Jan 2017 15:02:58 +0100
Subject: [LTP] [PATCH v2 1/2] network: Fix export for some non-bash shells
Message-ID: <20170123140259.20053-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fix 'export: -n: bad variable name' for scripts using test_net.sh
in dash.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/test_net.sh | 72 +++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 68c767773..4902a6aac 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -370,66 +370,66 @@ tst_ping()
 # Management Link
 [ -z "$RHOST" ] && TST_USE_NETNS="yes"
 export RHOST="$RHOST"
-export PASSWD=${PASSWD:-""}
+export PASSWD="${PASSWD:-}"
 # Don't use it in new tests, use tst_rhost_run() from test_net.sh instead.
-export LTP_RSH=${LTP_RSH:-"rsh -n"}
+export LTP_RSH="${LTP_RSH:-rsh -n}"
 
 # Test Links
 # Set first three octets of the network address, default is '10.0.0'
-export IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
+export IPV4_NETWORK="${IPV4_NETWORK:-10.0.0}"
 # Set local host last octet, default is '2'
-export LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"2"}
+export LHOST_IPV4_HOST="${LHOST_IPV4_HOST:-2}"
 # Set remote host last octet, default is '1'
-export RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}
+export RHOST_IPV4_HOST="${RHOST_IPV4_HOST:-1}"
 # Set the reverse of IPV4_NETWORK
-export IPV4_NET_REV=${IPV4_NET_REV:-"0.0.10"}
+export IPV4_NET_REV="${IPV4_NET_REV:-0.0.10}"
 # Set first three octets of the network address, default is 'fd00:1:1:1'
-export IPV6_NETWORK=${IPV6_NETWORK:-"fd00:1:1:1"}
+export IPV6_NETWORK="${IPV6_NETWORK:-fd00:1:1:1}"
 # Set local host last octet, default is '2'
-export LHOST_IPV6_HOST=${LHOST_IPV6_HOST:-":2"}
+export LHOST_IPV6_HOST="${LHOST_IPV6_HOST:-:2}"
 # Set remote host last octet, default is '1'
-export RHOST_IPV6_HOST=${RHOST_IPV6_HOST:-":1"}
+export RHOST_IPV6_HOST="${RHOST_IPV6_HOST:-:1}"
 # Reverse network portion of the IPv6 address
-export IPV6_NET_REV=${IPV6_NET_REV:-"1.0.0.0.1.0.0.0.1.0.0.0.0.0.d.f"}
+export IPV6_NET_REV="${IPV6_NET_REV:-1.0.0.0.1.0.0.0.1.0.0.0.0.0.d.f}"
 # Reverse host portion of the IPv6 address of the local host
-export LHOST_IPV6_REV=${LHOST_IPV6_REV:-"2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0"}
+export LHOST_IPV6_REV="${LHOST_IPV6_REV:-2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0}"
 # Reverse host portion of the IPv6 address of the remote host
-export RHOST_IPV6_REV=${RHOST_IPV6_REV:-"1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0"}
+export RHOST_IPV6_REV="${RHOST_IPV6_REV:-1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0}"
 
 # Networks that aren't reachable through the test links
-export IPV4_NET16_UNUSED=${IPV4_NET16_UNUSED:-"10.23"}
-export IPV6_NET32_UNUSED=${IPV6_NET32_UNUSED:-"fd00:23"}
+export IPV4_NET16_UNUSED="${IPV4_NET16_UNUSED:-10.23}"
+export IPV6_NET32_UNUSED="${IPV6_NET32_UNUSED:-fd00:23}"
 
-export HTTP_DOWNLOAD_DIR=${HTTP_DOWNLOAD_DIR:-"/var/www/html"}
-export FTP_DOWNLOAD_DIR=${FTP_DOWNLOAD_DIR:-"/var/ftp"}
-export FTP_UPLOAD_DIR=${FTP_UPLOAD_DIR:-"/var/ftp/pub"}
-export FTP_UPLOAD_URLDIR=${FTP_UPLOAD_URLDIR:-"pub"}
+export HTTP_DOWNLOAD_DIR="${HTTP_DOWNLOAD_DIR:-/var/www/html}"
+export FTP_DOWNLOAD_DIR="${FTP_DOWNLOAD_DIR:-/var/ftp}"
+export FTP_UPLOAD_DIR="${FTP_UPLOAD_DIR:-/var/ftp/pub}"
+export FTP_UPLOAD_URLDIR="${FTP_UPLOAD_URLDIR:-pub}"
 
 # network/stress tests require additional parameters
-export NS_DURATION=${NS_DURATION:-"3600"}
-export NS_TIMES=${NS_TIMES:-"10000"}
-export CONNECTION_TOTAL=${CONNECTION_TOTAL:-"4000"}
-export IP_TOTAL=${IP_TOTAL:-"10000"}
-export IP_TOTAL_FOR_TCPIP=${IP_TOTAL_FOR_TCPIP:-"100"}
-export ROUTE_TOTAL=${ROUTE_TOTAL:-"10000"}
-export MTU_CHANGE_TIMES=${MTU_CHANGE_TIMES:-"1000"}
-export IF_UPDOWN_TIMES=${IF_UPDOWN_TIMES:-"10000"}
-export DOWNLOAD_BIGFILESIZE=${DOWNLOAD_BIGFILESIZE:-"2147483647"}
-export DOWNLOAD_REGFILESIZE=${DOWNLOAD_REGFILESIZE:-"1048576"}
-export UPLOAD_BIGFILESIZE=${UPLOAD_BIGFILESIZE:-"2147483647"}
-export UPLOAD_REGFILESIZE=${UPLOAD_REGFILESIZE:-"1024"}
-export MCASTNUM_NORMAL=${MCASTNUM_NORMAL:-"20"}
-export MCASTNUM_HEAVY=${MCASTNUM_HEAVY:-"40000"}
+export NS_DURATION="${NS_DURATION:-3600}"
+export NS_TIMES="${NS_TIMES:-10000}"
+export CONNECTION_TOTAL="${CONNECTION_TOTAL:-4000}"
+export IP_TOTAL="${IP_TOTAL:-10000}"
+export IP_TOTAL_FOR_TCPIP="${IP_TOTAL_FOR_TCPIP:-100}"
+export ROUTE_TOTAL="${ROUTE_TOTAL:-10000}"
+export MTU_CHANGE_TIMES="${MTU_CHANGE_TIMES:-1000}"
+export IF_UPDOWN_TIMES="${IF_UPDOWN_TIMES:-10000}"
+export DOWNLOAD_BIGFILESIZE="${DOWNLOAD_BIGFILESIZE:-2147483647}"
+export DOWNLOAD_REGFILESIZE="${DOWNLOAD_REGFILESIZE:-1048576}"
+export UPLOAD_BIGFILESIZE="${UPLOAD_BIGFILESIZE:-2147483647}"
+export UPLOAD_REGFILESIZE="${UPLOAD_REGFILESIZE:-1024}"
+export MCASTNUM_NORMAL="${MCASTNUM_NORMAL:-20}"
+export MCASTNUM_HEAVY="${MCASTNUM_HEAVY:-40000}"
 
 [ -n "$TST_USE_NETNS" -a "$TST_INIT_NETNS" != "no" ] && init_ltp_netspace
 
 # Warning: make sure to set valid interface names and IP addresses below.
 # Set names for test interfaces, e.g. "eth0 eth1"
-export LHOST_IFACES=${LHOST_IFACES:-"eth0"}
-export RHOST_IFACES=${RHOST_IFACES:-"eth0"}
+export LHOST_IFACES="${LHOST_IFACES:-eth0}"
+export RHOST_IFACES="${RHOST_IFACES:-eth0}"
 # Set corresponding HW addresses, e.g. "00:00:00:00:00:01 00:00:00:00:00:02"
-export LHOST_HWADDRS=${LHOST_HWADDRS:-"$(tst_get_hwaddrs lhost)"}
-export RHOST_HWADDRS=${RHOST_HWADDRS:-"$(tst_get_hwaddrs rhost)"}
+export LHOST_HWADDRS="${LHOST_HWADDRS:-$(tst_get_hwaddrs lhost)}"
+export RHOST_HWADDRS="${RHOST_HWADDRS:-$(tst_get_hwaddrs rhost)}"
 
 # More information about network parameters can be found
 # in the following document: testcases/network/stress/README
-- 
2.11.0

