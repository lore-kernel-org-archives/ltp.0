From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 17 Jun 2020 18:49:26 +0300
Subject: [LTP] [PATCH] network/nsf_lib.sh: TCONF on mount (udp/udp6) failure
 for Linux v5.6+
Message-ID: <20200617154926.32588-1-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Most likely support is disabled with NFS_DISABLE_UDP_SUPPORT config
option (default y).
commit b24ee6c64ca7 ("NFS: allow deprecation of NFS UDP protocol")

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/nfs/nfs_stress/nfs_lib.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index e236cd485..1bd057717 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -87,11 +87,17 @@ nfs_mount()
 
 	tst_res TINFO "Mounting NFS: $mnt_cmd"
 	if [ -n "$LTP_NETNS" ] && [ -z "$LTP_NFS_NETNS_USE_LO" ]; then
-		tst_rhost_run -s -c "$mnt_cmd"
-		return
+		tst_rhost_run -c "$mnt_cmd"
+	else
+		$mnt_cmd > /dev/null
 	fi
 
-	ROD $mnt_cmd
+	if [ $? -ne 0 ]; then
+		if [ "$type" = "udp" -o "$type" = "udp6" ] && tst_kvcmp -ge 5.6; then
+			tst_brk TCONF "UDP support disabled with the kernel config NFS_DISABLE_UDP_SUPPORT?"
+		fi
+		tst_brk TBROK "mount command failed"
+	fi
 }
 
 nfs_setup()
-- 
2.20.1

