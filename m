From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 15 Aug 2017 16:05:05 +0300
Subject: [LTP] [PATCH 2/2] network: new tests for MACsec driver
In-Reply-To: <1502802305-27958-1-git-send-email-alexey.kodanev@oracle.com>
References: <1502802305-27958-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1502802305-27958-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* macsec01 - default configuration
* macsec02 - enabled frame encryption and replay protection

Tests compare results with IPsec ones on the same interface.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net.features               |    3 ++
 testcases/network/virt/Makefile    |   13 +---------
 testcases/network/virt/macsec01.sh |   49 ++++++++++++++++++++++++++++++++++++
 testcases/network/virt/macsec02.sh |   49 ++++++++++++++++++++++++++++++++++++
 testcases/network/virt/virt_lib.sh |   37 +++++++++++++++++++++++++++
 5 files changed, 139 insertions(+), 12 deletions(-)
 create mode 100755 testcases/network/virt/macsec01.sh
 create mode 100755 testcases/network/virt/macsec02.sh

diff --git a/runtest/net.features b/runtest/net.features
index 7f2c889..46c58f0 100644
--- a/runtest/net.features
+++ b/runtest/net.features
@@ -37,6 +37,9 @@ vlan03 vlan03.sh
 macvlan01 macvlan01.sh
 macvtap01 macvtap01.sh
 
+macsec01 macsec01.sh
+macsec02 macsec02.sh
+
 ipvlan01 ipvlan01.sh
 
 gre_ipv4_01 gre01.sh
diff --git a/testcases/network/virt/Makefile b/testcases/network/virt/Makefile
index 9a97a82..619d769 100644
--- a/testcases/network/virt/Makefile
+++ b/testcases/network/virt/Makefile
@@ -18,17 +18,6 @@ top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_TARGETS		:= ipvlan01.sh \
-			   geneve01.sh \
-			   gre01.sh \
-			   macvlan01.sh \
-			   macvtap01.sh \
-			   virt_lib.sh \
-			   vlan01.sh \
-			   vlan02.sh \
-			   vlan03.sh \
-			   vxlan01.sh \
-			   vxlan02.sh \
-			   vxlan03.sh \
+INSTALL_TARGETS		:= *.sh
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/virt/macsec01.sh b/testcases/network/virt/macsec01.sh
new file mode 100755
index 0000000..eb470d5
--- /dev/null
+++ b/testcases/network/virt/macsec01.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+# Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+#
+# Test-case: setup two MACsec drivers and run TCP traffic over them
+# with default MACsec configuration, compare performance with similar
+# IPsec configuration on master interface.
+
+TCID=macsec01
+TST_TOTAL=16
+
+virt_type="macsec"
+VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-100}
+
+. ipsec_lib.sh
+. virt_lib.sh
+
+cleanup()
+{
+	cleanup_vifaces
+	tst_rhost_run -c "ip link delete ltp_v0 2>/dev/null"
+
+	tst_ipsec_cleanup
+}
+TST_CLEANUP="cleanup"
+
+IPSEC_MODE=transport
+IPSEC_PROTO=ah
+tst_resm TINFO "setup IPsec $IPSEC_MODE/$IPSEC_PROTO $EALGO"
+tst_ipsec lhost $(tst_ipaddr) $(tst_ipaddr rhost)
+tst_ipsec rhost $(tst_ipaddr rhost) $(tst_ipaddr)
+
+virt_macsec_setup
+
+virt_netperf_crypto_msg
+
+tst_exit
diff --git a/testcases/network/virt/macsec02.sh b/testcases/network/virt/macsec02.sh
new file mode 100755
index 0000000..006398b
--- /dev/null
+++ b/testcases/network/virt/macsec02.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+# Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+#
+# Test-case: setup two MACsec drivers and run TCP traffic over them
+# with enabled frame encryption and replay protection, compare
+# performance with similar IPsec configuration on master interface.
+
+TCID=macsec02
+TST_TOTAL=16
+
+virt_type="macsec"
+VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-100}
+
+. ipsec_lib.sh
+. virt_lib.sh
+
+cleanup()
+{
+	cleanup_vifaces
+	tst_rhost_run -c "ip link delete ltp_v0 2>/dev/null"
+
+	tst_ipsec_cleanup
+}
+TST_CLEANUP="cleanup"
+
+IPSEC_MODE=transport
+IPSEC_PROTO=esp_aead
+EALGO=aes
+tst_resm TINFO "setup IPsec $IPSEC_MODE/$IPSEC_PROTO $EALGO"
+tst_ipsec lhost $(tst_ipaddr) $(tst_ipaddr rhost)
+tst_ipsec rhost $(tst_ipaddr rhost) $(tst_ipaddr)
+
+virt_macsec_setup "replay on window 300 encrypt on protect on"
+virt_netperf_crypto_msg
+
+tst_exit
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 39a0ce9..e66289a 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -313,6 +313,43 @@ virt_check_cmd()
 	return 0
 }
 
+# virt_macsec_setup [OPTIONS]
+# OPTIONS - [ cipher { default | gcm-aes-128 } ] [ encrypt { on | off } ]
+#           [ protect { on | off } ] [ replay { on | off } ] [ window WINDOW ]
+#           [ validate { strict | check | disabled } ]
+virt_macsec_setup()
+{
+	local keyid0=01
+	local keyid1=02
+	local sa=0
+	local h0=$(tst_hwaddr)
+	local h1=$(tst_hwaddr rhost)
+	local cmd="ip macsec add ltp_v0"
+	local key0="01234567890123456789012345678901"
+	local key1="98765432109876543210987612343434"
+
+	virt_setup "icvlen 16 encodingsa $sa $@"
+
+	ROD $cmd tx sa $sa pn 100 on key $keyid0 $key0
+	ROD $cmd rx address $h1 port 1
+	ROD $cmd rx address $h1 port 1 sa $sa pn 100 on key $keyid1 $key1
+
+	tst_rhost_run -s -c "$cmd tx sa $sa pn 100 on key $keyid1 $key1"
+	tst_rhost_run -s -c "$cmd rx address $h0 port 1"
+	tst_rhost_run -s -c \
+		"$cmd rx address $h0 port 1 sa $sa pn 100 on key $keyid0 $key0"
+}
+
+virt_netperf_crypto_msg()
+{
+	local sizes="${@:-100 1000 2000 10000}"
+	client_requests=20000
+
+	for s in $sizes; do
+		virt_compare_netperf pass "-n $s -N $s"
+	done
+}
+
 # Check if we can create then delete virtual interface n times.
 # virt_test_01 [OPTIONS]
 # OPTIONS - different options separated by comma.
-- 
1.7.1

