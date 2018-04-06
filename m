From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  6 Apr 2018 08:42:04 +0200
Subject: [LTP] [PATCH 1/1] tst_test.sh: Add test cmd helper tst_test_cmds()
Message-ID: <20180406064204.9252-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ tst_cmd_available()

tst_test_cmds() is meant to be a check just for a particular test.
Works like tst_check_cmds(), but instead of tst_brk() calls tst_res().

tst_cmd_available() helper can handle cases when command shell builtin
is not available (e.g. Busybox).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
You may don't like support for obscure shell with no command support (or
-v param for command which is IMHO not POSIX).
I introduced tst_cmd_available mainly for reducing duplicity, but it
might be useful anyway.

Kind regards,
Petr
---
 doc/test-writing-guidelines.txt | 17 +++++++++++++++++
 testcases/lib/tst_test.sh       | 22 ++++++++++++++++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index cbbfe6c0f..bf59a178c 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1519,6 +1519,23 @@ existence each of them and exits the test with 'TCONF' on first misssing.
 Alternatively the 'tst_check_cmds()' function can be used to do the same on
 runtime, since sometimes we need to the check at runtime too.
 
+'tst_test_cmds()' can be used for requirements just for a particular test
+as it doesn't exit. Supposed usage is:
+...
+
+TST_TESTFUNC=do_test
+. tst_test.sh
+
+do_test()
+{
+	tst_test_cmds cmd || return
+	cmd --foo
+	...
+}
+
+tst_run
+...
+
 Locating kernel modules
 +++++++++++++++++++++++
 
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 48afb9cc4..5ebe32edf 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -201,12 +201,30 @@ tst_mkfs()
 	ROD_SILENT mkfs.$fs_type $fs_opts $device
 }
 
+tst_cmd_available()
+{
+	if type command > /dev/null 2>&1; then
+		command -v $1 > /dev/null 2>&1 || return 1
+	else
+		which $1 > /dev/null 2>&1 || return 1
+	fi
+}
+
 tst_check_cmds()
 {
 	local cmd
 	for cmd in $*; do
-		if ! command -v $cmd > /dev/null 2>&1; then
-			tst_brk TCONF "'$cmd' not found"
+		tst_cmd_available $cmd || tst_brk TCONF "'$cmd' not found"
+	done
+}
+
+tst_test_cmds()
+{
+	local cmd
+	for cmd in $*; do
+		if ! tst_cmd_available $cmd; then
+			tst_res TCONF "'$cmd' not found"
+			return 1
 		fi
 	done
 }
-- 
2.16.2

