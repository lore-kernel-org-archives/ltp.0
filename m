From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Oct 2019 15:24:30 +0200
Subject: [LTP] [PATCH v5 5/8] shell: Introduce EXPECT_{FAIL,PASS}_BRK()
In-Reply-To: <20191011132433.24197-1-pvorel@suse.cz>
References: <20191011132433.24197-1-pvorel@suse.cz>
Message-ID: <20191011132433.24197-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/test-writing-guidelines.txt |  5 ++++-
 testcases/lib/tst_test.sh       | 34 +++++++++++++++++++++++++++++----
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 6da87baa7..722472800 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -2428,7 +2428,7 @@ Note the '>' is escaped with '\', this causes that the '>' and filename are
 passed to the 'ROD' function as parameters and the 'ROD' function contains
 code to split '$@' on '>' and redirects the output to the file.
 
-EXPECT_PASS and EXPECT_FAIL
+EXPECT_PASS{,_BRK} and EXPECT_FAIL{,_BRK}
 +++++++++++++++++++++++++++
 
 [source,sh]
@@ -2443,6 +2443,9 @@ and 'tst_resm TFAIL' otherwise. 'EXPECT_FAIL' does vice versa.
 Output redirection rules are the same as for the 'ROD' function. In addition
 to that, 'EXPECT_FAIL' always redirects the command's stderr to '/dev/null'.
 
+There are also 'EXPECT_PASS_BRK' and 'EXPECT_FAIL_BRK', which works the same way
+except breaking a test when unexpected action happen.
+
 tst_kvcmp
 +++++++++
 
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index e0b24c6b9..6b9374b2b 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -139,27 +139,53 @@ ROD()
 	fi
 }
 
-EXPECT_PASS()
+_tst_expect_pass()
 {
+	local fnc="$1"
+	shift
+
 	tst_rod "$@"
 	if [ $? -eq 0 ]; then
 		tst_res TPASS "$@ passed as expected"
 	else
-		tst_res TFAIL "$@ failed unexpectedly"
+		$fnc TFAIL "$@ failed unexpectedly"
 	fi
 }
 
-EXPECT_FAIL()
+_tst_expect_fail()
 {
+	local fnc="$1"
+	shift
+
 	# redirect stderr since we expect the command to fail
 	tst_rod "$@" 2> /dev/null
 	if [ $? -ne 0 ]; then
 		tst_res TPASS "$@ failed as expected"
 	else
-		tst_res TFAIL "$@ passed unexpectedly"
+		$fnc TFAIL "$@ passed unexpectedly"
 	fi
 }
 
+EXPECT_PASS()
+{
+	_tst_expect_pass tst_res "$@"
+}
+
+EXPECT_PASS_BRK()
+{
+	_tst_expect_pass tst_brk "$@"
+}
+
+EXPECT_FAIL()
+{
+	_tst_expect_fail tst_res "$@"
+}
+
+EXPECT_FAIL_BRK()
+{
+	_tst_expect_fail tst_brk "$@"
+}
+
 TST_RETRY_FN_EXP_BACKOFF()
 {
 	local tst_fun="$1"
-- 
2.23.0

