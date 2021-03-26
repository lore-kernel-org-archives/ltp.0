From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Fri, 26 Mar 2021 09:41:37 +0800
Subject: [LTP] [PATCH] fs/iso9660: bugfix for iso9660/isofs.sh
Message-ID: <20210326014137.15718-1-zhanglianjie@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Debian uses genisoimage to replace mkisofs, the prompt of genisoimage
is the same as that of mkisofs.

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>
---
 testcases/kernel/fs/iso9660/isofs.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/iso9660/isofs.sh b/testcases/kernel/fs/iso9660/isofs.sh
index 9de3f7cdc..69ab6e357 100755
--- a/testcases/kernel/fs/iso9660/isofs.sh
+++ b/testcases/kernel/fs/iso9660/isofs.sh
@@ -12,6 +12,12 @@
 TST_NEEDS_CMDS="mkisofs"
 TST_NEEDS_TMPDIR=1
 TST_TESTFUNC=do_test
+which mkisofs >/dev/null 2>&1
+if [ $? -ne 0 ]; then
+       TST_NEEDS_CMDS="genisoimage"
+fi
+MKISOFS_CMD=$TST_NEEDS_CMDS
+
 . tst_test.sh

 MAX_DEPTH=3
@@ -56,7 +62,7 @@ do_test() {
 		"-allow-lowercase -allow-multidot -iso-level 3 -f -l -D -J -allow-leading-dots -R"
 	do
 		rm -f isofs.iso
-		EXPECT_PASS mkisofs -o isofs.iso -quiet $mkisofs_opt $make_file_sys_dir 2\> /dev/null \
+		EXPECT_PASS $MKISOFS_CMD -o isofs.iso -quiet $mkisofs_opt $make_file_sys_dir 2\> /dev/null \
 			|| continue

 		for mount_opt in \
--
2.20.1



