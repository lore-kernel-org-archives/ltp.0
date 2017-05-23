From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 23 May 2017 10:11:54 +0200
Subject: [LTP] [RFC PATCH 1/1] lib/test.sh: Fix 'unbound variable' error
Message-ID: <20170523081154.19326-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Some distros have set nounset as default, which requires to fix testing
optional variables.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
I don't want to disable check with 'set +o nounset' in each script, I think
it's actually quite good to have it. It just requires taking care when using
optional variables. But it might be better to set it at the top:
TST_NO_CLEANUP="${TST_NO_CLEANUP:-}"
LTP_IPC_PATH="${LTP_IPC_PATH:-}"
---
 testcases/lib/test.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index 2e4d86809..642f7eacf 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -103,11 +103,11 @@ tst_require_root()
 
 tst_exit()
 {
-	if [ -n "$TST_CLEANUP" -a -z "$TST_NO_CLEANUP" ]; then
+	if [ -n "${TST_CLEANUP:-}" -a -z "${TST_NO_CLEANUP:-}" ]; then
 		$TST_CLEANUP
 	fi
 
-	if [ -n "$LTP_IPC_PATH" -a -f "$LTP_IPC_PATH" ]; then
+	if [ -n "${LTP_IPC_PATH:-}" -a -f "${LTP_IPC_PATH:-}" ]; then
 		rm -f "$LTP_IPC_PATH"
 	fi
 
-- 
2.12.2

