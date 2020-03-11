From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 11 Mar 2020 18:50:09 +0100
Subject: [LTP] [PATCH v2 1/3] nfs_lib: Unify remote directory creation
Message-ID: <20200311175011.12171-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

remote directory creation can be done by tst_rhost_run() also on netns.
This simplifies code a bit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1-v2:
* remove changes in nfs_mount() (to keep using netns)

 testcases/network/nfs/nfs_stress/nfs_lib.sh | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index 66f2fb038..f233976c7 100644
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
-- 
2.25.1

