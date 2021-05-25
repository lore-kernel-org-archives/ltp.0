From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 25 May 2021 15:50:12 +0200
Subject: [LTP] [PATCH 3/3] nfs_lib.sh: Print verbose mount info on error
In-Reply-To: <20210525135012.877-1-pvorel@suse.cz>
References: <20210525135012.877-1-pvorel@suse.cz>
Message-ID: <20210525135012.877-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Suggested-by: NeilBrown <neilb@suse.de>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/nfs/nfs_stress/nfs_lib.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index 25fe67bda..fb0f10020 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -83,16 +83,17 @@ nfs_mount()
 		mount_dir="$(tst_ipaddr $host_type):$remote_dir"
 	fi
 
-	local mnt_cmd="mount -t nfs $opts $mount_dir $local_dir"
+	local mnt_cmd="mount -v -t nfs $opts $mount_dir $local_dir"
 
 	tst_res TINFO "Mounting NFS: $mnt_cmd"
 	if [ -n "$LTP_NETNS" ] && [ -z "$LTP_NFS_NETNS_USE_LO" ]; then
-		tst_rhost_run -c "$mnt_cmd"
+		tst_rhost_run -c "$mnt_cmd" > mount.log
 	else
-		$mnt_cmd > /dev/null
+		$mnt_cmd > mount.log
 	fi
 
 	if [ $? -ne 0 ]; then
+		cat mount.log
 		if [ "$type" = "udp" -o "$type" = "udp6" ] && tst_kvcmp -ge 5.6; then
 			tst_brk TCONF "UDP support disabled with the kernel config NFS_DISABLE_UDP_SUPPORT?"
 		fi
-- 
2.31.1

