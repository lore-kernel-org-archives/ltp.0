From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Tue, 23 Feb 2021 22:03:23 +0800
Subject: [LTP] [PATCH] unshare01.sh: Setup parent mount flag before unshare
 testing
Message-ID: <20210223140323.126555-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We need setup parent mount flag to shared before unshare testing, or it will
fail for system which has no systemd service since the propagation flag is
changed by systemd. From man 7 mount_namespaces.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/commands/unshare/unshare01.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/testcases/commands/unshare/unshare01.sh b/testcases/commands/unshare/unshare01.sh
index bf163a7f4..e1fb15035 100755
--- a/testcases/commands/unshare/unshare01.sh
+++ b/testcases/commands/unshare/unshare01.sh
@@ -31,7 +31,6 @@ TST_SETUP=setup
 TST_CLEANUP=cleanup
 TST_TESTFUNC=do_test
 TST_NEEDS_ROOT=1
-TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="unshare id mount umount"
 . tst_test.sh

@@ -39,6 +38,7 @@ max_userns_path="/proc/sys/user/max_user_namespaces"
 max_mntns_path="/proc/sys/user/max_mnt_namespaces"
 default_max_userns=-1
 default_max_mntns=-1
+CURR=$(pwd)

 setup()
 {
@@ -55,6 +55,10 @@ setup()
 		echo 1024 > "${max_mntns_path}"
 	fi

+	mkdir $CURR/dir_C
+	mount -t tmpfs none dir_C
+	mount --make-shared dir_C
+	cd dir_C
 	mkdir -p dir_A dir_B
 	touch dir_A/A dir_B/B
 }
@@ -66,6 +70,9 @@ cleanup()
 		echo ${default_max_userns} > "${max_userns_path}"
 	[ ${default_max_mntns} -ne -1 ] && \
 		echo ${default_max_mntns} > "${max_mntns_path}"
+	cd $CURR
+	umount dir_C
+	rm -rf dir_C
 }

 check_id()
--
2.17.1

