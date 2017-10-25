From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 25 Oct 2017 19:11:59 +0300
Subject: [LTP] [PATCH 4/4] tcp_fastopen: new test-case with
	TCP_FASTOPEN_CONNECT
In-Reply-To: <1508947919-3553-1-git-send-email-alexey.kodanev@oracle.com>
References: <1508947919-3553-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1508947919-3553-4-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also add minor delay (0.1ms) on client for each packet to amplify
performance difference when enabling TCP Fastopen. After that we
can reduce number of requests - it will no affect results.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/tcp_fastopen/tcp_fastopen_run.sh |   34 +++++++++++++++-----
 1 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
index 5ca8c56..b06192e 100755
--- a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
+++ b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-# Copyright (c) 2014-2016 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -22,7 +22,7 @@
 user_name="root"
 use_ssh=0
 clients_num=2
-client_requests=2000000
+client_requests=500000
 max_requests=3
 
 TST_TOTAL=1
@@ -58,6 +58,18 @@ done
 cleanup()
 {
 	tst_rmdir
+	tc qdisc del dev $(tst_iface) root netem delay 100 >/dev/null
+}
+
+compare()
+{
+	tfo_cmp=$(( 100 - ($time_tfo_on * 100) / $time_tfo_off ))
+
+	if [ "$tfo_cmp" -lt 3 ]; then
+		tst_resm TFAIL "$1 perf result is '$tfo_cmp' percent"
+	else
+		tst_resm TPASS "$1 perf result is '$tfo_cmp' percent"
+	fi
 }
 
 tst_require_root
@@ -73,6 +85,8 @@ fi
 trap "tst_brkm TBROK 'test interrupted'" INT
 TST_CLEANUP="cleanup"
 
+ROD tc qdisc add dev $(tst_iface) root netem delay 100
+
 tst_resm TINFO "using old TCP API and set tcp_fastopen to '0'"
 tst_netload -H $(tst_ipaddr rhost) -a $clients_num -r $client_requests \
 	-R $max_requests -t 0
@@ -83,12 +97,16 @@ tst_netload -H $(tst_ipaddr rhost)  -a $clients_num -r $client_requests \
 	-R $max_requests -f -t 3
 time_tfo_on=$(cat tst_netload.res)
 
-tfo_cmp=$(( 100 - ($time_tfo_on * 100) / $time_tfo_off ))
+compare
 
-if [ "$tfo_cmp" -lt 3 ]; then
-	tst_resm TFAIL "TFO performance result is '$tfo_cmp' percent"
-else
-	tst_resm TPASS "TFO performance result is '$tfo_cmp' percent"
-fi
+tst_kvcmp -lt "4.11" && \
+	tst_brkm TCONF "next test must be run with kernel 4.11 or newer"
+
+tst_resm TINFO "using connect() and TCP_FASTOPEN_CONNECT socket option"
+tst_netload -H $(tst_ipaddr rhost) -a $clients_num -r $client_requests \
+	-R $max_requests -F -t 3
+time_tfo_on=$(cat tst_netload.res)
+
+compare
 
 tst_exit
-- 
1.7.1

