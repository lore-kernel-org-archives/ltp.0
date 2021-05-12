From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 12 May 2021 17:07:50 +0200
Subject: [LTP] [PATCH v2 1/1] netns_helper.sh: Replace ip version check with
 feature testing
Message-ID: <20210512150750.12152-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ip version check in tst_check_iproute() was broken since iproute2
version v5.7.0-77-gb687d1067169 (released in v5.8.0), there is
new scheme which contains kernel version. Although it'd be trivial to
fix it, check the actual required feature is better.

This fixes error for newest version scheme:
    [: too many arguments

NOTE: required version ss111010 (v3.0.0) is 10 years old (LTP might not
even compile with toolchain from these distros), we might drop this
check after the release.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/containers/netns/netns_helper.sh   | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
index a5b77a0aa..f25b0c67e 100755
--- a/testcases/kernel/containers/netns/netns_helper.sh
+++ b/testcases/kernel/containers/netns/netns_helper.sh
@@ -45,22 +45,6 @@ NS_HANDLE1=
 # ifconfig <device> $IFCONF_IN6_ARG IP/NETMASK
 IFCONF_IN6_ARG=
 
-tst_check_iproute()
-{
-	local cur_ipver="$(ip -V)"
-	local spe_ipver="$1"
-
-	cur_ipver=${cur_ipver##*s}
-
-	if [ -z "$cur_ipver" -o -z "$spe_ipver" ]; then
-		tst_brk TBROK "failed to obtain valid iproute version"
-	fi
-
-	if [ $cur_ipver -lt $spe_ipver ]; then
-		tst_brk TCONF "too old iproute version"
-	fi
-}
-
 # Sets up global variables which can be used in test cases (documented above),
 # creates two network namespaces and a pair of virtual ethernet devices, each
 # device in one namespace. Each device is then enabled and assigned an IP
@@ -204,7 +188,8 @@ netns_ns_exec_setup()
 # ethernet device is then created for each namespace.
 netns_ip_setup()
 {
-	tst_check_iproute 111010
+	ip netns || tst_brk TCONF "ip without netns support (required iproute2 >= ss111010 - v3.0.0)"
+
 	NS_EXEC="ip netns exec"
 
 	NS_HANDLE0=tst_net_ns0
-- 
2.31.1

