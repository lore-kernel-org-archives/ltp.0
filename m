From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 11 Mar 2020 18:50:11 +0100
Subject: [LTP] [PATCH v2 3/3] nfs_lib: Add option to run traffic via lo on
 netns
In-Reply-To: <20200311175011.12171-1-pvorel@suse.cz>
References: <20200311175011.12171-1-pvorel@suse.cz>
Message-ID: <20200311175011.12171-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When $LTP_NFS_NETNS_USE_LO set and test is using netns ($TST_USE_NETNS
set) NFS traffic will go through lo interface instead of ltp_ns_veth*
netns interfaces. This can be useful for debugging whether test failures
are related to veth/netns.

Suggested-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1-v2:
* new commit

 testcases/network/nfs/nfs_stress/nfs_lib.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index 3d447783d..b7c372afb 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -31,6 +31,11 @@ TST_NEEDS_CMDS="$TST_NEEDS_CMDS mount exportfs"
 TST_SETUP="${TST_SETUP:-nfs_setup}"
 TST_CLEANUP="${TST_CLEANUP:-nfs_cleanup}"
 
+# When set and test is using netns ($TST_USE_NETNS set) NFS traffic will go
+# through lo interface instead of ltp_ns_veth* netns interfaces (useful for
+# debugging whether test failures are related to veth/netns).
+LTP_NFS_NETNS_USE_LO=
+
 . tst_net.sh
 
 get_socket_type()
@@ -52,6 +57,7 @@ nfs_server_udp_enabled()
 
 	tst_rhost_run -c "[ -f /etc/nfs.conf ]" || return 0
 	config=$(tst_rhost_run -c 'for f in $(grep ^include.*= '/etc/nfs.conf' | cut -d = -f2); do [ -f $f ] && printf "$f "; done')
+
 	tst_rhost_run -c "grep -q '^[# ]*udp *= *y' /etc/nfs.conf $config"
 }
 
@@ -80,7 +86,7 @@ nfs_mount()
 	local mnt_cmd="mount -t nfs $opts $mount_dir $local_dir"
 
 	tst_res TINFO "Mounting NFS: $mnt_cmd"
-	if [ -n "$LTP_NETNS" ]; then
+	if [ -n "$LTP_NETNS" ] && [ -z "$LTP_NFS_NETNS_USE_LO" ]; then
 		tst_rhost_run -s -c "$mnt_cmd"
 		return
 	fi
-- 
2.25.1

