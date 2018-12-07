From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  7 Dec 2018 13:35:16 +0100
Subject: [LTP] [PATCH v2 6/6] net: Add security warning flag to some net
	tests
In-Reply-To: <20181207123516.30867-1-pvorel@suse.cz>
References: <20181207123516.30867-1-pvorel@suse.cz>
Message-ID: <20181207123516.30867-7-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Added to dnsmasq and traceroute tests and other network tests which use
tst_ping() and has been ported to new shell API (tst_security.sh
requirement).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in this version.
---
 testcases/network/dhcp/dnsmasq_tests.sh            | 1 +
 testcases/network/mpls/mpls02.sh                   | 1 +
 testcases/network/mpls/mpls_lib.sh                 | 1 +
 testcases/network/stress/icmp/icmp-uni-basic.sh    | 1 +
 testcases/network/stress/icmp/icmp-uni-vti.sh      | 1 +
 testcases/network/stress/interface/if-mtu-change   | 1 +
 testcases/network/stress/interface/if4-addr-change | 1 +
 testcases/network/traceroute/traceroute01.sh       | 1 +
 8 files changed, 8 insertions(+)

diff --git a/testcases/network/dhcp/dnsmasq_tests.sh b/testcases/network/dhcp/dnsmasq_tests.sh
index 284c3cce1..d5f89ae81 100755
--- a/testcases/network/dhcp/dnsmasq_tests.sh
+++ b/testcases/network/dhcp/dnsmasq_tests.sh
@@ -6,6 +6,7 @@
 # Author: Alexey Kodanev alexey.kodanev@oracle.com
 
 dhcp_name="dnsmasq"
+TST_SECURITY_WARN=1
 
 . dhcp_lib.sh
 TST_SETUP="setup"
diff --git a/testcases/network/mpls/mpls02.sh b/testcases/network/mpls/mpls02.sh
index 745a414f6..a2c93ff58 100755
--- a/testcases/network/mpls/mpls02.sh
+++ b/testcases/network/mpls/mpls02.sh
@@ -5,6 +5,7 @@
 TST_SETUP="setup"
 TST_TESTFUNC="do_test"
 TST_CLEANUP="cleanup"
+TST_SECURITY_WARN=1
 
 . mpls_lib.sh
 
diff --git a/testcases/network/mpls/mpls_lib.sh b/testcases/network/mpls/mpls_lib.sh
index 43ec16a6e..20bb24022 100755
--- a/testcases/network/mpls/mpls_lib.sh
+++ b/testcases/network/mpls/mpls_lib.sh
@@ -8,6 +8,7 @@ TST_NEEDS_ROOT=1
 TST_NEEDS_DRIVERS="mpls_router mpls_iptunnel mpls_gso"
 TST_NEEDS_CMDS="sysctl modprobe"
 TST_TEST_DATA="icmp tcp udp"
+TST_SECURITY_WARN=1
 
 . tst_net.sh
 
diff --git a/testcases/network/stress/icmp/icmp-uni-basic.sh b/testcases/network/stress/icmp/icmp-uni-basic.sh
index 5980b81e5..436f33bfd 100755
--- a/testcases/network/stress/icmp/icmp-uni-basic.sh
+++ b/testcases/network/stress/icmp/icmp-uni-basic.sh
@@ -8,6 +8,7 @@
 TST_TESTFUNC=do_test
 TST_SETUP=do_setup
 TST_CLEANUP=tst_ipsec_cleanup
+TST_SECURITY_WARN=1
 . ipsec_lib.sh
 
 do_setup()
diff --git a/testcases/network/stress/icmp/icmp-uni-vti.sh b/testcases/network/stress/icmp/icmp-uni-vti.sh
index 24eca177c..c9c39331d 100755
--- a/testcases/network/stress/icmp/icmp-uni-vti.sh
+++ b/testcases/network/stress/icmp/icmp-uni-vti.sh
@@ -7,6 +7,7 @@
 TST_TESTFUNC=do_test
 TST_SETUP=do_setup
 TST_CLEANUP=tst_ipsec_cleanup
+TST_SECURITY_WARN=1
 . ipsec_lib.sh
 
 do_setup()
diff --git a/testcases/network/stress/interface/if-mtu-change b/testcases/network/stress/interface/if-mtu-change
index 19bcffe1e..0872bca8c 100644
--- a/testcases/network/stress/interface/if-mtu-change
+++ b/testcases/network/stress/interface/if-mtu-change
@@ -21,6 +21,7 @@
 IF_CMD='ifconfig'
 TST_SETUP="do_setup"
 TST_CLEANUP="do_cleanup"
+TST_SECURITY_WARN=1
 . if-lib.sh
 
 # The interval of the mtu change [second]
diff --git a/testcases/network/stress/interface/if4-addr-change b/testcases/network/stress/interface/if4-addr-change
index 5ab67751e..8e5ab85f5 100644
--- a/testcases/network/stress/interface/if4-addr-change
+++ b/testcases/network/stress/interface/if4-addr-change
@@ -22,6 +22,7 @@ TCID=if4-addr-change
 TST_CLEANUP="do_cleanup"
 TST_TESTFUNC="test_body"
 TST_NEEDS_CMDS="ifconfig"
+TST_SECURITY_WARN=1
 . tst_net.sh
 
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
diff --git a/testcases/network/traceroute/traceroute01.sh b/testcases/network/traceroute/traceroute01.sh
index 1c8b66f55..4ea1fd9db 100755
--- a/testcases/network/traceroute/traceroute01.sh
+++ b/testcases/network/traceroute/traceroute01.sh
@@ -18,6 +18,7 @@
 TST_TOTAL=6
 TCID="traceroute01"
 TST_CLEANUP="cleanup"
+TST_SECURITY_WARN=1
 
 TST_USE_LEGACY_API=1
 . tst_net.sh
-- 
2.19.2

