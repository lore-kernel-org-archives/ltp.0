From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 24 Aug 2020 13:21:09 +0200
Subject: [LTP] [PATCH v2 1/1] prepare_lvm.sh: Allow to define tmp directory
Message-ID: <20200824112109.2995-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Many distros don't have enough /tmp size for LVM tests, thus
allow to set $LVM_DIR to use different temporary directory.

Most of the space take backing files ($LVM_IMGDIR), but for consistency
changed both directories. $LVM_TMPDIR requires to update
generate_lvm_runfile.sh.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Update all required scripts

 testcases/misc/lvm/cleanup_lvm.sh          | 5 +++--
 testcases/misc/lvm/generate_lvm_runfile.sh | 4 +++-
 testcases/misc/lvm/prepare_lvm.sh          | 5 +++--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/testcases/misc/lvm/cleanup_lvm.sh b/testcases/misc/lvm/cleanup_lvm.sh
index e18efe2b0..03eb384be 100755
--- a/testcases/misc/lvm/cleanup_lvm.sh
+++ b/testcases/misc/lvm/cleanup_lvm.sh
@@ -9,8 +9,9 @@ TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="losetup umount vgremove"
 . tst_test.sh
 
-LVM_TMPDIR="/tmp/ltp/growfiles"
-LVM_IMGDIR="/tmp/ltp/imgfiles"
+LVM_DIR="${LVM_DIR:-/tmp}"
+LVM_TMPDIR="$LVM_DIR/ltp/growfiles"
+LVM_IMGDIR="$LVM_DIR/ltp/imgfiles"
 
 cleanup_lvm()
 {
diff --git a/testcases/misc/lvm/generate_lvm_runfile.sh b/testcases/misc/lvm/generate_lvm_runfile.sh
index 5ca035f22..a8388cf3d 100755
--- a/testcases/misc/lvm/generate_lvm_runfile.sh
+++ b/testcases/misc/lvm/generate_lvm_runfile.sh
@@ -9,6 +9,8 @@ TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="sed"
 . tst_test.sh
 
+LVM_DIR="${LVM_DIR:-/tmp}"
+
 generate_runfile()
 {
 	trap 'tst_brk TBROK "Cannot create LVM runfile"' ERR
@@ -20,7 +22,7 @@ generate_runfile()
 	for fsname in $FS_LIST; do
 		# Btrfs needs too much space for reliable stress testing
 		if [ "x$fsname" != "xbtrfs" ]; then
-			sed -e "s/{fsname}/$fsname/g" "$INFILE" >>"$OUTFILE"
+			sed -e "s/{fsname}/$fsname/g; s^/tmp/ltp^$LVM_DIR/ltp^g" "$INFILE" >>"$OUTFILE"
 		fi
 	done
 
diff --git a/testcases/misc/lvm/prepare_lvm.sh b/testcases/misc/lvm/prepare_lvm.sh
index e7f9c90e4..b6557f221 100755
--- a/testcases/misc/lvm/prepare_lvm.sh
+++ b/testcases/misc/lvm/prepare_lvm.sh
@@ -9,8 +9,9 @@ TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="mount pvcreate vgcreate lvcreate"
 . tst_test.sh
 
-LVM_TMPDIR="/tmp/ltp/growfiles"
-LVM_IMGDIR="/tmp/ltp/imgfiles"
+LVM_DIR="${LVM_DIR:-/tmp}"
+LVM_TMPDIR="$LVM_DIR/ltp/growfiles"
+LVM_IMGDIR="$LVM_DIR/ltp/imgfiles"
 
 error_check()
 {
-- 
2.28.0

