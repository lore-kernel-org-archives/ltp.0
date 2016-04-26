From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Apr 2016 15:50:55 +0200
Subject: [LTP] [PATCH] fs/isofs.sh: Don't use /etc/ for the image
Message-ID: <20160426135055.GA8512@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The content of /etc/ is not predictable and may cause false possitives.

I recently started to get failures with -J when there are two files with
long names that differ only at the end.

The exact error I got is:

genisoimage: Error:
/etc/zypp/repos.d/SUSE_Linux_Enterprise_Server_12_SP1_x86_64:SLES12-SP1-Debuginfo-Updates.repo
and
/etc/zypp/repos.d/SUSE_Linux_Enterprise_Server_12_SP1_x86_64:SLES12-SP1-Debuginfo-Pool.repo
have the same Joliet name
Joliet tree sort failed.

This patch changes the script to generate filesystem tree instead of
copying content of /etc/.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/fs/iso9660/isofs.sh | 38 ++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/fs/iso9660/isofs.sh b/testcases/kernel/fs/iso9660/isofs.sh
index e4f3093..3533e76 100755
--- a/testcases/kernel/fs/iso9660/isofs.sh
+++ b/testcases/kernel/fs/iso9660/isofs.sh
@@ -32,7 +32,7 @@ NO_CLEANUP=""
 
 usage()
 {
-	echo "USAGE: $0 <optional> -n -h -d [directory name]"
+	echo "USAGE: $0 <optional> -n -h"
 	exit
 }
 
@@ -45,18 +45,34 @@ cleanup()
 	fi
 }
 
+max_depth=3
+max_dirs=4
 
-COPY_DIR="/etc/"
+gen_fs_tree()
+{
+	local cur_path="$1"
+	local cur_depth="$2"
+
+	if [ "$cur_depth" -gt "$max_depth" ]; then
+		return
+	fi
+
+	for i in $(seq 1 $max_dirs); do
+		local new_path="$cur_path/subdir_$i"
+
+		mkdir -p "$new_path"
+
+		dd if=/dev/urandom of="$new_path/file" bs=1024 count=100 &> /dev/null
+
+		gen_fs_tree "$new_path" $((cur_depth + 1))
+	done
+}
 
 while getopts :hnd: arg; do
 	case $arg in
-	d)
-		COPY_DIR=$OPTARG
-		;;
 	h)
 		echo ""
 		echo "n - The directories created will not be removed"
-		echo "d - Specify a directory to copy into /tmp"
 		echo "h - Help options"
 		echo ""
 		usage
@@ -68,22 +84,20 @@ while getopts :hnd: arg; do
 	esac
 done
 
-if [ ! -e "$COPY_DIR" ]; then
-	tst_brkm TCONF "$COPY_DIR not found"
-fi
-
 tst_require_root
 
 tst_tmpdir
 TST_CLEANUP=cleanup
 
 MNT_POINT="$PWD/mnt"
-MAKE_FILE_SYS_DIR="$PWD/tmp/$COPY_DIR"
+MAKE_FILE_SYS_DIR="$PWD/files"
 
 mkdir -p -m 777 $MNT_POINT
 mkdir -p $MAKE_FILE_SYS_DIR
 
-cp -rf $COPY_DIR* $MAKE_FILE_SYS_DIR
+# Generated directories and files
+mkdir -p $MAKE_FILE_SYS_DIR
+gen_fs_tree "$MAKE_FILE_SYS_DIR" 1
 
 # Make ISO9660 file system with different options.
 # Mount the ISO9660 file system with different mount options.
-- 
2.7.3


-- 
Cyril Hrubis
chrubis@suse.cz
