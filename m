From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Dec 2019 10:50:50 +0100
Subject: [LTP] [PATCH 1/1] tst_test.sh: Add return value to
 _tst_expect_{fail, pass}
Message-ID: <20191219095050.26106-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

And use this feature in isofs.sh.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

there'll be probably more uses than just isofs.sh.
I can put isofs.sh changes into separate commit.

Kind regards,
Petr

 doc/test-writing-guidelines.txt      | 8 ++++++++
 testcases/kernel/fs/iso9660/isofs.sh | 9 ++-------
 testcases/lib/tst_test.sh            | 4 ++++
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 79d857fea..88f771823 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -2465,6 +2465,14 @@ to that, 'EXPECT_FAIL' always redirects the command's stderr to '/dev/null'.
 There are also 'EXPECT_PASS_BRK' and 'EXPECT_FAIL_BRK', which works the same way
 except breaking a test when unexpected action happen.
 
+It's possible to detect whether expected value happened:
+[source,sh]
+-------------------------------------------------------------------------------
+if ! EXPECT_PASS command arg1 2\> /dev/null; then
+	continue
+fi
+-------------------------------------------------------------------------------
+
 tst_kvcmp
 +++++++++
 
diff --git a/testcases/kernel/fs/iso9660/isofs.sh b/testcases/kernel/fs/iso9660/isofs.sh
index 781ccdc88..9de3f7cdc 100755
--- a/testcases/kernel/fs/iso9660/isofs.sh
+++ b/testcases/kernel/fs/iso9660/isofs.sh
@@ -56,13 +56,8 @@ do_test() {
 		"-allow-lowercase -allow-multidot -iso-level 3 -f -l -D -J -allow-leading-dots -R"
 	do
 		rm -f isofs.iso
-		mkisofs -o isofs.iso -quiet $mkisofs_opt $make_file_sys_dir 2> /dev/null
-		if [ $? -eq 0 ]; then
-			tst_res TPASS "mkisofs -o isofs.iso -quiet $mkisofs_opt $make_file_sys_dir"
-		else
-			tst_res TFAIL "mkisofs -o isofs.iso -quiet $mkisofs_opt $make_file_sys_dir"
-			continue
-		fi
+		EXPECT_PASS mkisofs -o isofs.iso -quiet $mkisofs_opt $make_file_sys_dir 2\> /dev/null \
+			|| continue
 
 		for mount_opt in \
 			"loop" \
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index e0265c1d1..b98f86e8e 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -146,8 +146,10 @@ _tst_expect_pass()
 	tst_rod "$@"
 	if [ $? -eq 0 ]; then
 		tst_res TPASS "$@ passed as expected"
+		return 0
 	else
 		$fnc TFAIL "$@ failed unexpectedly"
+		return 1
 	fi
 }
 
@@ -160,8 +162,10 @@ _tst_expect_fail()
 	tst_rod "$@" 2> /dev/null
 	if [ $? -ne 0 ]; then
 		tst_res TPASS "$@ failed as expected"
+		return 0
 	else
 		$fnc TFAIL "$@ passed unexpectedly"
+		return 1
 	fi
 }
 
-- 
2.24.0

