From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  7 Dec 2018 13:35:11 +0100
Subject: [LTP] [PATCH v2 1/6] net/dhcp: Rename setup & cleanup functions
In-Reply-To: <20181207123516.30867-1-pvorel@suse.cz>
References: <20181207123516.30867-1-pvorel@suse.cz>
Message-ID: <20181207123516.30867-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/dhcp/dhcp_lib.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/network/dhcp/dhcp_lib.sh b/testcases/network/dhcp/dhcp_lib.sh
index 29b8027de..08838a479 100755
--- a/testcases/network/dhcp/dhcp_lib.sh
+++ b/testcases/network/dhcp/dhcp_lib.sh
@@ -5,9 +5,9 @@
 #
 # Author:       Alexey Kodanev alexey.kodanev@oracle.com
 
-TST_SETUP="init"
+TST_SETUP="dhcp_lib_setup"
+TST_CLEANUP="dhcp_lib_cleanup"
 TST_TESTFUNC="test01"
-TST_CLEANUP="cleanup"
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="cat $dhcp_name awk ip pgrep pkill dhclient"
@@ -36,7 +36,7 @@ stop_dhcp()
 	[ "$(pgrep -x $dhcp_name)" ] && return 1 || return 0
 }
 
-init()
+dhcp_lib_setup()
 {
 	if [ $TST_IPV6 ]; then
 		ip_addr="fd00:1:1:2::12/64"
@@ -69,7 +69,7 @@ init()
 		tst_brk TBROK "failed to add ip address"
 }
 
-cleanup()
+dhcp_lib_cleanup()
 {
 	[ -z "$veth_loaded" ] && return
 
-- 
2.19.2

