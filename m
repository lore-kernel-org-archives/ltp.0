From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 22 Feb 2019 17:59:55 +0800
Subject: [LTP] [PATCH 1/2] fs/binfmt_misc_lib.sh: Add common
	remove_binary_type()
Message-ID: <1550829596-17619-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Add common remove_binary_type() so that we can remove the
   registered binary type by it.
2) Take use of remove_binary_type() in binfmt_misc01.sh.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/fs/binfmt_misc/binfmt_misc01.sh   | 7 ++-----
 testcases/kernel/fs/binfmt_misc/binfmt_misc_lib.sh | 9 +++++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/fs/binfmt_misc/binfmt_misc01.sh b/testcases/kernel/fs/binfmt_misc/binfmt_misc01.sh
index 6c9aa64..06106e8 100755
--- a/testcases/kernel/fs/binfmt_misc/binfmt_misc01.sh
+++ b/testcases/kernel/fs/binfmt_misc/binfmt_misc01.sh
@@ -42,11 +42,8 @@ verify_binfmt_misc()
 	cat "$mntpoint/$name" >/dev/null 2>&1
 	tst_res TFAIL "Register a binary type successfully"
 
-	if [ -f "$mntpoint/$name" ]; then
-		(echo -1 >"$mntpoint/$name") 2>/dev/null
-		[ $? -ne 0 -o -f "$mntpoint/$name" ] && \
-			tst_res TWARN "Failed to remove a binary type"
-	fi
+	[ -f "$mntpoint/$name" ] && \
+		remove_binary_type "$mntpoint/$name"
 }
 
 do_test()
diff --git a/testcases/kernel/fs/binfmt_misc/binfmt_misc_lib.sh b/testcases/kernel/fs/binfmt_misc/binfmt_misc_lib.sh
index 5d00ab6..4976825 100755
--- a/testcases/kernel/fs/binfmt_misc/binfmt_misc_lib.sh
+++ b/testcases/kernel/fs/binfmt_misc/binfmt_misc_lib.sh
@@ -17,6 +17,15 @@ rmod_binfmt_misc=0
 umount_binfmt_misc=0
 binfmt_misc_mntpoint="ltp_binfmt_misc"
 
+remove_binary_type()
+{
+	local name=$1
+
+	(echo -1 >"$name") 2>/dev/null
+	[ $? -ne 0 -o -f "$name" ] && \
+		tst_res TWARN "Fail to remove a binary type"
+}
+
 get_binfmt_misc_mntpoint()
 {
 	local mntpoint
-- 
1.8.3.1



