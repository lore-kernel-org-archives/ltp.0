From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 14 Sep 2018 18:02:09 +0300
Subject: [LTP] [PATCH v3 2/2] lib/tst_test.sh: add TST_NEEDS_DRIVERS
	parameter
In-Reply-To: <1536937329-13902-1-git-send-email-alexey.kodanev@oracle.com>
References: <1536937329-13902-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1536937329-13902-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The drivers are checked with 'tst_check_drivers' command.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v3: check the command exit status instead of the returned error message

v2: add a check for empty TST_NEEDS_DRIVERS

 doc/test-writing-guidelines.txt |    1 +
 testcases/lib/tst_test.sh       |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 78c524f..f590896 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1662,6 +1662,7 @@ simply by setting right '$TST_NEEDS_FOO'.
 | 'TST_NEEDS_CMDS'   | String with command names that has to be present for
                        the test (see below).
 | 'TST_NEEDS_MODULE' | Test module name needed for the test (see below).
+| 'TST_NEEDS_DRIVERS'| Checks kernel drivers support for the test.
 |=============================================================================
 
 Checking for presence of commands
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index faf3bd5..7a41309 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -302,6 +302,18 @@ tst_check_cmds()
 	return 0
 }
 
+tst_test_drivers()
+{
+	[ $# -eq 0 ] && return 0
+
+	local drv
+
+	drv="$(tst_check_drivers $@ 2>&1)"
+
+	[ $? -ne 0 ] && tst_brk TCONF "$drv driver not available"
+	return 0
+}
+
 tst_is_int()
 {
 	[ "$1" -eq "$1" ] 2>/dev/null
@@ -349,6 +361,7 @@ tst_run()
 			OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
 			NEEDS_ROOT|NEEDS_TMPDIR|NEEDS_DEVICE|DEVICE);;
 			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
+			NEEDS_DRIVERS);;
 			IPV6|IPVER|TEST_DATA|TEST_DATA_IFS);;
 			RETRY_FUNC|RETRY_FN_EXP_BACKOFF);;
 			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
@@ -386,6 +399,7 @@ tst_run()
 	fi
 
 	tst_test_cmds $TST_NEEDS_CMDS
+	tst_test_drivers $TST_NEEDS_DRIVERS
 
 	if [ -n "$TST_MIN_KVER" ]; then
 		tst_kvcmp -lt "$TST_MIN_KVER" && \
-- 
1.7.1

