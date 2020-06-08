From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 8 Jun 2020 22:27:44 +0800
Subject: [LTP] [PATCH] network/nfs_lib.sh: Use double quotes for grep pattern
Message-ID: <20200608142744.274287-1-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

sh -c 'grep -q '^[# ]*udp *= *y' ...' in nfs_server_udp_enabled()
cannot processe nested single quotes correctly if rsh/ssh is used
and gets the error:
--------------------------------------------
grep: Unmatched [ or [^ (or grep: Unmatched [, [^, [:, [., or [=)
nfs01 1 TCONF: UDP support disabled on NFS server
--------------------------------------------

This issue make many NFS tests including UDP become TCONF even
if NFS supports UDP so use double quotes inside to fix it.

Fixes: 0f1c36c51 ("nfs: Detect disabled UDP")
Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/network/nfs/nfs_stress/nfs_lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index f7eb57d66..e236cd485 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -58,7 +58,7 @@ nfs_server_udp_enabled()
 	tst_rhost_run -c "[ -f /etc/nfs.conf ]" || return 0
 	config=$(tst_rhost_run -c 'for f in $(grep ^include.*= '/etc/nfs.conf' | cut -d = -f2); do [ -f $f ] && printf "$f "; done')
 
-	tst_rhost_run -c "grep -q '^[# ]*udp *= *y' /etc/nfs.conf $config"
+	tst_rhost_run -c "grep -q \"^[# ]*udp *= *y\" /etc/nfs.conf $config"
 }
 
 nfs_setup_server()
-- 
2.25.1



