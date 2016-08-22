From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 22 Aug 2016 16:53:28 +0300
Subject: [LTP] [PATCH] test.sh: add EXPECT_PASS, EXPECT_FAIL functions
Message-ID: <1471874008-19541-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Sometimes we need to execute a command and call tst_resm TPASS/TFAIL
based on the command's exit status.

The existing ROD() function can make 99% of the job, we just
need to let it know how the command's exit code should be
interpreted. This patch does it and introduces a couple of new
functions to help with the described situation.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
Changes since the RFC version:
 * Rename SHOULD_* -> EXPECT_*
 * Rename ROD_DISPATCHER -> ROD_BASE
 * Move '$?' checks into the callers of ROD_BASE
 * Pass $@ in the quoted form
 * Add documentation

 doc/test-writing-guidelines.txt |   15 +++++++++++++++
 testcases/lib/test.sh           |   27 ++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 650f8b5..740e90c 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1352,6 +1352,21 @@ Note the '>' is escaped with '\', this causes that the '>' and filename are
 passed to the 'ROD' function as parameters and the 'ROD' function contains
 code to split '$@' on '>' and redirects the output to the file.
 
+EXPECT_PASS and EXPECT_FAIL
++++++++++++++++++++++++++++
+
+[source,sh]
+-------------------------------------------------------------------------------
+EXPECT_PASS command arg1 arg2 ... [ \> file ]
+EXPECT_FAIL command arg1 arg2 ... [ \> file ]
+-------------------------------------------------------------------------------
+
+'EXPECT_PASS' calls 'tst_resm TPASS' if the command exited with 0 exit code,
+and 'tst_resm TFAIL' otherwise. 'EXPECT_FAIL' does vice versa.
+
+Output redirection rules are the same as for the 'ROD' function. In addition
+to that, 'EXPECT_FAIL' always redirects the command's stderr to '/dev/null'.
+
 .tst_fs_has_free
 [source,sh]
 -------------------------------------------------------------------------------
diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index bd66109..a1fa2d9 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -220,7 +220,7 @@ ROD_SILENT()
 	fi
 }
 
-ROD()
+ROD_BASE()
 {
 	local cmd
 	local arg
@@ -250,12 +250,37 @@ ROD()
 	else
 		$@
 	fi
+}
 
+ROD()
+{
+	ROD_BASE "$@"
 	if [ $? -ne 0 ]; then
 		tst_brkm TBROK "$@ failed"
 	fi
 }
 
+EXPECT_PASS()
+{
+	ROD_BASE "$@"
+	if [ $? -eq 0 ]; then
+		tst_resm TPASS "$@ passed as expected"
+	else
+		tst_resm TFAIL "$@ failed unexpectedly"
+	fi
+}
+
+EXPECT_FAIL()
+{
+	# redirect stderr since we expect the command to fail
+	ROD_BASE "$@" 2> /dev/null
+	if [ $? -ne 0 ]; then
+		tst_resm TPASS "$@ failed as expected"
+	else
+		tst_resm TFAIL "$@ passed unexpectedly"
+	fi
+}
+
 tst_acquire_device()
 {
 	if [ -z ${TST_TMPDIR} ]; then
-- 
1.7.1

