From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  4 Aug 2016 13:33:18 +0300
Subject: [LTP] [PATCH 1/2] network/nfs_lib: add support for multiple mounts
Message-ID: <1470306799-10970-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Keep previous behaviour as well as adding an option to create multiple
NFS mounts (the same or different), e.g.:

nfs_test.sh -v "3 4.1 4.1 4.2" -t "udp tcp tcp tcp"

NFS server exports:
  * /3/udp
  * /4.1/tcp
  * /4.2/tcp

NFS client mounts:
  * /3/0
  * /4.1/1
  * /4.1/2
  * /4.2/3

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/nfs/nfs_stress/nfs_lib.sh |   95 +++++++++++++++++++--------
 1 files changed, 67 insertions(+), 28 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index aca150d..eef387f 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -39,10 +39,21 @@ while getopts :ht:v:6 opt; do
 	esac
 done
 
-nfs_setup()
+get_socket_type()
 {
-	SOCKET_TYPE="${SOCKET_TYPE}${TST_IPV6}"
+	local t
+	local k=0
+	for t in $SOCKET_TYPE; do
+		if [ "$k" -eq "$1" ]; then
+			echo "${t}${TST_IPV6}"
+			return
+		fi
+		k=$(( k + 1 ))
+	done
+}
 
+nfs_setup()
+{
 	tst_check_cmds mount exportfs
 
 	tst_tmpdir
@@ -52,42 +63,70 @@ nfs_setup()
 		tst_brkm TCONF "Cannot run nfs-stress test on mounted NFS"
 	fi
 
-	tst_resm TINFO "NFS_TYPE: $NFS_TYPE, NFS VERSION: $VERSION"
-	tst_resm TINFO "NFILES: $NFILES, SOCKET_TYPE: $SOCKET_TYPE"
+	local i
+	local type
+	local n=0
+	local opts
+	local local_dir
+	local remote_dir
+	local mount_dir
+	for i in $VERSION; do
+		type=$(get_socket_type $n)
+		tst_resm TINFO "setup NFSv$i, socket type $type"
 
-	if [ "$NFS_TYPE" != "nfs4" ]; then
-		OPTS=${OPTS:="-o proto=$SOCKET_TYPE,vers=$VERSION "}
-	fi
+		local_dir="$TST_TMPDIR/$i/$n"
+		remote_dir="$TST_TMPDIR/$i/$type"
 
-	tst_rhost_run -s -c "mkdir -p $TST_TMPDIR"
+		mkdir -p $local_dir
 
-	if [ $TST_IPV6 ]; then
-		REMOTE_DIR="[$(tst_ipaddr rhost)]:$TST_TMPDIR"
-	else
-		REMOTE_DIR="$(tst_ipaddr rhost):$TST_TMPDIR"
-	fi
+		tst_rhost_run -c "test -d $remote_dir"
+		if [ "$?" -ne 0  ]; then
+			tst_rhost_run -s -c "mkdir -p $remote_dir"
+			tst_rhost_run -s -c "exportfs -i -o no_root_squash,rw \
+				*:$remote_dir"
+		fi
 
-	if [ "$NFS_TYPE" = "nfs4" ]; then
-		tst_rhost_run -s -c "mkdir -p /export$TST_TMPDIR"
-		tst_rhost_run -s -c "mount --bind $TST_TMPDIR /export$TST_TMPDIR"
-		tst_rhost_run -s -c "exportfs -o no_root_squash,rw,nohide,\
-			insecure,no_subtree_check *:$TST_TMPDIR"
-	else
-		tst_rhost_run -s -c "exportfs -i -o no_root_squash,rw \
-			*:$TST_TMPDIR"
-	fi
+		opts="-o proto=$type,vers=$i"
+
+		if [ $TST_IPV6 ]; then
+			mount_dir="[$(tst_ipaddr rhost)]:$remote_dir"
+		else
+			mount_dir="$(tst_ipaddr rhost):$remote_dir"
+		fi
 
-	tst_resm TINFO "Mounting NFS '$REMOTE_DIR' with options '$OPTS'"
-	ROD mount -t $NFS_TYPE $OPTS $REMOTE_DIR $TST_TMPDIR
-	cd $TST_TMPDIR
+
+		tst_resm TINFO "Mounting NFS '$mount_dir'"
+		tst_resm TINFO "to '$local_dir' with options '$opts'"
+
+		ROD mount -t nfs $opts $mount_dir $local_dir
+
+		n=$(( n + 1 ))
+	done
+
+	if [ "$n" -eq 1 ]; then
+		cd ${VERSION}/0
+	fi
 }
 
 nfs_cleanup()
 {
 	tst_resm TINFO "Cleaning up testcase"
 	cd $LTPROOT
-	grep -q "$TST_TMPDIR" /proc/mounts && umount $TST_TMPDIR
 
-	tst_rhost_run -c "exportfs -u *:$TST_TMPDIR"
-	tst_rhost_run -c "rm -rf $TST_TMPDIR"
+	local i
+	local n=0
+	local type
+	local local_dir
+	local remote_dir
+	for i in $VERSION; do
+		type=$(get_socket_type $n)
+
+		local_dir="$TST_TMPDIR/$i/$n"
+		remote_dir="$TST_TMPDIR/$i/$type"
+
+		grep -q "$local_dir" /proc/mounts && umount $local_dir
+		tst_rhost_run -c "test -d $remote_dir && exportfs -u *:$remote_dir"
+		tst_rhost_run -c "test -d $remote_dir && rm -rf $remote_dir"
+		n=$(( n + 1 ))
+	done
 }
-- 
1.7.1

