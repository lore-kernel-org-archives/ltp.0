From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed,  3 May 2017 17:51:33 +0300
Subject: [LTP] [PATCH] net: use LTP ns_create/ns_exec to support OS with
	legacy iproute
Message-ID: <1493823093-21485-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh |   31 +++++++++++++++++++++++++------
 1 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 3c5f068..c1bd731 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Copyright (c) 2014-2016 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) 2016-2017 Petr Vorel <pvorel@suse.cz>
 #
 # This program is free software; you can redistribute it and/or
@@ -23,18 +23,37 @@
 
 init_ltp_netspace()
 {
+	local pid=
+
 	if [ ! -f /var/run/netns/ltp_ns ]; then
-		ROD ip net add ltp_ns
-		ROD ip li add name ltp_ns_veth1 type veth peer name ltp_ns_veth2
-		ROD ip li set dev ltp_ns_veth1 netns ltp_ns
-		ROD ip netns exec ltp_ns ip li set lo up
+		if ! ip netns list >/dev/null 2>&1; then
+			pid="$(ROD ns_create net,mnt)"
+			mkdir -p /var/run/netns
+			ROD ln -s /proc/$pid/ns/net /var/run/netns/ltp_ns
+			ROD ns_exec $pid net,mnt umount /sys
+			ROD ns_exec $pid net,mnt mount -t sysfs none /sys
+			ROD ip li add name ltp_ns_veth1 type veth peer name ltp_ns_veth2
+			ROD ns_ifmove ltp_ns_veth1 $pid
+			ROD ns_exec $pid net,mnt ip li set lo up
+		else
+			ROD ip net add ltp_ns
+			ROD ip li add name ltp_ns_veth1 type veth peer name ltp_ns_veth2
+			ROD ip li set dev ltp_ns_veth1 netns ltp_ns
+			ROD ip netns exec ltp_ns ip li set lo up
+		fi
 	fi
 
 	LHOST_IFACES="${LHOST_IFACES:-ltp_ns_veth2}"
 	RHOST_IFACES="${RHOST_IFACES:-ltp_ns_veth1}"
 
 	export TST_INIT_NETNS="no"
-	export LTP_NETNS="${LTP_NETNS:-ip netns exec ltp_ns}"
+
+	if [ -h /var/run/netns/ltp_ns ]; then
+		pid="$(echo $(readlink /var/run/netns/ltp_ns) | cut -f3 -d'/')"
+		export LTP_NETNS="${LTP_NETNS:-ns_exec $pid net,mnt}"
+	else
+		export LTP_NETNS="${LTP_NETNS:-ip netns exec ltp_ns}"
+	fi
 
 	tst_restore_ipaddr
 	tst_restore_ipaddr rhost
-- 
1.7.1

