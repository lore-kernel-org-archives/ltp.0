From: Petr Vorel <pvorel@suse.cz>
Date: Sat, 26 May 2018 13:15:43 +0200
Subject: [LTP] [PATCH 2/4] net: Allow to overwrite libraries getopts handlers
In-Reply-To: <20180526111545.20521-1-pvorel@suse.cz>
References: <20180526111545.20521-1-pvorel@suse.cz>
Message-ID: <20180526111545.20521-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Network libraries recently started to use TST_OPTS and TST_PARSE_ARGS:
89a83d8a0 ("net/ipsec_lib.sh: Process getopts parameters with TST_OPTS
and TST_PARSE_ARGS")
ce920a5a4 "network/virt_lib.sh: Process getopts parameters with TST_OPTS
and TST_PARSE_ARGS"
5f088c3f4 ("nfs/nfs_lib.sh: Fix wrong getopts parameter handling")

This allows to test using these libs customize getopts.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Needed for rewriting into new API.
---
 testcases/network/nfs/nfs_stress/nfs_lib.sh        | 4 ++--
 testcases/network/stress/ipsec/ipsec_lib.sh        | 5 +++--
 testcases/network/tcp_fastopen/tcp_fastopen_run.sh | 4 ++--
 testcases/network/virt/virt_lib.sh                 | 4 ++--
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index 5a3ad04bd..e378c5515 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -37,8 +37,8 @@ nfs_parse_args()
 	esac
 }
 
-TST_OPTS="hv:t:"
-TST_PARSE_ARGS=nfs_parse_args
+TST_OPTS="${TST_OPTS:-hv:t:}"
+TST_PARSE_ARGS="${TST_PARSE_ARGS:-nfs_parse_args}"
 
 TST_USE_LEGACY_API=1
 . tst_net.sh
diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index 480fe064a..28a2de5e8 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -67,8 +67,9 @@ ipsec_lib_parse_args()
 	esac
 }
 
-TST_OPTS="hl:m:p:s:S:k:A:e:a:c:r:"
-TST_PARSE_ARGS=ipsec_lib_parse_args
+TST_OPTS="${TST_OPTS:-hl:m:p:s:S:k:A:e:a:c:r:}"
+TST_PARSE_ARGS="${TST_PARSE_ARGS:-ipsec_lib_parse_args}"
+
 TST_USE_LEGACY_API=1
 . tst_net.sh
 
diff --git a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
index 8d6aa8450..45219b95a 100755
--- a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
+++ b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
@@ -39,8 +39,8 @@ TST_TOTAL=1
 TCID="tcp_fastopen"
 TST_NEEDS_TMPDIR=1
 
-TST_OPTS="hr:n:R:"
-TST_PARSE_ARGS=tcp_fastopen_parse_args
+TST_OPTS="${TST_OPTS:-hr:n:R:}"
+TST_PARSE_ARGS="${TST_PARSE_ARGS:-tcp_fastopen_parse_args}"
 
 TST_USE_LEGACY_API=1
 . tst_net.sh
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 00978a062..3523fb663 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -48,8 +48,8 @@ virt_lib_parse_args()
 	esac
 }
 
-TST_OPTS="hi:d:"
-TST_PARSE_ARGS=virt_lib_parse_args
+TST_OPTS="${TST_OPTS:-hi:d:}"
+TST_PARSE_ARGS="${TST_PARSE_ARGS:-virt_lib_parse_args}"
 
 TST_USE_LEGACY_API=1
 . tst_net.sh
-- 
2.16.3

