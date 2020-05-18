From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 18 May 2020 15:01:31 +0200
Subject: [LTP] [PATCH 1/2] tst_test.sh: Fix calling not yet loaded cleanup
 function
Message-ID: <20200518130132.19312-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

e7dc14caa introduced a regression for new API network tests (these using
tst_net.sh), which use network namespaces and have cleanup function:

$ PATH="/opt/ltp/testcases/bin:$PATH" tcp_ipsec.sh -6 -A rfc4543_256 \
  -p esp_aead -m tunnel -s 100:1000:65535:R65535
tcp_ipsec 1 TCONF: Must be super/root for this test!
/opt/ltp/testcases/bin/tst_test.sh: line 32: tst_ipsec_cleanup: command not found

This is caused by tst_brk called in tst_net.sh test preparation (happen
just after loading tst_net.sh, that's why cleanup function haven't been
defined yet. This would require to load tst_net.sh just before tst_run.

But because tst_net.sh doesn't have it's own cleanup function
(tst_cleanup_rhost is always called in _tst_do_exit in tst_test.sh
regardless of setup/cleanup functions), we can assume that only after
starting the actual test code (i.e. running either setup or test
function) it's meaningful to run cleanup function.

This is effectively a revert of e7dc14caa + adding $TST_SETUP_STARTED.

Fixes: e7dc14caa ("tst_test.sh: Run cleanup even setup is not defined")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 8d24b4abf..aa74ad761 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -28,7 +28,8 @@ _tst_do_exit()
 	local ret=0
 	TST_DO_EXIT=1
 
-	if [ -n "$TST_CLEANUP" -a -z "$TST_NO_CLEANUP" ]; then
+	if [ -n "$TST_SETUP_STARTED" -a -n "$TST_RUN_STARTED" -a \
+		-n "$TST_CLEANUP" -a -z "$TST_NO_CLEANUP" ]; then
 		$TST_CLEANUP
 	fi
 
@@ -582,6 +583,7 @@ tst_run()
 	[ -n "$TST_NEEDS_MODULE" ] && tst_require_module "$TST_NEEDS_MODULE"
 
 	if [ -n "$TST_SETUP" ]; then
+		TST_SETUP_STARTED=1
 		$TST_SETUP
 	fi
 
@@ -592,9 +594,11 @@ tst_run()
 			_tst_max=$(( $(echo $TST_TEST_DATA | tr -cd "$TST_TEST_DATA_IFS" | wc -c) +1))
 			for _tst_i in $(seq $_tst_max); do
 				_tst_data="$(echo "$TST_TEST_DATA" | cut -d"$TST_TEST_DATA_IFS" -f$_tst_i)"
+				TST_RUN_STARTED=1
 				_tst_run_tests "$_tst_data"
 			done
 		else
+			TST_RUN_STARTED=1
 			_tst_run_tests
 		fi
 		TST_ITERATIONS=$((TST_ITERATIONS-1))
-- 
2.26.2

