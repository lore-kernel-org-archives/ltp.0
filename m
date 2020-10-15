From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 15 Oct 2020 15:20:56 +0300
Subject: [LTP] [PATCH 5/5] network/virt: add wireguard02: ipsec vs wireguard
In-Reply-To: <20201015122056.20715-1-alexey.kodanev@oracle.com>
References: <20201015122056.20715-1-alexey.kodanev@oracle.com>
Message-ID: <20201015122056.20715-5-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Compare multi-threading performance with IPSec/vti.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net.features                  |  2 ++
 testcases/lib/tst_test.sh             |  2 +-
 testcases/network/virt/wireguard02.sh | 48 +++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100755 testcases/network/virt/wireguard02.sh

diff --git a/runtest/net.features b/runtest/net.features
index c5a1ba714..617a6b91e 100644
--- a/runtest/net.features
+++ b/runtest/net.features
@@ -81,3 +81,5 @@ fanout01 fanout01
 
 wireguard01 wireguard01.sh
 wireguard01_ipv6 wireguard01.sh -6
+wireguard02 wireguard02.sh
+wireguard02_ipv6 wireguard02.sh -6
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index f2bd1e3ef..2417da140 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -506,7 +506,7 @@ tst_run()
 			NEEDS_DRIVERS|FS_TYPE|MNTPOINT|MNT_PARAMS);;
 			IPV6|IPVER|TEST_DATA|TEST_DATA_IFS);;
 			RETRY_FUNC|RETRY_FN_EXP_BACKOFF|TIMEOUT);;
-			NET_DATAROOT|NET_MAX_PKT|NET_RHOST_RUN_DEBUG);;
+			NET_DATAROOT|NET_MAX_PKT|NET_RHOST_RUN_DEBUG|NETLOAD_CLN_NUMBER);;
 			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
 			esac
 		done
diff --git a/testcases/network/virt/wireguard02.sh b/testcases/network/virt/wireguard02.sh
new file mode 100755
index 000000000..c16ae68d1
--- /dev/null
+++ b/testcases/network/virt/wireguard02.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2020 Oracle and/or its affiliates. All Rights Reserved.
+
+TST_CLEANUP=cleanup
+TST_TESTFUNC=test1
+TST_SETUP=wireguard_lib_setup
+
+. ipsec_lib.sh
+. wireguard_lib.sh
+
+IPSEC_MODE="tunnel"
+IPSEC_PROTO="esp_aead"
+AEALGO="rfc4106_256"
+EALGO="aes"
+AALGO="sha256"
+
+cleanup()
+{
+	wireguard_lib_cleanup
+	tst_ipsec_cleanup
+}
+
+test1()
+{
+	local wgaddr
+	local clients_num="$TST_NETLOAD_CLN_NUMBER"
+
+	# Enforce multi-threading test, at least with 10 TCP clients
+	[ $clients_num -lt 10 ] && clients_num=10
+
+	tst_res TINFO "test wireguard"
+
+	[ -n "$TST_IPV6" ] && wgaddr="$ip6_virt_remote" || wgaddr="$ip_virt_remote"
+	tst_netload -H $wgaddr -a $clients_num -D ltp_v0
+	local time_wg=$(cat tst_netload.res)
+	wireguard_lib_cleanup
+
+	tst_res TINFO "test IPSec $IPSEC_MODE/$IPSEC_PROTO $EALGO"
+	tst_ipsec_setup_vti
+	tst_netload -H $ip_rmt_tun -a $clients_num -D $tst_vti
+	local time_ipsec=$(cat tst_netload.res)
+	tst_ipsec_cleanup
+
+	tst_netload_compare $time_ipsec $time_wg -100
+}
+
+tst_run
-- 
2.20.1

