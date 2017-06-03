From: Petr Vorel <pvorel@suse.cz>
Date: Sat,  3 Jun 2017 14:00:13 +0200
Subject: [LTP] [RFC PATCH v6 02/11] lib: Fix 'unbound variable' error in
	shell libraries
In-Reply-To: <20170603120022.13415-1-pvorel@suse.cz>
References: <20170603120022.13415-1-pvorel@suse.cz>
Message-ID: <20170603120022.13415-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Some distros have set shell option 'nounset' as default, which requires
to fix testing optional variables.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/test.sh     | 4 ++--
 testcases/lib/test_net.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

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
 
diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 08493558b..f93f67411 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -83,7 +83,7 @@ tst_rhost_run()
 
 	local output=
 	local ret=0
-	if [ -n "$TST_USE_SSH" ]; then
+	if [ -n "${TST_USE_SSH:-}" ]; then
 		output=`ssh -n -q $user@$RHOST "sh -c \
 			'$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
 	elif [ -n "$TST_USE_NETNS" ]; then
-- 
2.12.2

