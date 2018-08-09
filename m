From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  9 Aug 2018 18:23:44 +0300
Subject: [LTP] [PATCH RFC 2/4] lib/tst_test.sh: add TST_NEEDS_DRIVERS
	parameter
In-Reply-To: <1533828226-24753-1-git-send-email-alexey.kodanev@oracle.com>
References: <1533828226-24753-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1533828226-24753-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The drivers are checked with tst_check_drivers.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/tst_test.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index e553b49..30f75b5 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -285,6 +285,15 @@ tst_check_cmds()
 	return 0
 }
 
+tst_test_drivers()
+{
+	local drv="$(tst_check_drivers $@ 2>&1)"
+
+	if [ -n "$drv" ]; then
+		tst_brk TCONF "'$drv' driver not found"
+	fi
+}
+
 tst_is_int()
 {
 	[ "$1" -eq "$1" ] 2>/dev/null
@@ -332,6 +341,7 @@ tst_run()
 			OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
 			NEEDS_ROOT|NEEDS_TMPDIR|NEEDS_DEVICE|DEVICE);;
 			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
+			NEEDS_DRIVERS);;
 			IPV6|IPVER|TEST_DATA|TEST_DATA_IFS);;
 			RETRY_FUNC|RETRY_FN_EXP_BACKOFF);;
 			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
@@ -369,6 +379,7 @@ tst_run()
 	fi
 
 	tst_test_cmds $TST_NEEDS_CMDS
+	tst_test_drivers $TST_NEEDS_DRIVERS
 
 	if [ -n "$TST_MIN_KVER" ]; then
 		tst_kvcmp -lt "$TST_MIN_KVER" && \
-- 
1.7.1

