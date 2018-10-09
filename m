From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  9 Oct 2018 16:17:59 +0300
Subject: [LTP] [PATCH] network/nfs: support default setup, use local mount
Message-ID: <1539091079-21887-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For default setup, start the server locally instead and mount
inside netns to run NFS traffic over the veth or whatever is
used for a single machine setup.

We could also use lo interface, we just need to skip the last
check in nfs_mount()/nfs_lib.sh.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/nfs/nfs_stress/nfs_lib.sh |   63 +++++++++++++++++++--------
 1 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index 7e11dc4..28b73e1 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -46,6 +46,47 @@ get_socket_type()
 	done
 }
 
+nfs_setup_server()
+{
+	local export_cmd="exportfs -i -o no_root_squash,rw *:$remote_dir"
+
+	if [ -n "$LTP_NETNS" ]; then
+		if [ ! -d $remote_dir ]; then
+			mkdir -p $remote_dir
+			ROD $export_cmd
+		fi
+		return
+	fi
+
+	if ! tst_rhost_run -c "test -d $remote_dir"; then
+		tst_rhost_run -s -c "mkdir -p $remote_dir; $export_cmd"
+	fi
+}
+
+nfs_mount()
+{
+	local host_type=rhost
+	local mount_dir
+
+	[ -n "$LTP_NETNS" ] && host_type=
+
+	if [ $TST_IPV6 ]; then
+		mount_dir="[$(tst_ipaddr $host_type)]:$remote_dir"
+	else
+		mount_dir="$(tst_ipaddr $host_type):$remote_dir"
+	fi
+
+	local mnt_cmd="mount -t nfs $opts $mount_dir $local_dir"
+
+	tst_res TINFO "Mounting NFS: $mnt_cmd"
+	if [ -n "$LTP_NETNS" ]; then
+		tst_rhost_run -s -c "$mnt_cmd"
+		return
+	fi
+
+	ROD $mnt_cmd
+}
+
 nfs_setup()
 {
 	# Check if current filesystem is NFS
@@ -60,35 +101,19 @@ nfs_setup()
 	local local_dir
 	local remote_dir
 	local mount_dir
+
 	for i in $VERSION; do
 		type=$(get_socket_type $n)
 		tst_res TINFO "setup NFSv$i, socket type $type"
 
 		local_dir="$TST_TMPDIR/$i/$n"
 		remote_dir="$TST_TMPDIR/$i/$type"
-
 		mkdir -p $local_dir
 
-		tst_rhost_run -c "test -d $remote_dir"
-		if [ "$?" -ne 0  ]; then
-			tst_rhost_run -s -c "mkdir -p $remote_dir"
-			tst_rhost_run -s -c "exportfs -i -o no_root_squash,rw \
-				*:$remote_dir"
-		fi
+		nfs_setup_server
 
 		opts="-o proto=$type,vers=$i"
-
-		if [ $TST_IPV6 ]; then
-			mount_dir="[$(tst_ipaddr rhost)]:$remote_dir"
-		else
-			mount_dir="$(tst_ipaddr rhost):$remote_dir"
-		fi
-
-
-		tst_res TINFO "Mounting NFS '$mount_dir'"
-		tst_res TINFO "to '$local_dir' with options '$opts'"
-
-		ROD mount -t nfs $opts $mount_dir $local_dir
+		nfs_mount
 
 		n=$(( n + 1 ))
 	done
-- 
1.7.1

