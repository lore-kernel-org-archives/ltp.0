From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 25 May 2021 15:50:11 +0200
Subject: [LTP] [PATCH 2/3] nfs_lib.sh: Check running rpc.mountd,
 rpcbind/portmap
In-Reply-To: <20210525135012.877-1-pvorel@suse.cz>
References: <20210525135012.877-1-pvorel@suse.cz>
Message-ID: <20210525135012.877-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Both are required to be running for NFS tests.

This requires to add pgrep dependency, as we don't have custom LTP C
based tool for searching in processes.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/nfs/nfs_stress/nfs_lib.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index 1bd057717..25fe67bda 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -27,7 +27,7 @@ TST_PARSE_ARGS=nfs_parse_args
 TST_USAGE=nfs_usage
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
-TST_NEEDS_CMDS="$TST_NEEDS_CMDS mount exportfs"
+TST_NEEDS_CMDS="$TST_NEEDS_CMDS exportfs mount pgrep"
 TST_SETUP="${TST_SETUP:-nfs_setup}"
 TST_CLEANUP="${TST_CLEANUP:-nfs_cleanup}"
 
@@ -107,6 +107,11 @@ nfs_setup()
 		tst_brk TCONF "Cannot run nfs-stress test on mounted NFS"
 	fi
 
+	pgrep rpc.mountd > /dev/null || \
+		tst_brk TCONF "rpc.mountd not running"
+
+	check_portmap_rpcbind
+
 	local i
 	local type
 	local n=0
-- 
2.31.1

