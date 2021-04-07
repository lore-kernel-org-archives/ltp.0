From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Wed,  7 Apr 2021 10:31:29 +0800
Subject: [LTP] [PATCH] bugfix for iso9660/isofs.sh
Message-ID: <20210407023129.13248-1-zhanglianjie@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
...
<Well, bullseye is stable. But ok, some people might care about oldstable (we
<test it built LTP in Travis) and even oldoldstable.
<
<Actually, this depends on which (take look on tst_cmd_available(), it also uses
<command and trying to use which only if missing). And also it's misleading to
<suggest to use only genisoimage.
<
<Although for our documentation ("docparse"), it'd be better to use
<TST_NEEDS_CMDS, until (if ever) shell API supports logical OR (e.g.
<TST_NEEDS_CMDS="mkisofs|genisoimage") it'd be better to avoid TST_NEEDS_CMDS and
<decide in the setup. Thus if you don't mind I'll merge this fix with you as an author:
<
<setup()
<{
<if ! tst_cmd_available mkisofs && ! tst_cmd_available genisoimage; then
<tst_brk TCONF "please install mkisofs or genisoimage"
<fi
<}

Thank you very much for your guidance, but I want to submit it myself. 
Because this is the first time I submit a patch in the community.

---
 testcases/kernel/fs/iso9660/isofs.sh | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/fs/iso9660/isofs.sh b/testcases/kernel/fs/iso9660/isofs.sh
index 9de3f7cdc..c0e2d1ff8 100755
--- a/testcases/kernel/fs/iso9660/isofs.sh
+++ b/testcases/kernel/fs/iso9660/isofs.sh
@@ -9,14 +9,26 @@
 # It makes ISO9660 file system with different options and also
 # mounts ISO9660 file system with different mount options.

-TST_NEEDS_CMDS="mkisofs"
 TST_NEEDS_TMPDIR=1
 TST_TESTFUNC=do_test
+TST_SETUP=setup
+
 . tst_test.sh

 MAX_DEPTH=3
 MAX_DIRS=4

+setup()
+{
+	if tst_cmd_available mkisofs; then
+		MKISOFS_CMD="mkisofs"
+	elif tst_cmd_available genisoimage; then
+		MKISOFS_CMD="genisoimage"
+	else
+		tst_brk TCONF "please install mkisofs or genisoimage"
+	fi
+}
+
 gen_fs_tree()
 {
 	local cur_path="$1"
@@ -56,7 +68,7 @@ do_test() {
 		"-allow-lowercase -allow-multidot -iso-level 3 -f -l -D -J -allow-leading-dots -R"
 	do
 		rm -f isofs.iso
-		EXPECT_PASS mkisofs -o isofs.iso -quiet $mkisofs_opt $make_file_sys_dir 2\> /dev/null \
+		EXPECT_PASS $MKISOFS_CMD -o isofs.iso -quiet $mkisofs_opt $make_file_sys_dir 2\> /dev/null \
 			|| continue

 		for mount_opt in \
--
2.20.1


