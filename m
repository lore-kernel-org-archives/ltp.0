From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 20 Nov 2018 19:03:06 +0300
Subject: [LTP] [PATCH] lib/tst_test.sh: don't call _tst_do_exit()
	recursively with tst_brk()
Message-ID: <1542729786-4097-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

With this patch, "safe" functions such as "ROD" and "tst_rhost_run -s"
can be used in a test cleanup function, i.e. in case of an error, "safe"
command won't recursively call the cleanup function again but will only
print the warning message about the failure.

This behavior is consistent with the LTP C library.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/tst_test.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 16081fa..e84cf7f 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -41,6 +41,7 @@ trap "tst_brk TBROK 'test interrupted'" INT
 _tst_do_exit()
 {
 	local ret=0
+	TST_DO_EXIT=1
 
 	if [ -n "$TST_SETUP_STARTED" -a -n "$TST_CLEANUP" -a \
 	     -z "$TST_NO_CLEANUP" ]; then
@@ -123,6 +124,11 @@ tst_brk()
 	local res=$1
 	shift
 
+	if [ "$TST_DO_EXIT" = 1 ]; then
+		tst_res TWARN "$@"
+		return
+	fi
+
 	tst_res "$res" "$@"
 	_tst_do_exit
 }
-- 
1.7.1

