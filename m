From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  3 May 2017 18:07:51 +0200
Subject: [LTP] [RFC PATCH v5 3/3] network: Use tst_net_vars to set up IPv4
	and IPv6 related variables
In-Reply-To: <20170503160751.1634-1-pvorel@suse.cz>
References: <20170503160751.1634-1-pvorel@suse.cz>
Message-ID: <20170503160751.1634-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_net_vars simplifies setup as it only needs to have passed 4 IP
addresses (2 IPv4 and 2 IPv6).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/test_net.sh | 43 +++++++++++++------------------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 08493558b..42bfc8dbc 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -191,18 +191,11 @@ tst_ipaddr()
 {
 	local type="${1:-lhost}"
 	local ipv="${TST_IPV6:-4}"
-	local tst_host=
-
-	if [ "$type" = "lhost" ]; then
-		eval "tst_host=\$LHOST_IPV${ipv}_HOST"
-	else
-		eval "tst_host=\$RHOST_IPV${ipv}_HOST"
-	fi
 
 	if [ "$TST_IPV6" ]; then
-		echo "${IPV6_NETWORK}:${tst_host}"
+		[ "$type" = "lhost" ] && echo "$IPV6_LHOST" || echo "$IPV6_RHOST"
 	else
-		echo "${IPV4_NETWORK}.${tst_host}"
+		[ "$type" = "lhost" ] && echo "$IPV4_LHOST" || echo "$IPV4_RHOST"
 	fi
 }
 
@@ -242,8 +235,8 @@ tst_add_ipaddr()
 	local type="${1:-lhost}"
 	local link_num="${2:-0}"
 
-	local mask=24
-	[ "$TST_IPV6" ] && mask=64
+	local mask=$IPV4_PREFIX
+	[ "$TST_IPV6" ] && mask=$IPV6_PREFIX
 
 	local iface=$(tst_iface $type $link_num)
 
@@ -487,25 +480,15 @@ export PASSWD="${PASSWD:-}"
 # Don't use it in new tests, use tst_rhost_run() from test_net.sh instead.
 export LTP_RSH="${LTP_RSH:-rsh -n}"
 
-# Test Links
-# Set first three octets of the network address, default is '10.0.0'
-export IPV4_NETWORK="${IPV4_NETWORK:-10.0.0}"
-# Set local host last octet, default is '2'
-export LHOST_IPV4_HOST="${LHOST_IPV4_HOST:-2}"
-# Set remote host last octet, default is '1'
-export RHOST_IPV4_HOST="${RHOST_IPV4_HOST:-1}"
-# Set the reverse of IPV4_NETWORK
-export IPV4_NET_REV="${IPV4_NET_REV:-0.0.10}"
-# Set first three octets of the network address, default is 'fd00:1:1:1'
-export IPV6_NETWORK="${IPV6_NETWORK:-fd00:1:1:1}"
-# Set local host last octet, default is '2'
-export LHOST_IPV6_HOST="${LHOST_IPV6_HOST:-:2}"
-# Set remote host last octet, default is '1'
-export RHOST_IPV6_HOST="${RHOST_IPV6_HOST:-:1}"
-
-# Networks that aren't reachable through the test links
-export IPV4_NET16_UNUSED="${IPV4_NET16_UNUSED:-10.23}"
-export IPV6_NET32_UNUSED="${IPV6_NET32_UNUSED:-fd00:23}"
+# tst_net_vars exports environment variables related to test links + networks
+# that aren't reachable through the test links.
+# See tst_net_vars -h for a list of exported variables.
+IPV4_LHOST="${IPV4_LHOST:-10.0.0.2}"
+IPV4_RHOST="${IPV4_RHOST:-10.0.0.1}"
+eval `tst_net_vars $IPV4_LHOST $IPV4_RHOST`
+IPV6_LHOST="${IPV6_LHOST:-fd00:1:1:1::2}"
+IPV6_RHOST="${IPV6_RHOST:-fd00:1:1:1::1}"
+eval `tst_net_vars $IPV6_LHOST $IPV6_RHOST`
 
 export HTTP_DOWNLOAD_DIR="${HTTP_DOWNLOAD_DIR:-/var/www/html}"
 export FTP_DOWNLOAD_DIR="${FTP_DOWNLOAD_DIR:-/var/ftp}"
-- 
2.12.2

