From: Petr Vorel <pvorel@suse.cz>
Date: Sat, 26 May 2018 13:15:44 +0200
Subject: [LTP] [PATCH 3/4] net: Allow to skip additional getopts
In-Reply-To: <20180526111545.20521-1-pvorel@suse.cz>
References: <20180526111545.20521-1-pvorel@suse.cz>
Message-ID: <20180526111545.20521-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Network libraries which use tst_test.sh allow to avoid setting their
additional getopts. With TST_NET_SKIP_PARSE_ARGS=1 only -6 from
tst_net.sh is handled (for both new and legacy API) and -h and -i from
tst_test.sh (for new API only).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Not sure if this is useful. Meant for next commit.
---
 testcases/lib/tst_net.sh                           | 3 ++-
 testcases/lib/tst_test.sh                          | 2 +-
 testcases/network/nfs/nfs_stress/nfs_lib.sh        | 6 ++++--
 testcases/network/stress/ipsec/ipsec_lib.sh        | 6 ++++--
 testcases/network/tcp_fastopen/tcp_fastopen_run.sh | 6 ++++--
 testcases/network/virt/virt_lib.sh                 | 6 ++++--
 6 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index fd2eacf2f..51d02c682 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -35,7 +35,8 @@ tst_net_parse_args()
 {
 	case $1 in
 	6) TST_IPV6=6 ipver=6;;
-	*) $TST_PARSE_ARGS_CALLER "$1" "$2";;
+	*) [ -z "$TST_NET_SKIP_PARSE_ARGS" -o "$1" = "i" -o "$1" = "h" ] && \
+		$TST_PARSE_ARGS_CALLER "$1" "$2";;
 	esac
 }
 
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 779383392..a3d238d88 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -255,7 +255,7 @@ tst_run()
 			OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
 			NEEDS_ROOT|NEEDS_TMPDIR|NEEDS_DEVICE|DEVICE);;
 			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
-			IPV6);;
+			IPV6|NET_SKIP_PARSE_ARGS);;
 			*) tst_res TWARN "Reserved variable TST_$tst_i used!";;
 			esac
 		done
diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index e378c5515..846605ff5 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -37,8 +37,10 @@ nfs_parse_args()
 	esac
 }
 
-TST_OPTS="${TST_OPTS:-hv:t:}"
-TST_PARSE_ARGS="${TST_PARSE_ARGS:-nfs_parse_args}"
+if [ -z "$TST_NET_SKIP_PARSE_ARGS" ]; then
+	TST_OPTS="${TST_OPTS:-hv:t:}"
+	TST_PARSE_ARGS="${TST_PARSE_ARGS:-nfs_parse_args}"
+fi
 
 TST_USE_LEGACY_API=1
 . tst_net.sh
diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index 28a2de5e8..78e36d043 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -67,8 +67,10 @@ ipsec_lib_parse_args()
 	esac
 }
 
-TST_OPTS="${TST_OPTS:-hl:m:p:s:S:k:A:e:a:c:r:}"
-TST_PARSE_ARGS="${TST_PARSE_ARGS:-ipsec_lib_parse_args}"
+if [ -z "$TST_NET_SKIP_PARSE_ARGS" ]; then
+	TST_OPTS="${TST_OPTS:-hl:m:p:s:S:k:A:e:a:c:r:}"
+	TST_PARSE_ARGS="${TST_PARSE_ARGS:-ipsec_lib_parse_args}"
+fi
 
 TST_USE_LEGACY_API=1
 . tst_net.sh
diff --git a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
index 45219b95a..4a28bff37 100755
--- a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
+++ b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
@@ -39,8 +39,10 @@ TST_TOTAL=1
 TCID="tcp_fastopen"
 TST_NEEDS_TMPDIR=1
 
-TST_OPTS="${TST_OPTS:-hr:n:R:}"
-TST_PARSE_ARGS="${TST_PARSE_ARGS:-tcp_fastopen_parse_args}"
+if [ -z "$TST_NET_SKIP_PARSE_ARGS" ]; then
+	TST_OPTS="${TST_OPTS:-hr:n:R:}"
+	TST_PARSE_ARGS="${TST_PARSE_ARGS:-tcp_fastopen_parse_args}"
+fi
 
 TST_USE_LEGACY_API=1
 . tst_net.sh
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 3523fb663..0fc299e64 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -48,8 +48,10 @@ virt_lib_parse_args()
 	esac
 }
 
-TST_OPTS="${TST_OPTS:-hi:d:}"
-TST_PARSE_ARGS="${TST_PARSE_ARGS:-virt_lib_parse_args}"
+if [ -z "$TST_NET_SKIP_PARSE_ARGS" ]; then
+	TST_OPTS="${TST_OPTS:-hi:d:}"
+	TST_PARSE_ARGS="${TST_PARSE_ARGS:-virt_lib_parse_args}"
+fi
 
 TST_USE_LEGACY_API=1
 . tst_net.sh
-- 
2.16.3

