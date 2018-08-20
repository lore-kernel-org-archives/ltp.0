From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 20 Aug 2018 14:23:47 +0300
Subject: [LTP] [PATCH v2 2/4] lib/tst_test.sh: add TST_NEEDS_DRIVERS
	parameter
In-Reply-To: <1534764229-26993-1-git-send-email-alexey.kodanev@oracle.com>
References: <1534764229-26993-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1534764229-26993-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The drivers are checked with 'tst_check_drivers' command.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v2: add a check for empty TST_NEEDS_DRIVERS

 doc/test-writing-guidelines.txt |    1 +
 testcases/lib/tst_test.sh       |   12 ++++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 7a458d5..8ebff5f 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1653,6 +1653,7 @@ simply by setting right '$TST_NEEDS_FOO'.
 | 'TST_NEEDS_CMDS'   | String with command names that has to be present for
                        the test (see below).
 | 'TST_NEEDS_MODULE' | Test module name needed for the test (see below).
+| 'TST_NEEDS_DRIVERS'| Checks kernel drivers support for the test.
 |=============================================================================
 
 Checking for presence of commands
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index e553b49..23d66eb 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -285,6 +285,16 @@ tst_check_cmds()
 	return 0
 }
 
+tst_test_drivers()
+{
+	[ $# -eq 0 ] && return 0
+
+	local drv="$(tst_check_drivers $@ 2>&1)"
+
+	[ -n "$drv" ] && tst_brk TCONF "$drv driver not available"
+	return 0
+}
+
 tst_is_int()
 {
 	[ "$1" -eq "$1" ] 2>/dev/null
@@ -332,6 +342,7 @@ tst_run()
 			OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
 			NEEDS_ROOT|NEEDS_TMPDIR|NEEDS_DEVICE|DEVICE);;
 			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
+			NEEDS_DRIVERS);;
 			IPV6|IPVER|TEST_DATA|TEST_DATA_IFS);;
 			RETRY_FUNC|RETRY_FN_EXP_BACKOFF);;
 			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
@@ -369,6 +380,7 @@ tst_run()
 	fi
 
 	tst_test_cmds $TST_NEEDS_CMDS
+	tst_test_drivers $TST_NEEDS_DRIVERS
 
 	if [ -n "$TST_MIN_KVER" ]; then
 		tst_kvcmp -lt "$TST_MIN_KVER" && \
-- 
1.7.1

