From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Aug 2021 12:08:23 +0200
Subject: [LTP] [PATCH v2 1/1] binfmt_misc02.sh: Use "command -v" instead of
 "which"
Message-ID: <20210818100823.1836-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

"which" has been discontinued after 2.21 release in 2015 due this (git
repository is empty [1]) it provides warning on Debian/Ubuntu [2].

Use "command -v" which is POSIX [3] and supported on all common shells
(bash, zsh, dash, busybox sh, mksh).

[1] https://git.savannah.gnu.org/cgit/which.git
[2] https://salsa.debian.org/debian/debianutils/-/commit/3a8dd10b4502f7bae8fc6973c13ce23fc9da7efb
[3] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/command.html

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* use "command -v" instead of "type" (we need cat path)
* save it into variable

 testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh b/testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh
index 9dbcd68cc..7bf4a0a2b 100755
--- a/testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh
+++ b/testcases/kernel/fs/binfmt_misc/binfmt_misc02.sh
@@ -19,7 +19,7 @@
 
 TST_CNT=6
 TST_TESTFUNC=do_test
-TST_NEEDS_CMDS="which cat head"
+TST_NEEDS_CMDS="cat head"
 
 . binfmt_misc_lib.sh
 
@@ -88,18 +88,20 @@ verify_binfmt_misc()
 
 do_test()
 {
+	local cat="$(command -v cat)"
+
 	case $1 in
-	1) verify_binfmt_misc ":textension:E::extension::$(which cat):" \
+	1) verify_binfmt_misc ":textension:E::extension::$cat:" \
 			      "$TST_DATAROOT/file.extension" "1";;
-	2) verify_binfmt_misc ":tmagic:M:1:This::$(which cat):" \
+	2) verify_binfmt_misc ":tmagic:M:1:This::$cat:" \
 			      "$TST_DATAROOT/file.magic" "1";;
-	3) verify_binfmt_misc ".textension.E..extension..$(which cat)." \
+	3) verify_binfmt_misc ".textension.E..extension..$cat." \
 			      "$TST_DATAROOT/file.extension" "1";;
-	4) verify_binfmt_misc ",tmagic,M,1,This,,$(which cat)," \
+	4) verify_binfmt_misc ",tmagic,M,1,This,,$cat," \
 			      "$TST_DATAROOT/file.magic" "1";;
-	5) verify_binfmt_misc ":textension:E::ltp::$(which cat):" \
+	5) verify_binfmt_misc ":textension:E::ltp::$cat:" \
 			      "$TST_DATAROOT/file.extension" "0";;
-	6) verify_binfmt_misc ":tmagic:M:0:This::$(which cat):" \
+	6) verify_binfmt_misc ":tmagic:M:0:This::$cat:" \
 			      "$TST_DATAROOT/file.magic" "0";;
 	esac
 }
-- 
2.32.0

