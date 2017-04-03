From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  3 Apr 2017 14:45:03 +0200
Subject: [LTP] [RFC PATCH v3 3/3] network: Use tst_net_vars to set up
	variables
In-Reply-To: <20170403124503.24054-1-pvorel@suse.cz>
References: <20170403124503.24054-1-pvorel@suse.cz>
Message-ID: <20170403124503.24054-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_net_vars simplifies setup as it only needs to have passed 4 IP
addresses (2 IPv4 and 2 IPv6).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testcases/lib/test_net.sh | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index f0e05b13d..4540694c7 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -487,31 +487,14 @@ export PASSWD="${PASSWD:-}"
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
-# Reverse network portion of the IPv6 address
-export IPV6_NET_REV="${IPV6_NET_REV:-1.0.0.0.1.0.0.0.1.0.0.0.0.0.d.f}"
-# Reverse host portion of the IPv6 address of the local host
-export LHOST_IPV6_REV="${LHOST_IPV6_REV:-2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0}"
-# Reverse host portion of the IPv6 address of the remote host
-export RHOST_IPV6_REV="${RHOST_IPV6_REV:-1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0}"
-
-# Networks that aren't reachable through the test links
-export IPV4_NET16_UNUSED="${IPV4_NET16_UNUSED:-10.23}"
-export IPV6_NET32_UNUSED="${IPV6_NET32_UNUSED:-fd00:23}"
+# set test links + networks that aren't reachable through the test links
+IPV4_LHOST="${IPV4_LHOST:-10.0.0.2/24}"
+IPV4_RHOST="${IPV4_RHOST:-10.0.0.1/24}"
+eval `tst_net_vars $IPV4_LHOST $IPV4_RHOST`
+
+IPV6_LHOST="${IPV6_LHOST:-fd00:1:1:1::2/64}"
+IPV6_RHOST="${IPV6_RHOST:-fd00:1:1:1::1/64}"
+eval `tst_net_vars $IPV6_LHOST $IPV6_RHOST`
 
 export HTTP_DOWNLOAD_DIR="${HTTP_DOWNLOAD_DIR:-/var/www/html}"
 export FTP_DOWNLOAD_DIR="${FTP_DOWNLOAD_DIR:-/var/ftp}"
-- 
2.11.0

