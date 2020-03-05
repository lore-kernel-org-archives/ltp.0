From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  5 Mar 2020 20:27:15 +0100
Subject: [LTP] [PATCH 1/2] nfs_lib: Unify testing on netns
Message-ID: <20200305192716.10313-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There is no need to run tests on opposite client/server when using
$TST_USE_NETNS based setup. It's enough just to set lhost IP address.
This simplifies code a bit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/nfs/nfs_stress/nfs_lib.sh | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index 66f2fb038..2d5535dc5 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -50,14 +50,6 @@ nfs_setup_server()
 {
 	local export_cmd="exportfs -i -o fsid=$$,no_root_squash,rw *:$remote_dir"
 
-	if [ -n "$LTP_NETNS" ]; then
-		if [ ! -d $remote_dir ]; then
-			mkdir -p $remote_dir
-			ROD $export_cmd
-		fi
-		return
-	fi
-
 	if ! tst_rhost_run -c "test -d $remote_dir"; then
 		tst_rhost_run -s -c "mkdir -p $remote_dir; $export_cmd"
 	fi
@@ -79,11 +71,6 @@ nfs_mount()
 	local mnt_cmd="mount -t nfs $opts $mount_dir $local_dir"
 
 	tst_res TINFO "Mounting NFS: $mnt_cmd"
-	if [ -n "$LTP_NETNS" ]; then
-		tst_rhost_run -s -c "$mnt_cmd"
-		return
-	fi
-
 	ROD $mnt_cmd
 }
 
-- 
2.25.1

