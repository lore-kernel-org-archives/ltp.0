From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 26 May 2021 19:25:03 +0200
Subject: [LTP] [LTP PATCH v2 3/3] nfs_lib.sh: Check running rpc.mountd,
 rpc.statd
In-Reply-To: <20210526172503.18621-1-pvorel@suse.cz>
References: <20210526172503.18621-1-pvorel@suse.cz>
Message-ID: <20210526172503.18621-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

NOTE: we're not checking rpcbind/portmap which is required for NFSv3,
as it's rpc.mountd dependency.

Deliberately not add pgrep as required dependency.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v1->v2:
* check for rpc.mountd, rpc.statd
(previsously checked for rpc.mountd, rpcbind/portmap)

 testcases/network/nfs/nfs_stress/nfs_lib.sh | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index 26b670c35..9bef1b86a 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -27,7 +27,7 @@ TST_PARSE_ARGS=nfs_parse_args
 TST_USAGE=nfs_usage
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
-TST_NEEDS_CMDS="$TST_NEEDS_CMDS mount exportfs"
+TST_NEEDS_CMDS="$TST_NEEDS_CMDS exportfs mount"
 TST_SETUP="${TST_SETUP:-nfs_setup}"
 TST_CLEANUP="${TST_CLEANUP:-nfs_cleanup}"
 TST_NEEDS_DRIVERS="nfsd"
@@ -110,11 +110,6 @@ nfs_mount()
 
 nfs_setup()
 {
-	# Check if current filesystem is NFS
-	if [ "$(stat -f . | grep "Type: nfs")" ]; then
-		tst_brk TCONF "Cannot run nfs-stress test on mounted NFS"
-	fi
-
 	local i
 	local type
 	local n=0
@@ -123,6 +118,16 @@ nfs_setup()
 	local remote_dir
 	local mount_dir
 
+	if [ "$(stat -f . | grep "Type: nfs")" ]; then
+		tst_brk TCONF "Cannot run nfs-stress test on mounted NFS"
+	fi
+
+	if tst_cmd_available pgrep; then
+		for i in rpc.mountd rpc.statd; do
+			pgrep $i > /dev/null || tst_brk TCONF "$i not running"
+		done
+	fi
+
 	for i in $VERSION; do
 		type=$(get_socket_type $n)
 		tst_res TINFO "setup NFSv$i, socket type $type"
-- 
2.31.1

