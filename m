From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 21 May 2018 14:48:30 +0300
Subject: [LTP] [PATCH 6/6] network/tcp_cc: add new test bbr02
In-Reply-To: <1526903310-2833-1-git-send-email-alexey.kodanev@oracle.com>
References: <1526903310-2833-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1526903310-2833-7-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Difference, comparing to bbr01:

* Uses different (not default) qdisc: pfifo_fast, codel, pfifo, fq, hfsc,
  hhf, htb, pie, prio, sfb and sfq.
* Emulates congestion not only with packet loss but with delay, corrupt
  and reorder.

The test expects that 'bbr' congestion-control algorithm not
significantly worse than 'cubic'.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net.features              |    3 ++
 testcases/network/tcp_cc/bbr02.sh |   45 +++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 0 deletions(-)
 create mode 100755 testcases/network/tcp_cc/bbr02.sh

diff --git a/runtest/net.features b/runtest/net.features
index 732c053..eac1b2b 100644
--- a/runtest/net.features
+++ b/runtest/net.features
@@ -4,6 +4,9 @@
 bbr01 bbr01.sh
 bbr01_ipv6 bbr01.sh -6
 
+bbr02 bbr02.sh
+bbr02_ipv6 bbr02.sh -6
+
 bind_noport01 bind_noport01.sh
 bind_noport01_ipv6 bind_noport01.sh -6
 
diff --git a/testcases/network/tcp_cc/bbr02.sh b/testcases/network/tcp_cc/bbr02.sh
new file mode 100755
index 0000000..ca3a9b4
--- /dev/null
+++ b/testcases/network/tcp_cc/bbr02.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Oracle and/or its affiliates. All Rights Reserved.
+
+TST_SETUP="setup"
+TST_TESTFUNC="do_test"
+TST_CLEANUP="cleanup"
+TST_MIN_KVER="4.13"
+
+. tcp_cc_lib.sh
+
+TST_CLEANUP="cleanup"
+
+cleanup()
+{
+	tc qdisc del dev $(tst_iface) root netem
+
+	tcp_cc_cleanup
+}
+
+setup()
+{
+	tcp_cc_setup
+
+	local emu_opts="delay 5ms 1ms 20% loss 0.3% ecn corrupt \
+0.1% reorder 93% 50% limit 10000"
+
+	tst_res TINFO "emulate congestion with packet $emu_opts"
+	ROD tc qdisc add dev $(tst_iface) root netem $emu_opts
+}
+
+do_test()
+{
+	for q in $qdisc_list; do
+		if tc qdisc add $q >/dev/null 2>&1; then
+			tst_res TCONF "$q qdisc not supported"
+			continue
+		fi
+
+		tcp_cc_set_qdisc $q
+		tcp_cc_test01 bbr -50
+	done
+}
+
+tst_run
-- 
1.7.1

