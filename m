From: Petr Vorel <petr.vorel@suse.com>
Date: Mon, 22 Jun 2020 09:09:09 +0200
Subject: [LTP] [RESENT PATCH 3/5] tst_net.sh: Drop 'sh -c' use from ssh in
 tst_rhost_run
In-Reply-To: <20200622070911.16123-1-petr.vorel@suse.com>
References: <20200622070911.16123-1-petr.vorel@suse.com>
Message-ID: <20200622070911.16123-4-petr.vorel@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <pvorel@suse.cz>

This simplifies the command and allows to use double quotes in command
parameter for ssh, as it removes single nested quotes of command
parameter (thus fixes like c1a2d53f6 "network/nfs_lib.sh: Use double
quotes for grep pattern" are not needed any more).

NOTE: 'sh -c' is still required for netns based testing, but does not
use nested quotes. Now both variants use only double quotes.

Suggested-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 1b96b3bf4..2ed570a6b 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -167,12 +167,12 @@ tst_rhost_run()
 	fi
 
 	if [ -n "${TST_USE_NETNS:-}" ]; then
-		output=`$LTP_NETNS sh -c \
-			"$pre_cmd $cmd $post_cmd" $out 2>&1 || echo 'RTERR'`
+		output=$($LTP_NETNS sh -c \
+			"$pre_cmd $cmd $post_cmd" $out 2>&1 || echo 'RTERR')
 	else
 		tst_require_cmds ssh
-		output=`ssh -n -q $user@$RHOST "sh -c \
-			'$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
+		output=$(ssh -n -q $user@$RHOST \
+			"$pre_cmd $cmd $post_cmd" $out 2>&1 || echo 'RTERR')
 	fi
 	echo "$output" | grep -q 'RTERR$' && ret=1
 	if [ $ret -eq 1 ]; then
-- 
2.27.0

