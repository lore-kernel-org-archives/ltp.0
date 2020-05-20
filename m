From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 20 May 2020 10:26:06 +0200
Subject: [LTP] [PATCH v3 1/2] tst_test.sh: Fix calling not yet loaded
 cleanup function
Message-ID: <20200520082607.25776-1-pvorel@suse.cz>
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
starting the actual test code (after tst_run start).

Fixes: e7dc14caa ("tst_test.sh: Run cleanup even setup is not defined")

Suggested-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v2->v3:
* simplify setup, inspired by Joerg

Kind regards,
Petr

 testcases/lib/tst_test.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 8d24b4abf..4f966df17 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -28,7 +28,9 @@ _tst_do_exit()
 	local ret=0
 	TST_DO_EXIT=1
 
-	if [ -n "$TST_CLEANUP" -a -z "$TST_NO_CLEANUP" ]; then
+	if [ -n "$TST_RUN_STARTED" -a -n "$TST_CLEANUP" -a \
+		-z "$TST_NO_CLEANUP" ]; then
+
 		$TST_CLEANUP
 	fi
 
@@ -495,6 +497,8 @@ tst_run()
 	local _tst_max
 	local _tst_name
 
+	TST_RUN_STARTED=1
+
 	if [ -n "$TST_TEST_PATH" ]; then
 		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed 's/.*TST_//; s/[="} \t\/:`].*//'); do
 			case "$_tst_i" in
-- 
2.26.2

