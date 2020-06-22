From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 22 Jun 2020 06:56:49 +0200
Subject: [LTP] [RESENT RFC PATCH 5/5] st_net.sh: tst_rhost_run: Add -d
 option (debug)
In-Reply-To: <20200622045649.5063-1-pvorel@suse.cz>
References: <20200622045649.5063-1-pvorel@suse.cz>
Message-ID: <20200622045649.5063-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

-d debug mode (print command and netns/ssh handling into stderr)

Add tst_net_debug() simple helper for printing into stderr.

Also use new parameter in tst_rhost_run.sh.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

RFC: I use it quite a lot, but not sure if needed.

Probably using $TST_NET_DEBUG instead of -d would be better.

If we merge "tst_test.sh: Print tst_{res, brk} into stdout" [1],
simple tst_res_ could be used. I was also thinking about adding new flag
"DEBUG", but that's probably not needed.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20200619192542.20113-1-pvorel@suse.cz/

 lib/newlib_tests/shell/net/tst_rhost_run.sh |  8 +++---
 testcases/lib/tst_net.sh                    | 29 ++++++++++++++++-----
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/lib/newlib_tests/shell/net/tst_rhost_run.sh b/lib/newlib_tests/shell/net/tst_rhost_run.sh
index 4c034a4ac..ebcd4ca03 100755
--- a/lib/newlib_tests/shell/net/tst_rhost_run.sh
+++ b/lib/newlib_tests/shell/net/tst_rhost_run.sh
@@ -10,14 +10,14 @@ do_test()
 {
 	local file="/etc/fstab"
 
-	tst_rhost_run -c 'which grep > /dev/null' || \
+	tst_rhost_run -d -c 'which grep > /dev/null' || \
 		tst_res TCONF "grep not found on rhost"
 
-	tst_rhost_run -c "[ -f $file ]" || \
+	tst_rhost_run -d -c "[ -f $file ]" || \
 		tst_res TCONF "$file not found on rhost"
 
-	tst_rhost_run -s -c "grep -q \"[^ ]\" $file"
-	tst_rhost_run -s -c "grep -q '[^ ]' $file"
+	tst_rhost_run -ds -c "grep -q \"[^ ]\" $file"
+	tst_rhost_run -ds -c "grep -q '[^ ]' $file"
 
 	tst_res TPASS "tst_rhost_run is working"
 }
diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 2ed570a6b..d6845618d 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -130,11 +130,17 @@ init_ltp_netspace()
 	tst_restore_ipaddr rhost
 }
 
+tst_net_debug()
+{
+	echo "DEBUG: $@" >&2
+}
+
 # Run command on remote host.
 # tst_rhost_run -c CMD [-b] [-s] [-u USER]
 # Options:
 # -b run in background
 # -c CMD specify command to run (this must be binary, not shell builtin/function)
+# -d debug mode (print command and netns/ssh handling into stderr)
 # -s safe option, if something goes wrong, will exit with TBROK
 # -u USER for ssh (default root)
 # RETURN: 0 on success, 1 on failure
@@ -143,16 +149,17 @@ tst_rhost_run()
 	local post_cmd=' || echo RTERR'
 	local user="root"
 	local ret=0
-	local cmd out output pre_cmd safe
+	local cmd debug out output pre_cmd rcmd sh_cmd safe use
 
 	local OPTIND
-	while getopts :bsc:u: opt; do
+	while getopts :bc:dsu: opt; do
 		case "$opt" in
 		b) [ "${TST_USE_NETNS:-}" ] && pre_cmd= || pre_cmd="nohup"
 		   post_cmd=" > /dev/null 2>&1 &"
 		   out="1> /dev/null"
 		;;
 		c) cmd="$OPTARG" ;;
+		d) debug=1 ;;
 		s) safe=1 ;;
 		u) user="$OPTARG" ;;
 		*) tst_brk_ TBROK "tst_rhost_run: unknown option: $OPTARG" ;;
@@ -166,14 +173,24 @@ tst_rhost_run()
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
-		output=$(ssh -n -q $user@$RHOST \
-			"$pre_cmd $cmd $post_cmd" $out 2>&1 || echo 'RTERR')
+		use="SSH"
+		rcmd="ssh -n -q $user@$RHOST"
 	fi
+
+	if [ "$debug" ]; then
+		tst_net_debug "tst_rhost_run: cmd: $cmd"
+		tst_net_debug "$use: $rcmd \"$sh_cmd\" $out 2>&1"
+	fi
+
+	output=$($rcmd "$sh_cmd" $out 2>&1 || echo 'RTERR')
+
 	echo "$output" | grep -q 'RTERR$' && ret=1
 	if [ $ret -eq 1 ]; then
 		output=$(echo "$output" | sed 's/RTERR//')
-- 
2.27.0

