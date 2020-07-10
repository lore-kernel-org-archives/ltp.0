From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Jul 2020 19:20:44 +0200
Subject: [LTP] [PATCH v2 7/7] tst_net.sh/tst_rhost_run: Add debugging
In-Reply-To: <20200710172044.21592-1-pvorel@suse.cz>
References: <20200710172044.21592-1-pvorel@suse.cz>
Message-ID: <20200710172044.21592-8-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

via TST_NET_RHOST_RUN_DEBUG=1 and use it in tst_rhost_run.sh.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v1->v2:
* Use TST_NET_RHOST_RUN_DEBUG=1 instead of -d in tst_rhost_run
This requires to whitelist it in tst_test.sh.
* use tst_res_ TINFO instead of tst_net_debug


Kind regards,
Petr

 lib/newlib_tests/shell/net/tst_rhost_run.sh |  2 ++
 testcases/lib/tst_net.sh                    | 23 +++++++++++++++------
 testcases/lib/tst_test.sh                   |  2 +-
 testcases/network/README.md                 |  3 +++
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/lib/newlib_tests/shell/net/tst_rhost_run.sh b/lib/newlib_tests/shell/net/tst_rhost_run.sh
index 4c034a4ac..9b058a57a 100755
--- a/lib/newlib_tests/shell/net/tst_rhost_run.sh
+++ b/lib/newlib_tests/shell/net/tst_rhost_run.sh
@@ -6,6 +6,8 @@ TST_TESTFUNC=do_test
 PATH="$(dirname $0)/../../../../testcases/lib/:$PATH"
 . tst_net.sh
 
+export TST_NET_RHOST_RUN_DEBUG=1
+
 do_test()
 {
 	local file="/etc/fstab"
diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index f6ac4c087..d939a5780 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -138,15 +138,16 @@ init_ltp_netspace()
 # -s safe option, if something goes wrong, will exit with TBROK
 # -u USER for ssh (default root)
 # RETURN: 0 on success, 1 on failure
+# TST_NET_RHOST_RUN_DEBUG=1 enables debugging
 tst_rhost_run()
 {
 	local post_cmd=' || echo RTERR'
 	local user="root"
 	local ret=0
-	local cmd out output pre_cmd safe
+	local cmd out output pre_cmd rcmd sh_cmd safe use
 
 	local OPTIND
-	while getopts :bsc:u: opt; do
+	while getopts :bc:su: opt; do
 		case "$opt" in
 		b) [ "${TST_USE_NETNS:-}" ] && pre_cmd= || pre_cmd="nohup"
 		   post_cmd=" > /dev/null 2>&1 &"
@@ -166,14 +167,24 @@ tst_rhost_run()
 		return 1
 	fi
 
+	sh_cmd="$pre_cmd $cmd $post_cmd"
+
 	if [ -n "${TST_USE_NETNS:-}" ]; then
-		output=$($LTP_NETNS sh -c \
-			"$pre_cmd $cmd $post_cmd" $out 2>&1 || echo 'RTERR')
+		use="NETNS"
+		rcmd="$LTP_NETNS sh -c"
 	else
 		tst_require_cmds ssh
-		output=$(ssh -nq $user@$RHOST \
-			"$pre_cmd $cmd $post_cmd" $out 2>&1 || echo 'RTERR')
+		use="SSH"
+		rcmd="ssh -nq $user@$RHOST"
+	fi
+
+	if [ "$TST_NET_RHOST_RUN_DEBUG" = 1 ]; then
+		tst_res_ TINFO "tst_rhost_run: cmd: $cmd"
+		tst_res_ TINFO "$use: $rcmd \"$sh_cmd\" $out 2>&1"
 	fi
+
+	output=$($rcmd "$sh_cmd" $out 2>&1 || echo 'RTERR')
+
 	echo "$output" | grep -q 'RTERR$' && ret=1
 	if [ $ret -eq 1 ]; then
 		output=$(echo "$output" | sed 's/RTERR//')
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 2e637b25b..fa97acbac 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -506,7 +506,7 @@ tst_run()
 			NEEDS_DRIVERS|FS_TYPE|MNTPOINT|MNT_PARAMS);;
 			IPV6|IPVER|TEST_DATA|TEST_DATA_IFS);;
 			RETRY_FUNC|RETRY_FN_EXP_BACKOFF|TIMEOUT);;
-			NET_DATAROOT|NET_MAX_PKT);;
+			NET_DATAROOT|NET_MAX_PKT|NET_RHOST_RUN_DEBUG);;
 			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
 			esac
 		done
diff --git a/testcases/network/README.md b/testcases/network/README.md
index 1c19a2c15..081ce834a 100644
--- a/testcases/network/README.md
+++ b/testcases/network/README.md
@@ -1,5 +1,8 @@
 # LTP Network Tests
 
+Both single and two host configurations support debugging via
+`TST_NET_RHOST_RUN_DEBUG=1` environment variable.
+
 ## Single Host Configuration
 
 It is the default configuration (if the `RHOST` environment variable is not
-- 
2.27.0

