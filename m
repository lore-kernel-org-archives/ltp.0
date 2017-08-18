From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 18 Aug 2017 18:44:31 +0200
Subject: [LTP] [RFC PATCH v8 05/11] lib/test_net.sh: tst_rhost_run: Add
	testcases/bin into PATH for SSH/RSH
In-Reply-To: <20170818164437.13556-1-pvorel@suse.cz>
References: <20170818164437.13556-1-pvorel@suse.cz>
Message-ID: <20170818164437.13556-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/test_net.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 1357ea5b5..c4399f637 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -55,7 +55,6 @@ init_ltp_netspace()
 # -b run in background
 # -s safe option, if something goes wrong, will exit with TBROK
 # -c specify command to run
-
 tst_rhost_run()
 {
 	local pre_cmd=
@@ -91,15 +90,16 @@ tst_rhost_run()
 
 	local output=
 	local ret=0
+	local newpath="$LTPROOT/testcases/bin"
 	if [ -n "${TST_USE_SSH:-}" ]; then
-		output=`ssh -n -q $user@$RHOST "sh -c \
-			'$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
+		output=`ssh -n -q $user@$RHOST "PATH=$newpath:\$PATH \
+			sh -c '$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
 	elif [ -n "$TST_USE_NETNS" ]; then
 		output=`$LTP_NETNS sh -c \
 			"$pre_cmd $cmd $post_cmd" $out 2>&1 || echo 'RTERR'`
 	else
-		output=`rsh -n -l $user $RHOST "sh -c \
-			'$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
+		output=`rsh -n -l $user $RHOST "PATH=$newpath:\$PATH \
+			sh -c '$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
 	fi
 	echo "$output" | grep -q 'RTERR$' && ret=1
 	if [ $ret -eq 1 ]; then
-- 
2.13.2

