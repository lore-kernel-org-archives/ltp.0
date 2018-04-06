From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  6 Apr 2018 14:31:16 +0200
Subject: [LTP] [RFC PATCH v6 5/7] network/if-updown: Restore IP in cleanup
	function
In-Reply-To: <20180406123118.21309-1-pvorel@suse.cz>
References: <20180406123118.21309-1-pvorel@suse.cz>
Message-ID: <20180406123118.21309-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

While this is not visible due current test content in runtest file
(net_stress.interface), where other tests reset the settings, it is
needed as it break if-mtu-change on IPv6:

if-mtu-change 1 TINFO: set MTU to 1280 1/2
if-mtu-change 1 TFAIL: tst_ping IPv6 iface fd00:1:1:1::2, msg_size 1: fail

Test with runtest file:
if4-updown if-updown
if6-mtu-change if-mtu-change -6

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/interface/if-updown | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/network/stress/interface/if-updown b/testcases/network/stress/interface/if-updown
index 264331adb..45cf0feaf 100644
--- a/testcases/network/stress/interface/if-updown
+++ b/testcases/network/stress/interface/if-updown
@@ -19,12 +19,18 @@
 
 TST_TOTAL=2
 
-TST_CLEANUP="netstress_cleanup"
+TST_CLEANUP="do_cleanup"
 
 . test_net_stress.sh
 
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($IF_UPDOWN_TIMES / 20))}
 
+do_cleanup()
+{
+	netstress_cleanup
+	restore_ipaddr
+}
+
 test_body()
 {
 	local cmd_type=$1
-- 
2.16.2

